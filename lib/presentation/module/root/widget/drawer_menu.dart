import 'package:base_flutter/app/base/helper/log.dart';
import 'package:base_flutter/app/base/widget_common/colored_icon.dart';
import 'package:base_flutter/app/base/widget_common/custom_dialog.dart';
import 'package:base_flutter/app/base/widget_common/scale_button.dart';
import 'package:base_flutter/app/constans/app_assets.dart';
import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/presentation/routes/route_names.dart';
import 'package:base_flutter/presentation/widgets/app_dialog/show_login_warning_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildDrawerMenu(context);
  }

  Widget _buildDrawerMenu(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral1A1A1A,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 42),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildHeaderDrawer(),
            Expanded(
              child: SingleChildScrollView(
                child: _buildBodyDrawer(),
              ),
            ),
            _buildFooterDrawer(),
          ],
        ),
      ),
    );
  }

  _buildHeaderDrawer() {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: SizedBox(
              height: 70,
              width: 70,
              child: SvgPicture.asset(SvgPaths.logo),
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'MOVIE EASE',
            style: TextStyle(
              color: AppColors.yellowFCC434,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  _buildBodyDrawer() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: [
          _buildOption(
            title: 'Đặt vé theo rạp',
            icon: SvgPaths.icVideo,
          ),
          _buildDividerProfileOption(),
          _buildOption(
            title: 'Đặt vé theo phim',
            icon: SvgPaths.icMovie,
          ),
        ],
      ),
    );
  }

  _buildFooterDrawer() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 16),
      child: ScaleButton(
        onTap: () {
          // Get.toNamed(RouteName.login);
          showLoginWarningDialog();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.yellowFCC434,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text(
              'Đăng nhập',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      // child: Center(
      //   child: Text(
      //     'Version 1.0.0',
      //     style: TextStyle(
      //       color: AppColors.yellowFCC434,
      //       fontSize: 14,
      //       fontWeight: FontWeight.w400,
      //     ),
      //   ),
      // ),
    );
  }

  _buildDividerProfileOption() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      height: 1,
      color: AppColors.black262626,
    );
  }

  _buildOption({
    required String title,
    required String icon,
  }) {
    return InkWell(
      onTap: () {
        Log.console('onTap $title');
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ColoredIcon(
              color: Colors.white,
              width: 24,
              height: 24,
              child: SvgPicture.asset(icon),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 13),
          ],
        ),
      ),
    );
  }
}
