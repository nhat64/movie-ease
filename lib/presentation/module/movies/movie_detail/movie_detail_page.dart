import 'package:base_flutter/app/base/mvvm/view/base_screen.dart';
import 'package:base_flutter/app/base/widget_common/call_api_widget.dart';
import 'package:base_flutter/app/base/widget_common/scale_button.dart';
import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/app/utils/day_time.dart';
import 'package:base_flutter/data/page_data/all_comment_page_data.dart';
import 'package:base_flutter/data/page_data/create_comment_page_data.dart';
import 'package:base_flutter/data/page_data/select_cinema_page_data.dart';
import 'package:base_flutter/presentation/module/movies/movie_detail/movie_detail_controller.dart';
import 'package:base_flutter/presentation/module/movies/movie_detail/widget/comment_widget.dart';
import 'package:base_flutter/presentation/routes/route_names.dart';
import 'package:base_flutter/presentation/widgets/read_more.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieDetailPage extends BaseScreen<MovieDetailController> {
  const MovieDetailPage({super.key});

  @override
  Color? get screenBackgroundColor => Colors.black;

  @override
  bool get wrapWithSafeArea => true;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      title: Text(controller.movie.name),
      centerTitle: true,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
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
    return Obx(() {
      if (controller.movieDetail.value == null) {
        return const Center(
          child: CicularLoadingWidget(),
        );
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    _buildInfoMovie(),
                    const SizedBox(height: 20),
                    _buildInfoMovie2(),
                    const SizedBox(height: 36),
                    _buildDesciption(),
                    const SizedBox(height: 36),
                    _buildSomeComment(),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
            if (checkShowingDate(controller.movie.date))
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Align(
                  alignment: Alignment.center,
                  child: ScaleButton(
                    onTap: () {
                      Get.toNamed(RouteName.selectCinema, arguments: SelectCinemaPageData(movie: controller.movie));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.yellowFCC434,
                        borderRadius: BorderRadius.circular(12),
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
        ),
      );
    });
  }

  _buildSomeComment() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bình luận',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        _buildTitleComment(),
        const SizedBox(height: 16),
        Container(height: 1, width: double.infinity, color: AppColors.greyCCCCCC),
        _buildListCommentItem(),
        _buildViewAllComment(),
      ],
    );
  }

  _buildViewAllComment() {
    if (controller.movieDetail.value!.voteTotal <= 5) {
      return const SizedBox();
    }
    return InkWell(
      onTap: () {
        Get.toNamed(RouteName.allComment, arguments: AllCommentPageData(movie: controller.movieDetail.value!, listComment: controller.listComment));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.arrow_drop_down, color: AppColors.yellowFCC434),
            const SizedBox(width: 4),
            Text(
              'Xem tất cả ${controller.movieDetail.value!.voteTotal} bình luận',
              style: const TextStyle(
                color: AppColors.yellowFCC434,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildListCommentItem() {
    return Obx(() {
      if (controller.listComment.isEmpty) {
        return const SizedBox();
      }
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.listComment.length <= 5 ? controller.listComment.length : 5,
        itemBuilder: (context, index) => CommentWidget(
          comment: controller.listComment[index],
          isFixable: controller.listComment[index].accountId == controller.appProvider.userData.value?.accountId,
          onDelete: () {
            controller.deleteComment(controller.movie.id);
          },
          onEdit: () {
            Get.toNamed(
              RouteName.createComment,
              arguments: CreateCommentPageData(
                comment: controller.listComment[index],
                movie: controller.movie,
              ),
            );
          },
        ),
        separatorBuilder: (context, index) => Container(height: 1, width: double.infinity, color: AppColors.greyCCCCCC),
      );
    });
  }

  _buildTitleComment() {
    final movie = controller.movieDetail.value!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.star, color: AppColors.yellowFCC434, size: 16),
        const SizedBox(width: 4),
        Text(
          '${movie.voting}/5',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '(${movie.voteTotal} đánh giá)',
          style: const TextStyle(
            color: AppColors.greyCCCCCC,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        const Spacer(),
        if (!movie.isEva && controller.appProvider.userData.value != null)
          InkWell(
            onTap: () {
              Get.toNamed(RouteName.createComment, arguments: CreateCommentPageData(movie: movie));
            },
            child: const Text(
              'Để lại đánh giá',
              style: TextStyle(
                color: AppColors.yellowFCC434,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }

  _buildDesciption() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Mô tả',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Obx(() {
          return ReadMoreText(
            controller.movieDetail.value!.description,
            trimMode: TrimMode.line,
            trimLines: 3,
            trimCollapsedText: 'Show more',
            trimExpandedText: 'Show less',
            style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
            lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.yellowFCC434),
            moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.yellowFCC434),
          );
        }),
      ],
    );
  }

  _buildInfoMovie2() {
    return Obx(() {
      final movie = controller.movieDetail.value!;
      return Row(
        children: [
          Expanded(
            child: _buildColumnInfo2(title: 'Ngày chiếu', content: Text(movie.date)),
          ),
          Container(
            height: 40,
            width: 1,
            color: AppColors.greyCCCCCC,
          ),
          Expanded(
            child: _buildColumnInfo2(title: 'Thời lượng', content: Text('${movie.durationMinute} phút')),
          ),
          Container(
            width: 1,
            height: 40,
            color: AppColors.greyCCCCCC,
          ),
          Expanded(
            child: _buildColumnInfo2(
                title: 'Đánh giá',
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(movie.voting),
                    const Icon(Icons.star, color: AppColors.yellowFCC434, size: 16),
                  ],
                )),
          ),
        ],
      );
    });
  }

  _buildColumnInfo2({
    required String title,
    required Widget content,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.greyCCCCCC,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        DefaultTextStyle(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
          child: content,
        ),
      ],
    );
  }

  _buildInfoMovie() {
    return Obx(() {
      final movie = controller.movieDetail.value!;
      return IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 130,
              height: 190,
              decoration: BoxDecoration(
                color: AppColors.neutral1D1D1D,
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                movie.avatar,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  if (movie.genre.isNotEmpty) ...[
                    Text(
                      movie.genre.map((e) => e.name).join(', '),
                      style: const TextStyle(
                        color: AppColors.greyCCCCCC,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                  ],
                  Text(
                    '${movie.durationMinute} phút',
                    style: const TextStyle(
                      color: AppColors.greyCCCCCC,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      movie.rated,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  ScaleButton(
                    onTap: () {
                      Get.toNamed(RouteName.playTrailers, arguments: movie.trailerUrl);
                    },
                    child: Container(
                      width: 60,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.yellowFCC434),
                      ),
                      child: const Center(
                        child: Text(
                          'Trailer',
                          style: TextStyle(
                            color: AppColors.yellowFCC434,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
