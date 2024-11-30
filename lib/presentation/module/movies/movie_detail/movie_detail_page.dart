import 'package:base_flutter/app/base/mvvm/view/base_screen.dart';
import 'package:base_flutter/app/base/widget_common/scale_button.dart';
import 'package:base_flutter/app/constans/app_assets.dart';
import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/app/utils/time_convert.dart';
import 'package:base_flutter/presentation/module/movies/movie_detail/movie_detail_controller.dart';
import 'package:base_flutter/presentation/routes/route_names.dart';
import 'package:base_flutter/presentation/widgets/read_more.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MovieDetailPage extends BaseScreen<MovieDetailController> {
  const MovieDetailPage({super.key});

  @override
  Color? get screenBackgroundColor => Colors.black;

  @override
  bool get wrapWithSafeArea => true;

  @override
  bool get setTopSafeArea => false;

  @override
  bool get setBottomSafeArea => true;

  @override
  bool get extendBodyBehindAppBar => true;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: SingleChildScrollView(
            controller: controller.scrollController,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      foregroundDecoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black,
                          ],
                        ),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Image.network(
                        controller.movie.poster,
                        errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 60,
                          height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(0.4),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteName.playTrailers, arguments: controller.movie.trailerUrl);
                            },
                            behavior: HitTestBehavior.opaque,
                            child: SvgPicture.asset(
                              SvgPaths.icPlay,
                              width: 25,
                              height: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              controller.movie.name,
                              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600, height: 1),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        controller.movie.director,
                        style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        formatDurationToMinuteWord(controller.movie.duration),
                        style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 32,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => _buildtag(controller.movie.movieGenre[index]),
                          separatorBuilder: (context, index) => const SizedBox(width: 8),
                          itemCount: controller.movie.movieGenre.length,
                          shrinkWrap: true,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ReadMoreText(
                        controller.movie.description,
                        trimMode: TrimMode.Line,
                        trimLines: 3,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
                        lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.yellowFCC434),
                        moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.yellowFCC434),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // Positioned(
        //   top: 0,
        //   left: 0,
        //   right: 0,
        //   child: AppBar(
        //     backgroundColor: Colors.transparent,
        //     elevation: 0,
        //     surfaceTintColor: Colors.transparent,
        //     leading: IconButton(
        //       icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        //       onPressed: () {
        //         Navigator.of(context).pop();
        //       },
        //     ),
        //   ),
        // ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 30,
          child: Align(
            alignment: Alignment.center,
            child: ScaleButton(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.yellowFCC434,
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.85,
                child: const Text(
                  'Mua vé',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildtag(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Text(
        title,
        style: const TextStyle(color: Colors.black, fontSize: 12),
      ),
    );
  }
}
