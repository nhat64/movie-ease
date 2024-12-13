import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/app/localization/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends BaseController {
  final List<Tab> tabs = [
    Tab(text: tr(LocaleKeys.movieIsShowing)),
    Tab(text: tr(LocaleKeys.movieIsComing)),
  ];

  PageController pageShowingControler = PageController(initialPage: 5 * 999, viewportFraction: 0.6);
  PageController pageComingControler = PageController(initialPage: 5 * 999, viewportFraction: 0.6);

  RxBool isShowShowing = true.obs;

  RxInt currentShowingIndex = 0.obs;
  RxInt currentComingIndex = 0.obs;

  onSlideChanged(int index) {
    if (isShowShowing.value) {
      currentShowingIndex.value = index % appProvider.showingMovies.length;
    } else {
      currentComingIndex.value = index % appProvider.comingMovies.length;
    }
  }

  onTabBarChanged(int index) {
    isShowShowing.value = index == 0;
    currentShowingIndex.value = 0;
  }

  @override
  void dispose() {
    pageShowingControler.dispose();
    pageComingControler.dispose();
    super.dispose();
  }
}
