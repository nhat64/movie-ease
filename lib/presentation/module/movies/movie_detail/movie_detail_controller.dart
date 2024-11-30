import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/data/entity/movie_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieDetailController extends BaseController {
  final MovieEntity movie;

  MovieDetailController({required this.movie});

  final ScrollController scrollController = ScrollController();

  RxBool isCollapsed = false.obs;
}
