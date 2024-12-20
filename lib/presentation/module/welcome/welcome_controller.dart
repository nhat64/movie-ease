import 'package:base_flutter/app/base/helper/log.dart';
import 'package:base_flutter/app/base/mvvm/model/source/local/local_storage.dart';
import 'package:base_flutter/app/base/mvvm/model/source/network/api_result.dart';
import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/app/base/widget_common/call_api_widget.dart';
import 'package:base_flutter/data/entity/movie_entity.dart';
import 'package:base_flutter/data/entity/profile_entity.dart';
import 'package:base_flutter/data/repositories/movie_repository.dart';
import 'package:base_flutter/data/repositories/profile_repository.dart';
import 'package:base_flutter/presentation/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeController extends BaseController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;

  final MovieRepository _movieRepository = MovieRepository();

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    fadeAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );
  }

  @override
  void onReady() {
    animationController.forward();
    Future.delayed(
      const Duration(milliseconds: 1600),
      () async {
        await _initData();
        await appProvider.determinePosition();
        Get.offNamed(RouteName.root);
      },
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  _initData() async {
    appProvider.showingMovies.value = await _callApiGetListMovie(videoStatus: 1);

    appProvider.comingMovies.value = await _callApiGetListMovie(videoStatus: 2);

    await _getProfile();
  }

  _callApiGetListMovie({int? videoStatus}) async {
    final rs = await _movieRepository.getMovies(statusShow: videoStatus);

    List<MovieEntity> tmpMovies = [];

    await rs.when(
      apiSuccess: (res) async {
        tmpMovies = (res.data as List).map((e) => MovieEntity.fromJson(e)).toList();
      },
      apiFailure: (error) async {
        Log.console('error: $error');
      },
    );

    return tmpMovies;
  }

  _getProfile() async {
    String? token = LocalStorage.getString(LocalStorageKeys.accessToken);

    if (token == null) return;

    final profileRepos = ProfileRepository();

    final ApiResult rs = await CallApiWidget.checkTimeCallApi(api: profileRepos.getProfile(), context: Get.context!);

    bool isSuccess = await rs.when(
      apiSuccess: (res) async {
        if (res.status == 200) {
          final profile = ProfileEntity.fromJson(res.data);
          appProvider.updateUserData(profile);
          return true;
        } else {
          return false;
        }
      },
      apiFailure: (error) async {
        return false;
      },
    );

    return isSuccess;
  }
}
