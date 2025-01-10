import 'package:base_flutter/app/base/mvvm/view/base_screen.dart';
import 'package:base_flutter/app/base/widget_common/colored_icon.dart';
import 'package:base_flutter/app/base/widget_common/custom_bottomsheet.dart';
import 'package:base_flutter/app/base/widget_common/scale_button.dart';
import 'package:base_flutter/app/constans/app_assets.dart';
import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/app/utils/caculator_book.dart';
import 'package:base_flutter/app/utils/time_convert.dart';
import 'package:base_flutter/presentation/module/booking/payment/payment_controller.dart';
import 'package:base_flutter/presentation/module/booking/payment/widget/payment_menthod_item_widget.dart';
import 'package:base_flutter/presentation/module/booking/select_seats/select_seats_controller.dart';
import 'package:base_flutter/presentation/widgets/app_dialog/show_aler_dialog.dart';
import 'package:base_flutter/presentation/widgets/money_text_widget.dart';
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
          if (controller.isWaitingPayment.value) {
            showAlerDialog(
              content: 'Đang chờ thanh toán, có chắc muốn thoát ?',
              onOk: () {
                Get.close(3);
                Get.find<SelectSeatsController>().selectedSeats.value = [];
                Get.find<SelectSeatsController>().onRefresh();
              },
            );
          } else {
            Get.back();
          }
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
                  _buildSelectPromotion(context),
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
            controller.pageData.movie.avatar,
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
                    content: controller.pageData.showtime.startDate,
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
      required int contentMoney,
    }) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Row(
              children: [
                if (contentMoney < 0)
                  const Text(
                    '-',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                MoneyTextWidget(
                  money: contentMoney.abs(),
                  unitRight: true,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  unitStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }

    return Column(
      children: [
        buildInfoPayment(
          title: controller.pageData.selectedSeats.map((e) => e.code).join(', '),
          contentMoney: caculatePrice(listSelected: controller.pageData.selectedSeats),
        ),
        if (controller.pageData.foodOrdered != null)
          ...controller.pageData.foodOrdered!.entries.map(
            (e) => buildInfoPayment(
              title: '${e.key.name} x ${e.value}',
              contentMoney: e.key.price * e.value,
            ),
          ),
        Obx(
          () => controller.promotionSelected.value != null
              ? buildInfoPayment(
                  title: 'Giảm giá',
                  contentMoney: controller.promotionSelected.value!.discount * -1,
                )
              : const SizedBox.shrink(),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          height: 1,
          width: double.infinity,
          color: AppColors.neutral565656,
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

  _buildSelectPromotion(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showBottomsheetPromotion(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.neutral1D1D1D,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            ColoredIcon(color: AppColors.yellowFCC434, child: SvgPicture.asset(SvgPaths.icGift)),
            const SizedBox(width: 8),
            const Text(
              'Chọn mã giảm giá',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            Obx(
              () => Text(
                controller.promotionSelected.value != null ? 'Đã áp dụng' : 'Chưa dùng',
                style: TextStyle(
                  color: controller.promotionSelected.value != null ? Colors.green : Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showBottomsheetPromotion(BuildContext context) {
    showCustomModalBottomSheet(
      context: context,
      backgroundColor: AppColors.black262626,
      isScrollControlled: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        height: MediaQuery.of(context).size.height * 0.65,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Chọn mã giảm giá',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 0.5,
                width: double.infinity,
                color: AppColors.greyCCCCCC,
              ),
              const SizedBox(height: 16),
              ...controller.promotions.map(
                (e) => GestureDetector(
                  onTap: () {
                    controller.onSelectPromotion(e);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.neutral1D1D1D,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.promoName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              e.description ?? '',
                              style: const TextStyle(
                                color: AppColors.neutral565656,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Còn lại: ${e.quantity}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Giảm ',
                                  style: TextStyle(
                                    color: AppColors.yellowFCC434,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                MoneyTextWidget(
                                  money: e.discount,
                                  unitRight: true,
                                  style: const TextStyle(color: AppColors.yellowFCC434, fontSize: 14, fontWeight: FontWeight.w600),
                                  unitStyle: const TextStyle(color: AppColors.yellowFCC434, fontSize: 14, fontWeight: FontWeight.w600),
                                ),
                                const Spacer(),
                                e.isUsed
                                    ? const Text(
                                        'Đã sử dụng',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            )
                          ],
                        )),
                        const SizedBox(width: 8),
                        Obx(() {
                          return Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: controller.promotionSelected.value != null && controller.promotionSelected.value!.id == e.id ? AppColors.yellowFCC434 : AppColors.neutral1C1C1C,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildButtonPayment() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.neutral1C1C1C,
        borderRadius: BorderRadius.circular(12),
      ),
      height: 170,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Thanh toán trong vòng',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              ValueListenableBuilder(
                valueListenable: controller.timerCountdownService.currentSeconds,
                builder: (_, value, __) {
                  return Text(
                    value == -1 ? '10:00' : convertSecondsToMS(value),
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
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
                  child: Obx(
                    () => MoneyTextWidget(
                      money: caculatePrice(
                        listSelected: controller.pageData.selectedSeats,
                        foodOrdered: controller.pageData.foodOrdered,
                        promotion: controller.promotionSelected.value,
                      ),
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
              ),
            ],
          ),
          const SizedBox(height: 20),
          Obx(() {
            return ScaleButton(
              onTap: controller.onPayment,
              child: Container(
                decoration: BoxDecoration(
                  color: controller.isWaitingPayment.value ? AppColors.neutral565656 : AppColors.yellowFCC434,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  controller.isWaitingPayment.value ? "Nhận lại link thanh toán" : "Thanh toán",
                  style: TextStyle(
                    color: controller.isWaitingPayment.value ? Colors.white : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
