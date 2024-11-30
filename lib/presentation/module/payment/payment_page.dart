import 'package:base_flutter/app/base/mvvm/view/base_screen.dart';
import 'package:base_flutter/app/base/widget_common/colored_icon.dart';
import 'package:base_flutter/app/base/widget_common/scale_button.dart';
import 'package:base_flutter/app/constans/app_assets.dart';
import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/presentation/module/booking/select_seats/widget/money_text_widget.dart';
import 'package:base_flutter/presentation/module/payment/payment_controller.dart';
import 'package:base_flutter/presentation/module/payment/widget/payment_menthod_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class PaymentPage extends BaseScreen<PaymentController> {
  const PaymentPage({super.key});

  @override
  Color? get screenBackgroundColor => Colors.black;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      title: const Text('Thanh toán'),
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
    return Stack(
      children: [
        Positioned.fill(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoMovie(),
                  const SizedBox(height: 32),
                  _buildInvoice(),
                  const SizedBox(height: 32),
                  _buildPaymentMenthod(),
                  const SizedBox(height: 200),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: _buildButtonPayment(),
        ),
      ],
    );
  }

  _buildButtonPayment() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF261D08),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(16),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Thanh toán trong vòng',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  '05:00',
                  style: TextStyle(
                    color: AppColors.yellowFCC434,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          ScaleButton(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.yellowFCC434,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: const Text(
                "Thanh toán",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildInfoMovie() {
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

    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral1D1D1D,
        borderRadius: BorderRadius.circular(12),
      ),
      width: double.infinity,
      height: 160,
      clipBehavior: Clip.antiAlias,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            controller.pageData.movie.poster,
            fit: BoxFit.fitHeight,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.pageData.movie.name,
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
                    content: controller.pageData.showtime.startDate ?? '',
                  ),
                  const SizedBox(height: 8),
                  buildInfoRow(
                    svgPath: SvgPaths.icClock,
                    content: '${controller.pageData.showtime.startTime} - ${controller.pageData.showtime.endTime}',
                  ),
                  const SizedBox(height: 8),
                  buildInfoRow(
                    svgPath: SvgPaths.icLocation,
                    content: controller.pageData.cinema.address ?? '',
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildInvoice() {
    Widget buildInfoPayment({
      required String title,
      required String content,
    }) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                content,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        buildInfoPayment(
          title: 'Ghế',
          content: controller.pageData.selectedSeats.map((e) => e.code).join(', '),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 20),
          height: 1,
          width: double.infinity,
          color: AppColors.neutral565656,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Tổng",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: MoneyTextWidget(
                  money: controller.pageData.selectedSeats.map((e) => e.price ?? 0).toList().reduce((a, b) => a + b),
                  unitRight: true,
                  style: const TextStyle(
                    color: AppColors.yellowFCC434,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                  unitStyle: const TextStyle(
                    color: AppColors.yellowFCC434,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _buildPaymentMenthod() {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            'Thanh toán qua',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          ...controller.listMenthod.map(
            (e) => PaymentMenthodItemWidget(
              menthod: e,
              isSelected: controller.selectedMenthod.value == e,
              onTap: () {
                if (controller.selectedMenthod.value != e) {
                  controller.selectedMenthod.value = e;
                }
              },
            ),
          ),
        ],
      );
    });
  }
}
