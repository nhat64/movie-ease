import 'package:base_flutter/app/base/helper/log.dart';
import 'package:base_flutter/data/page_data/create_comment_page_data.dart';
import 'package:base_flutter/presentation/module/movies/create_comment/create_comment_controller.dart';
import 'package:get/get.dart';

class CreateCommentBinding extends Bindings {
  @override
  void dependencies() {
    final arg = Get.arguments;

    if (arg is CreateCommentPageData) {
      Get.lazyPut<CreateCommentController>(() => CreateCommentController(movie: arg.movie, comment: arg.comment));
    } else {
      Log.console('CreateCommentController: args is not CreateCommentPageData');
    }
  }
}
