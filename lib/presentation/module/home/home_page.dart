import 'package:base_flutter/app/base/mvvm/view/base_screen.dart';
import 'package:base_flutter/app/base/widget_common/colored_icon.dart';
import 'package:base_flutter/app/constans/app_assets.dart';
import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/presentation/module/home/home_controller.dart';
import 'package:base_flutter/presentation/module/home/widget/home_tabbar.dart';
import 'package:base_flutter/presentation/module/home/widget/movie_slide_widget.dart';
import 'package:base_flutter/presentation/module/root/root_controller.dart';
import 'package:base_flutter/presentation/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomePage extends BaseScreen<HomeController> {
  const HomePage({super.key});

  @override
  Color? get screenBackgroundColor => Colors.black;

  @override
  bool get wrapWithSafeArea => false;

  @override
  Widget buildScreen(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Stack(
        children: [
          Positioned(
            top: 0,
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: _buildImageBackground(context),
          ),
          Positioned(
              top: 0,
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black],
                  ),
                ),
              )),
          SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Column(
              children: [
                const SizedBox(height: 40),
                _builAppbar(),
                HomeTabBar(controller: controller),
                Expanded(
                  child: _buildSlide(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlide() {
    return Obx(
      () {
        final bool isShowShowing = controller.isShowShowing.value;
        final int currentIndex = isShowShowing ? controller.currentShowingIndex.value : controller.currentComingIndex.value;
        final int indicatorCount = isShowShowing ? controller.appProvider.showingMovies.length : controller.appProvider.comingMovies.length;
        return LayoutBuilder(
          builder: (context, constraints) => Column(
            children: [
              MovieSlideWidget(
                movies: isShowShowing ? controller.appProvider.showingMovies : controller.appProvider.comingMovies,
                pageController: isShowShowing ? controller.pageShowingControler : controller.pageComingControler,
                height: constraints.maxHeight * 0.75,
                onPageChanged: controller.onSlideChanged,
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: IndicatorDots(
                  currentIndex: currentIndex,
                  indicatorCount: indicatorCount,
                  indicatorSelectedWidth: 20,
                  indicatorUnselectedWidth: 12,
                  indicatorHeight: 4,
                  indicatorSpace: 4,
                  selectedDecoration: BoxDecoration(
                    color: AppColors.yellowFCC434,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  unselectedDecoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _builAppbar() {
    return Container(
      height: 43,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Get.find<RootController>().toggleDrawer();
            },
            child: ColoredIcon(
              height: 36,
              width: 36,
              color: AppColors.yellowFCC434,
              child: SvgPicture.asset(SvgPaths.icMenu),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteName.searchMovie);
            },
            child: ColoredIcon(
              height: 28,
              width: 28,
              color: Colors.white,
              child: SvgPicture.asset(SvgPaths.icSearch),
            ),
          ),
        ],
      ),
    );
  }

  _buildImageBackground(BuildContext context) {
    return Obx(
      () {
        final isShowShowing = controller.isShowShowing.value;
        final currentIndex = isShowShowing ? controller.currentShowingIndex.value : controller.currentComingIndex.value;
        return Opacity(
          opacity: 0.5,
          child: Image.network(
            isShowShowing ? controller.appProvider.showingMovies[currentIndex].poster : controller.appProvider.comingMovies[currentIndex].poster,
            errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}

class IndicatorDots extends StatelessWidget {
  const IndicatorDots({
    super.key,
    required this.currentIndex,
    required this.indicatorCount,
    this.indicatorSelectedWidth = 16,
    this.indicatorUnselectedWidth = 8,
    this.indicatorHeight = 4,
    this.indicatorSpace = 4,
    this.selectedDecoration,
    this.unselectedDecoration,
  });

  final int currentIndex;
  final int indicatorCount;
  final double indicatorSelectedWidth;
  final double indicatorUnselectedWidth;
  final double indicatorHeight;
  final double indicatorSpace;
  final BoxDecoration? selectedDecoration;
  final BoxDecoration? unselectedDecoration;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: indicatorSelectedWidth + indicatorUnselectedWidth * (indicatorCount - 1) + indicatorSpace * (indicatorCount - 1),
      height: indicatorHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: currentIndex == index ? indicatorSelectedWidth : indicatorUnselectedWidth,
            height: indicatorHeight,
            decoration: currentIndex == index ? selectedDecoration : unselectedDecoration,
            child: Container(),
          );
        },
        separatorBuilder: (context, index) => SizedBox(width: indicatorSpace),
        itemCount: indicatorCount,
      ),
    );
  }
}
