import 'package:base_flutter/app/base/helper/log.dart';
import 'package:base_flutter/data/page_data/all_comment_page_data.dart';
import 'package:base_flutter/presentation/module/movies/all_comment/all_comment_controller.dart';
import 'package:get/get.dart';

class AllCommentBinding extends Bindings {
  @override
  void dependencies() {
    final arg = Get.arguments;

    if (arg is AllCommentPageData) {
      Get.lazyPut<AllCommentController>(() => AllCommentController(movie: arg.movie, listComment: arg.listComment));
    } else {
      Log.console('AllCommentBinding: args is not AllCommentPageData');
    }
  }
}
