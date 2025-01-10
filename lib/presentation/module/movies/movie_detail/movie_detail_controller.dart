import 'package:base_flutter/app/base/helper/log.dart';
import 'package:base_flutter/app/base/mvvm/model/source/network/api_result.dart';
import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/app/base/widget_common/call_api_widget.dart';
import 'package:base_flutter/data/entity/comment_entity.dart';
import 'package:base_flutter/data/entity/movie_entity.dart';
import 'package:base_flutter/data/repositories/movie_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieDetailController extends BaseController {
  final MovieEntity movie;

  MovieDetailController({required this.movie});

  final _movieRepository = MovieRepository();

  final ScrollController scrollController = ScrollController();

  Rx<MovieEntity?> movieDetail = Rx(null);
  RxList<CommentEntity> listComment = <CommentEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  fetchData() {
    getMovieDetail();
    getListComment();
  }

  getMovieDetail() async {
    final ApiResult result = await _movieRepository.getMovieDetail(movie.id);

    await result.when(
      apiSuccess: (res) async {
        if (res.status == 200) {
          final MovieEntity tmp = MovieEntity.fromJson(res.data);
          movieDetail.value = tmp;
        } else {
          Get.snackbar('Error', res.message);
        }
      },
      apiFailure: (error) async {
        Get.snackbar('Error', error.toString());
      },
    );
  }

  getListComment() async {
    final ApiResult result = await _movieRepository.getListComment(movie.id);

    await result.when(
      apiSuccess: (res) async {
        if (res.status == 200) {
          final List<CommentEntity> tmp = List<CommentEntity>.from(res.data.map((x) => CommentEntity.fromJson(x)));
          listComment.value = tmp;
          Log.console('getListComment: ${listComment.length}');
        } else {
          Get.snackbar('Error', res.message);
        }
      },
      apiFailure: (error) async {
        Get.snackbar('Error', error.toString());
      },
    );
  }

  deleteComment(int id) async {
    CallApiWidget.showLoading(context: Get.context!);

    final ApiResult result = await _movieRepository.deleteComment(id);

    bool isSuccess = await result.when(
      apiSuccess: (res) async {
        if (res.status == 200) {
          return true;
        } else {
          Get.snackbar('Error', res.message);
          return false;
        }
      },
      apiFailure: (error) async {
        Get.snackbar('Error', error.toString());
        return false;
      },
    );

    if (isSuccess) {
      await getMovieDetail();
      await getListComment();
      Get.snackbar('Success', 'Xoá thành công');
    }

    CallApiWidget.hideLoading();
  }
}
