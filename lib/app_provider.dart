import 'package:base_flutter/app/base/helper/log.dart';
import 'package:base_flutter/app/base/mvvm/model/source/local/local_storage.dart';
import 'package:base_flutter/app/base/mvvm/model/source/network/api_result.dart';
import 'package:base_flutter/app/base/widget_common/custom_snack_bar.dart';
import 'package:base_flutter/data/entity/movie_entity.dart';
import 'package:base_flutter/data/entity/profile_entity.dart';
import 'package:base_flutter/data/repositories/movie_repository.dart';
import 'package:base_flutter/data/repositories/profile_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class AppProvider {
  final rootNavigatorKey = GlobalKey<NavigatorState>();

  RxList<MovieEntity> showingMovies = <MovieEntity>[].obs;
  RxList<MovieEntity> comingMovies = <MovieEntity>[].obs;

  Rx<ProfileEntity?> userData = Rx(null);

  bool get isAuth => userData.value != null;

  updateUserData(ProfileEntity user) {
    userData.value = user;
  }

  removeUserData() {
    userData.value = null;
    LocalStorage.removeSharedPrefrences(LocalStorageKeys.accessToken);
  }

  Rx<Position?> position = Rx<Position?>(null);

  determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      Log.console('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.

        Log.console('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.

      Log.console('Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    Position tmpPosition = await Geolocator.getCurrentPosition(locationSettings: locationSettings);

    Log.console('tmpPosition: ${tmpPosition.latitude} - ${tmpPosition.longitude}');

    position.value = tmpPosition;
  }

  callApiGetListMovie({int? videoStatus}) async {
    final movieRepository = MovieRepository();
    final rs = await movieRepository.getMovies(statusShow: videoStatus);

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

  getApiProfile() async {
    String? token = LocalStorage.getString(LocalStorageKeys.accessToken);

    if (token == null) return;

    final profileRepos = ProfileRepository();

    final ApiResult rs = await profileRepos.getProfile();

    bool isSuccess = await rs.when(
      apiSuccess: (res) async {
        if (res.status == 200) {
          final profile = ProfileEntity.fromJson(res.data);
          updateUserData(profile);
          return true;
        } else {
          return false;
        }
      },
      apiFailure: (error) async {
        if (error is DioException) {
          if (error.response?.statusCode == 401) {
            showCustomSnackBar(title: 'Thông báo', message: 'Phiên đăng nhập hết hạn, vui lòng đăng nhập lại');
          }
        }
        return false;
      },
    );

    return isSuccess;
  }
}
