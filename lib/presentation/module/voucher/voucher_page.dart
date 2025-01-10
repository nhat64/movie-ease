import 'package:base_flutter/app/base/mvvm/view/base_screen.dart';
import 'package:base_flutter/app/base/widget_common/call_api_widget.dart';
import 'package:base_flutter/app/base/widget_common/colored_icon.dart';
import 'package:base_flutter/app/constans/app_assets.dart';
import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/data/entity/promotion_entity.dart';
import 'package:base_flutter/presentation/module/voucher/voucher_controller.dart';
import 'package:base_flutter/presentation/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class VoucherPage extends BaseScreen<VoucherController> {
  const VoucherPage({super.key});

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
    );
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Obx(
      () {
        if (controller.loading.value) {
          return const Center(
            child: CicularLoadingWidget(),
          );
        }

        List<PromotionEntity> listPromotion = controller.listPromotion.value;

        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...listPromotion.map(
                  (e) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteName.voucherDetail, arguments: e);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: AppColors.neutral3B3B3B,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        clipBehavior: Clip.antiAlias,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 150,
                              child: Image.asset(
                                ImagePaths.imgBannerVoucher,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                e.promoName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  const Text(
                                    'Trạng thái :',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    e.isUsed ? 'Đã sử dụng' : 'Chưa sử dụng',
                                    style: TextStyle(
                                      color: e.isUsed ? Colors.red : Colors.green,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: SizedBox(
                                height: 16,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ColoredIcon(
                                      color: Colors.white,
                                      child: SvgPicture.asset(
                                        SvgPaths.icCalendar,
                                        width: 16,
                                        height: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      e.startDate,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(width: 16),
                                    Text(
                                      e.endDate,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 90),
              ],
            ),
          ),
        );
      },
    );
  }
}
