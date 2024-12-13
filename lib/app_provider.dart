import 'package:base_flutter/data/entity/movie_entity.dart';
import 'package:base_flutter/data/entity/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppProvider {
  final rootNavigatorKey = GlobalKey<NavigatorState>();

  RxList<MovieEntity> showingMovies = <MovieEntity>[].obs;
  RxList<MovieEntity> comingMovies = <MovieEntity>[].obs;

  Rx<UserEntity?> userData = Rx(null);

  bool get isAuth => userData.value != null;

  updateUserData(UserEntity user) {
    userData.value = user;
  }

  logout() {
    userData.value = null;
  }
}
