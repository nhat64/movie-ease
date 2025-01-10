import 'package:base_flutter/app/base/mvvm/model/source/network/api_result.dart';
import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/app/base/widget_common/call_api_widget.dart';
import 'package:base_flutter/data/entity/comment_entity.dart';
import 'package:base_flutter/data/entity/movie_entity.dart';
import 'package:base_flutter/data/repositories/movie_repository.dart';
import 'package:base_flutter/presentation/module/movies/movie_detail/movie_detail_controller.dart';
import 'package:get/get.dart';

class AllCommentController extends BaseController {
  final MovieEntity movie;
  final List<CommentEntity> listComment;

  Rx<int> ratingFilter = 0.obs;
  RxList<CommentEntity> listCommentFetch = <CommentEntity>[].obs;
  RxList<CommentEntity> listCommentFilter = <CommentEntity>[].obs;

  final _movieRepository = MovieRepository();

  AllCommentController({
    required this.movie,
    required this.listComment,
  });

  @override
  onInit() {
    super.onInit();
    fetchComment();
  }

  refesh() {
    fetchComment();
  }

  fetchComment() async {
    final ApiResult result = await _movieRepository.getListComment(movie.id);

    await result.when(
      apiSuccess: (res) async {
        if (res.status == 200) {
          final List<CommentEntity> tmp = List<CommentEntity>.from(res.data.map((x) => CommentEntity.fromJson(x)));
          listCommentFetch.value = tmp;
          listCommentFilter.value = tmp;
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
      await refesh();
      if (Get.isRegistered<MovieDetailController>()) {
        await Get.find<MovieDetailController>().fetchData();
      }

      Get.snackbar('Success', 'Xoá thành công');
    }

    CallApiWidget.hideLoading();
  }

  onFilter(int value) {
    ratingFilter.value = value;

    switch (value) {
      case 0:
        listCommentFilter.value = listComment;
        break;
      case 1:
        listCommentFilter.value = listComment.where((element) => element.voteStar == 1).toList();
        break;
      case 2:
        listCommentFilter.value = listComment.where((element) => element.voteStar == 2).toList();
        break;
      case 3:
        listCommentFilter.value = listComment.where((element) => element.voteStar == 3).toList();
        break;
      case 4:
        listCommentFilter.value = listComment.where((element) => element.voteStar == 4).toList();
        break;
      case 5:
        listCommentFilter.value = listComment.where((element) => element.voteStar == 5).toList();
        break;
    }
  }
}
