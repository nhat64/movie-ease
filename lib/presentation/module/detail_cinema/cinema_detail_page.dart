import 'package:base_flutter/app/base/mvvm/view/base_screen.dart';
import 'package:base_flutter/app/base/widget_common/scale_button.dart';
import 'package:base_flutter/app/constans/app_assets.dart';
import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/data/page_data/select_showtime_page_data.dart';
import 'package:base_flutter/presentation/module/detail_cinema/cinema_detail_controller.dart';
import 'package:base_flutter/presentation/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CinemaDetailPage extends BaseScreen<CinemaDetailController> {
  const CinemaDetailPage({super.key});

  @override
  Color? get screenBackgroundColor => Colors.black;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      title: const Text('Chi tiết rạp'),
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
                    controller.cinema.name ?? 'Rạp chiếu',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildInforRow(title: 'Địa chỉ : ', content: controller.cinema.address ?? ''),
                  const SizedBox(height: 10),
                  _buildInforRow(
                    title: 'Khoảng cách : ',
                    content: controller.cinema.distance ?? 'km',
                  ),
                  const SizedBox(height: 10),
                  _buildInforRow(
                    title: 'Thời gian mở cửa : ',
                    content: '8:00 - 22:00',
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      final Uri url = Uri.parse('https://maps.app.goo.gl/iqs7N9qejWFE7Qec7');
                      launchUrl(url);
                    },
                    child: const Text(
                      'Xem bản đồ',
                      style: TextStyle(
                        color: AppColors.yellowFCC434,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.yellowFCC434,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          ScaleButton(
            onTap: () {
              Get.offNamedUntil(
                RouteName.selectShowtime,
                arguments: SelectShowtimePageData(cinema: controller.cinema),
                (route) => route.settings.name == RouteName.root,
              );
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
                  'Mua vé',
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
      crossAxisAlignment: CrossAxisAlignment.start,
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
        Expanded(
          child: Text(
            content,
            style: TextStyle(
              color: contentColor ?? Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
