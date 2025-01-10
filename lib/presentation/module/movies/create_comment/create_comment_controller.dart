import 'package:base_flutter/app/base/mvvm/model/source/network/api_result.dart';
import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/app/base/widget_common/call_api_widget.dart';
import 'package:base_flutter/data/entity/comment_entity.dart';
import 'package:base_flutter/data/entity/movie_entity.dart';
import 'package:base_flutter/data/repositories/movie_repository.dart';
import 'package:base_flutter/presentation/module/movies/all_comment/all_comment_controller.dart';
import 'package:base_flutter/presentation/module/movies/movie_detail/movie_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateCommentController extends BaseController {
  final MovieEntity movie;
  final CommentEntity? comment;

  CreateCommentController({
    required this.movie,
    this.comment,
  });

  final _movieRepository = MovieRepository();

  final textController = TextEditingController();
  final focusNode = FocusNode();

  RxInt rating = 0.obs;

  @override
  void onInit() {
    super.onInit();
    if (comment != null) {
      textController.text = comment!.comment ?? '';
      rating.value = comment!.voteStar ?? 0;
    }
  }

  onCreate() async {
    final ApiResult result = await CallApiWidget.checkTimeCallApi(
      api: _movieRepository.postComment(
        movieId: movie.id,
        rating: rating.value,
        content: textController.text,
      ),
      context: Get.context!,
    );

    await result.when(
      apiSuccess: (res) async {
        if (res.status == 200) {
          if (Get.isRegistered<MovieDetailController>()) {
            Get.find<MovieDetailController>().fetchData();
          }

          if (Get.isRegistered<AllCommentController>()) {
            Get.find<AllCommentController>().refesh();
          }
          Get.back();
          Future.delayed(const Duration(milliseconds: 500), () {
            Get.snackbar('Success', 'Đánh giá thành công !');
          });
        } else {
          Get.snackbar('Error', res.message);
        }
      },
      apiFailure: (error) async {
        Get.snackbar('Error', error.toString());
      },
    );
  }
}
