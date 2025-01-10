import 'package:base_flutter/app/base/mvvm/view/base_screen.dart';
import 'package:base_flutter/app/base/widget_common/colored_icon.dart';
import 'package:base_flutter/app/base/widget_common/custom_bottomsheet.dart';
import 'package:base_flutter/app/base/widget_common/outline_textfield_custom.dart';
import 'package:base_flutter/app/base/widget_common/scale_button.dart';
import 'package:base_flutter/app/constans/app_assets.dart';
import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/app/utils/day_time.dart';
import 'package:base_flutter/data/entity/movie_entity.dart';
import 'package:base_flutter/presentation/module/movies/movie_search/movie_search_controller.dart';
import 'package:base_flutter/presentation/module/movies/widget/switch_bar.dart';
import 'package:base_flutter/presentation/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MovieSearchPage extends BaseScreen<MovieSearchController> {
  const MovieSearchPage({super.key});

  @override
  Function() get onTapScreen => () {
        controller.searchFocusNode.unfocus();
      };

  @override
  Color? get screenBackgroundColor => Colors.black;

  @override
  Widget buildScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 40),
          _buildAppBar(context),
          const SizedBox(height: 16),
          Obx(
            () => SwitchBar(
              count: 3,
              listTitle: const ['Tất cả', 'Đang chiếu', 'Sắp chiếu'],
              index: controller.indexSelected.value,
              onChange: (index) {
                controller.indexSelected.value = index;
              },
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: _buildListMovies(),
            ),
          )
        ],
      ),
    );
  }

  _buildListMovies() {
    return Obx(
      () {
        List<MovieEntity> listMovies = controller.indexSelected.value == 0
            ? [...controller.appProvider.showingMovies, ...controller.appProvider.comingMovies]
            : controller.indexSelected.value == 1
                ? controller.appProvider.showingMovies
                : controller.appProvider.comingMovies;

        if (controller.textSearch.value.isNotEmpty) {
          listMovies = listMovies
              .where((element) => element.name.toLowerCase().contains(controller.textSearch.toLowerCase()) || element.genre.join('.').toLowerCase().contains(controller.textSearch.toLowerCase()))
              .toList();
        }

        if (controller.listIdGenreSelected.isNotEmpty) {
          listMovies = listMovies
              .where(
                (element) => element.genre.map((e) => e.id).any(
                      (element) => controller.listIdGenreSelected.contains(element),
                    ),
              )
              .toList();
        }

        return Column(children: [
          ...listMovies.map<Widget>(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildInfoMovie(movie: e),
            ),
          ),
          const SizedBox(height: 70),
        ]);
      },
    );
  }

  _buildInfoMovie({
    required MovieEntity movie,
  }) {
    Widget buildInfoRow({
      required String svgPath,
      required String content,
      int maxLines = 1,
    }) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ColoredIcon(
            color: Colors.white,
            height: 16,
            width: 16,
            child: SvgPicture.asset(svgPath),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              content,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    }

    return GestureDetector(
      onTap: () {
        if (checkShowingDate(movie.date)) {
          Get.toNamed(RouteName.movieDetail, arguments: movie);
        } else {
          Get.snackbar('Thông báo', 'Phim chưa được công chiếu');
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.neutral1D1D1D,
          borderRadius: BorderRadius.circular(12),
        ),
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 160,
              width: 120,
              child: Image.network(
                movie.avatar,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.name,
                      style: const TextStyle(
                        color: AppColors.yellowFCC434,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    buildInfoRow(
                      svgPath: SvgPaths.icCalendar,
                      content: movie.date,
                    ),
                    const SizedBox(height: 8),
                    buildInfoRow(
                      svgPath: SvgPaths.icClock,
                      content: '${movie.durationMinute} phút',
                    ),
                    const SizedBox(height: 8),
                    buildInfoRow(
                      svgPath: SvgPaths.icMovie,
                      content: movie.genre.map((e) => e.name).join(', '),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 36,
          width: 36,
          child: GestureDetector(
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        Expanded(
          child: _buildTextField(),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () {
            _showFilterBottomSheet();
          },
          behavior: HitTestBehavior.opaque,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: SvgPicture.asset(SvgPaths.icFilter),
              ),
              const SizedBox(height: 4),
              const Text(
                'Bộ lọc',
                style: TextStyle(
                  color: AppColors.greyCCCCCC,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildTextField() {
    return OutlineTextFieldCustom(
      controller: controller.searchController,
      focusNode: controller.searchFocusNode,
      contentStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      textInputType: TextInputType.text,
      filled: true,
      fillColor: AppColors.neutral1C1C1C,
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 12, right: 8),
        child: SvgPicture.asset(
          SvgPaths.icSearch,
          height: 20,
          width: 20,
        ),
      ),
      hintText: 'Điền tên phim hoặc thể loại',
      hintStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.neutral8C8C8C,
      ),
      cursorColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  _showFilterBottomSheet() {
    showCustomModalBottomSheet(
      context: Get.context!,
      backgroundColor: AppColors.black262626,
      isScrollControlled: true,
      child: _buildBottomsheetFilter(),
    );
  }

  _buildBottomsheetFilter() {
    return SizedBox(
      height: 700,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 24),
                const Text(
                  'Bộ lọc',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.onResetFilter();
                  },
                  child: const Icon(
                    Icons.undo,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 0.5,
            width: double.infinity,
            color: AppColors.greyCCCCCC,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Thể loại',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () {
                    final listSelected = controller.listGenreSelectedTmp;
                    return Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: controller.listGenre.map<Widget>(
                        (e) {
                          return GestureDetector(
                            onTap: () {
                              controller.onSelectedGenre(e);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: listSelected.contains(e) ? AppColors.yellowFCC434 : AppColors.neutral1C1C1C,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                e.name,
                                style: TextStyle(
                                  color: controller.listGenreSelectedTmp.contains(e) ? Colors.black : Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: ScaleButton(
              onTap: () {
                controller.onFilter();
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.yellowFCC434,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Áp dụng',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
