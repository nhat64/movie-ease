import 'package:base_flutter/app/base/mvvm/view/base_screen.dart';
import 'package:base_flutter/app/base/widget_common/scale_button.dart';
import 'package:base_flutter/app/constans/app_assets.dart';
import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/presentation/module/detail_voucher.dart/voucher_detail_controller.dart';
import 'package:base_flutter/presentation/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VoucherDetailPage extends BaseScreen<VoucherDetailController> {
  const VoucherDetailPage({super.key});

  @override
  Color? get screenBackgroundColor => Colors.black;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      title: const Text('Khuyến mãi'),
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
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: double.infinity,
                    height: 230,
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      ImagePaths.imgBannerVoucher,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    controller.promotion.promoName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildInforRow(
                    title: 'Trạng thái : ',
                    content: controller.promotion.isUsed ? 'Đã sử dụng' : 'Chưa sử dụng',
                    contentColor: controller.promotion.isUsed ? Colors.red : Colors.green,
                  ),
                  const SizedBox(height: 10),
                  _buildInforRow(title: 'Ngày bắt đầu : ', content: controller.promotion.startDate),
                  const SizedBox(height: 10),
                  _buildInforRow(title: 'Ngày kết thúc : ', content: controller.promotion.endDate),
                  const SizedBox(height: 10),
                  _buildInforRow(title: 'Còn lại : ', content: controller.promotion.quantity.toString()),
                  const SizedBox(height: 20),
                  Text(
                    controller.promotion.description ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ScaleButton(
            onTap: () {
              Get.offNamedUntil(RouteName.selectCinema, (route) => route.settings.name == RouteName.root);
            },
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.yellowFCC434,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  'Sử dụng',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
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

  _buildInforRow({
    required String title,
    required String content,
    Color? contentColor,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          content,
          style: TextStyle(
            color: contentColor ?? Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
