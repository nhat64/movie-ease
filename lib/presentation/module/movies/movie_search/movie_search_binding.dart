import 'package:base_flutter/presentation/module/movies/movie_search/movie_search_controller.dart';
import 'package:get/get.dart';

class MovieSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MovieSearchController>(MovieSearchController());
  }
}
