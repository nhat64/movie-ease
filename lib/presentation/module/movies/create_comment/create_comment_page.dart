import 'package:base_flutter/app/base/mvvm/view/base_screen.dart';
import 'package:base_flutter/app/base/widget_common/scale_button.dart';
import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/presentation/module/movies/create_comment/create_comment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateCommentPage extends BaseScreen<CreateCommentController> {
  const CreateCommentPage({super.key});

  @override
  VoidCallback get onTapScreen => () {
        FocusScope.of(Get.context!).requestFocus(FocusNode());
      };

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
      title: Text(controller.comment == null ? 'Viết đáng giá' : 'Sửa bình luận'),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          _buildTitle(),
          const SizedBox(height: 20),
          _buildRating(),
          const SizedBox(height: 20),
          _buildComment(),
          const SizedBox(height: 20),
          _buildButtonSubmit(),
        ],
      ),
    );
  }

  _buildButtonSubmit() {
    return ScaleButton(
      onTap: () {
        controller.onCreate();
      },
      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          color: AppColors.yellowFCC434,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            'Gửi bình luận',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildComment() {
    return Stack(
      children: [
        TextField(
          controller: controller.textController,
          focusNode: controller.focusNode,
          maxLines: 10,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
          ),
          decoration: InputDecoration(
            hintText: 'Nhập bình luận',
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.yellowFCC434,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.yellowFCC434,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: Text(
            '${controller.textController.text.length}/1000',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRating() {
    return Obx(() {
      return Row(
        children: List.generate(
          5,
          (index) => Expanded(
            child: IconButton(
              icon: Icon(
                index + 1 <= controller.rating.value ? Icons.star : Icons.star_border,
                color: AppColors.yellowFCC434,
                size: 30,
              ),
              onPressed: () {
                controller.rating.value = index + 1;
              },
            ),
          ),
        ),
      );
    });
  }

  Widget _buildTitle() {
    return Row(
      children: [
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            color: AppColors.neutral1D1D1D,
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.network(
            controller.movie.avatar,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          controller.movie.name,
          style: const TextStyle(
            color: AppColors.yellowFCC434,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
