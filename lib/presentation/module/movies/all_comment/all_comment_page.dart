import 'package:base_flutter/app/base/mvvm/view/base_screen.dart';
import 'package:base_flutter/app/base/widget_common/call_api_widget.dart';
import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/data/entity/comment_entity.dart';
import 'package:base_flutter/data/page_data/create_comment_page_data.dart';
import 'package:base_flutter/presentation/module/movies/all_comment/all_comment_controller.dart';
import 'package:base_flutter/presentation/module/movies/movie_detail/widget/comment_widget.dart';
import 'package:base_flutter/presentation/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCommentPage extends BaseScreen<AllCommentController> {
  const AllCommentPage({super.key});

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
      title: const Text('Bình luận'),
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
      actions: controller.movie.isEva
          ? null
          : [
              IconButton(
                icon: const Icon(Icons.add, color: AppColors.yellowFCC434),
                onPressed: () {
                  Get.toNamed(RouteName.createComment, arguments: CreateCommentPageData(movie: controller.movie));
                },
              ),
            ],
    );
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          _buildTitle(),
          const SizedBox(height: 20),
          _buildFilter(),
          const SizedBox(height: 8),
          Expanded(
            child: _buildListComment(),
          ),
        ],
      ),
    );
  }

  _buildFilter() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(() {
        return Row(
          children: [
            _buildTagFilter(
              title: 'Tất cả',
              content: const Icon(Icons.star, color: AppColors.yellowFCC434, size: 16),
              isSelected: controller.ratingFilter.value == 0,
              onTap: () {
                controller.onFilter(0);
              },
            ),
            const SizedBox(width: 8),
            _buildTagFilter(
              title: '5.0',
              content: const Icon(Icons.star, color: AppColors.yellowFCC434, size: 16),
              isSelected: controller.ratingFilter.value == 5,
              onTap: () {
                controller.onFilter(5);
              },
            ),
            const SizedBox(width: 8),
            _buildTagFilter(
              title: '4.0',
              content: const Icon(Icons.star, color: AppColors.yellowFCC434, size: 16),
              isSelected: controller.ratingFilter.value == 4,
              onTap: () {
                controller.onFilter(4);
              },
            ),
            const SizedBox(width: 8),
            _buildTagFilter(
              title: '3.0',
              content: const Icon(Icons.star, color: AppColors.yellowFCC434, size: 16),
              isSelected: controller.ratingFilter.value == 3,
              onTap: () {
                controller.onFilter(3);
              },
            ),
            const SizedBox(width: 8),
            _buildTagFilter(
              title: '2.0',
              content: const Icon(Icons.star, color: AppColors.yellowFCC434, size: 16),
              isSelected: controller.ratingFilter.value == 2,
              onTap: () {
                controller.onFilter(2);
              },
            ),
            const SizedBox(width: 8),
            _buildTagFilter(
              title: '1.0',
              content: const Icon(Icons.star, color: AppColors.yellowFCC434, size: 16),
              isSelected: controller.ratingFilter.value == 1,
              onTap: () {
                controller.onFilter(1);
              },
            ),
          ],
        );
      }),
    );
  }

  _buildTagFilter({
    required String title,
    required Widget content,
    required bool isSelected,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.yellowFCC434 : AppColors.black262626,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            content,
            const SizedBox(width: 4),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildListComment() {
    return Obx(() {
      if (controller.listCommentFetch.isEmpty) {
        return const Center(
          child: CicularLoadingWidget(),
        );
      }

      List<CommentEntity> listComment = controller.listCommentFilter;

      return ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: listComment.length,
        itemBuilder: (context, index) => CommentWidget(
          comment: listComment[index],
          isFixable: controller.listComment[index].accountId == controller.appProvider.userData.value!.accountId,
          onDelete: () {},
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

  Widget _buildTitle() {
    return RichText(
      text: TextSpan(
        text: 'Bình luận của ',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        children: [
          TextSpan(
            text: controller.movie.name,
            style: const TextStyle(
              color: AppColors.yellowFCC434,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
