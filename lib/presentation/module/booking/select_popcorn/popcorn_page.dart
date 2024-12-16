import 'package:base_flutter/app/base/mvvm/view/base_screen.dart';
import 'package:base_flutter/app/base/widget_common/call_api_widget.dart';
import 'package:base_flutter/app/base/widget_common/scale_button.dart';
import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/app/utils/caculator_book.dart';
import 'package:base_flutter/data/page_data/payment_page_data.dart';
import 'package:base_flutter/presentation/module/booking/select_popcorn/popcorn_controller.dart';
import 'package:base_flutter/presentation/routes/route_names.dart';
import 'package:base_flutter/presentation/widgets/money_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopcornPage extends BaseScreen<PopcornController> {
  const PopcornPage({super.key});

  @override
  Color? get screenBackgroundColor => Colors.black;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      title: const Text('Combo bắp nước'),
      centerTitle: true,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: InkWell(
            onTap: () {
              Get.toNamed(
                RouteName.payment,
                arguments: PaymentPageData(
                  selectedSeats: controller.pageData.selectedSeats,
                  movie: controller.pageData.movie,
                  cinema: controller.pageData.cinema,
                  showtime: controller.pageData.showtime,
                ),
              );
            },
            child: const Text(
              "Bỏ qua",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.underline,
                decorationColor: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: _buildBody(
          context,
        )),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: _buildBottomSelected(context),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Obx(
      () {
        if (controller.loading.value) {
          return const Center(
            child: CicularLoadingWidget(),
          );
        }

        final listPopcorn = controller.listPopcorn;
        final selectedPopcorn = controller.selectedPopcorn.value;

        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: listPopcorn.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final popcorn = listPopcorn[index];
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.neutral1C1C1C,
                  borderRadius: BorderRadius.circular(8),
                ),
                clipBehavior: Clip.antiAlias,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        popcorn.image,
                        errorBuilder: (context, error, stackTrace) => const SizedBox(
                          width: 80,
                          height: 80,
                          child: Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            popcorn.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          MoneyTextWidget(
                            money: popcorn.price,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            unitStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            unitRight: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    ScaleButton(
                      onTap: () {
                        controller.onSelectPopcorn(popcorn);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedPopcorn?.id == popcorn.id ? Colors.red : AppColors.yellowFCC434,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          selectedPopcorn?.id == popcorn.id ? "Bỏ chọn" : "Chọn",
                          style: TextStyle(
                            color: selectedPopcorn?.id == popcorn.id ? Colors.white : Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 16),
          ),
        );
      },
    );
  }

  Widget _buildBottomSelected(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.animationShowPriceController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 110 * (1 - controller.animationShowPrice.value)),
          child: child,
        );
      },
      child: Container(
        height: 110,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () {
                      return Row(
                        children: [
                          const Text(
                            "Ghế ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              joinSeatToText(controller.pageData.selectedSeats),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 5),
                  Obx(
                    () {
                      return Row(
                        children: [
                          Expanded(
                            child: Text(
                              controller.selectedPopcorn.value?.name ?? "",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 5),
                  Obx(
                    () {
                      return Row(
                        children: [
                          const Text(
                            "Tạm tính: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 5),
                          MoneyTextWidget(
                            money: caculatePrice(listSelected: controller.pageData.selectedSeats, popcorns: controller.selectedPopcorn.value),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            unitStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            unitRight: true,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            ScaleButton(
              onTap: () {
                Get.toNamed(
                  RouteName.payment,
                  arguments: PaymentPageData(
                    selectedSeats: controller.pageData.selectedSeats,
                    movie: controller.pageData.movie,
                    cinema: controller.pageData.cinema,
                    showtime: controller.pageData.showtime,
                    popcorns: controller.selectedPopcorn.value,
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.yellowFCC434,
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: const Text(
                  "Tiếp tục",
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
      ),
    );
  }
}
