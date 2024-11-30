import 'package:base_flutter/presentation/module/movies/play_trailer/play_trailer_controller.dart';
import 'package:get/get.dart';

class PlayTrailerBinding extends Bindings {
  @override
  void dependencies() {
    String youtubeLink = Get.arguments as String;
    Get.put<PlayTrailerController>(PlayTrailerController(youtubeLink: youtubeLink));
  }
}
