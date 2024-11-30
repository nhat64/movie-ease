import 'package:base_flutter/data/entity/movie_entity.dart';
import 'package:base_flutter/presentation/module/movies/movie_detail/movie_detail_controller.dart';
import 'package:get/get.dart';

class MovieDetailBinding extends Bindings {
  @override
  void dependencies() {
    final MovieEntity movie = Get.arguments as MovieEntity;
    Get.put<MovieDetailController>(MovieDetailController(movie: movie));
  }
}
