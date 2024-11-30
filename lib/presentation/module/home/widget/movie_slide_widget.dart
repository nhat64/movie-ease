import 'dart:math';

import 'package:base_flutter/data/entity/movie_entity.dart';
import 'package:base_flutter/presentation/module/home/widget/movie_slide_item_widget.dart';
import 'package:flutter/material.dart';

class MovieSlideWidget extends StatelessWidget {
  const MovieSlideWidget({
    super.key,
    required this.movies,
    required this.pageController,
    this.onPageChanged,
    required this.height,
    this.onMovieSelected,
  });

  final List<MovieEntity> movies;
  final PageController pageController;
  final void Function(int index)? onPageChanged;
  final double height;
  final void Function(MovieEntity movie)? onMovieSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: PageView.builder(
        physics: const ClampingScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: pageController,
            builder: (context, child) {
              late double offsetIndex;

              if (pageController.position.haveDimensions) {
                offsetIndex = index.toDouble() - pageController.page!;
              } else {
                offsetIndex = index.toDouble() - pageController.initialPage.toDouble();
              }

              final int listIndex = index % movies.length;

              return LayoutBuilder(
                builder: (context, constraints) {
                  Widget movieSlideItemWidget = MovieSlideItemWidget(
                    movieItem: movies[listIndex],
                    width: constraints.maxWidth * 0.95,
                    height: constraints.maxHeight * 0.95,
                    offsetIndex: offsetIndex,
                  );

                  if (offsetIndex.abs() <= 2 && offsetIndex != 0) {
                    double rotation = offsetIndex * 0.025;
                    bool isRight = offsetIndex > 0;

                    return Container(
                      margin: EdgeInsets.only(top: rotation.abs() * 200),
                      alignment: Alignment.topCenter,
                      child: Transform.rotate(
                        angle: rotation * pi,
                        alignment: isRight ? Alignment.bottomLeft : Alignment.bottomRight,
                        child: movieSlideItemWidget,
                      ),
                    );
                  }

                  return Container(
                    alignment: Alignment.topCenter,
                    child: movieSlideItemWidget,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
