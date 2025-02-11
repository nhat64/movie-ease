import 'package:base_flutter/app/base/mvvm/view/base_screen.dart';
import 'package:base_flutter/app/base/widget_common/colored_icon.dart';
import 'package:base_flutter/app/base/widget_common/scale_button.dart';
import 'package:base_flutter/app/constans/app_assets.dart';
import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/presentation/module/profile/profile_controller.dart';
import 'package:base_flutter/presentation/module/profile/widget/app_avatar.dart';
import 'package:base_flutter/presentation/module/profile/widget/confirm_logout_bottomsheet.dart';
import 'package:base_flutter/presentation/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProfilePage extends BaseScreen<ProfileController> {
  const ProfilePage({super.key});

  @override
  Color? get screenBackgroundColor => Colors.black;

  @override
  Widget buildScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          const Text(
            'Hồ sơ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _buildUserCard(),
          const SizedBox(height: 22),
          const Text(
            'Hệ thống',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          _buildAppOptions(),
          const SizedBox(height: 22),
          const Text(
            'Tài khoản',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          _buildAccountOptions(),
        ],
      ),
    );
  }

  Widget _buildUserCard() {
    return Obx(
      () {
        final avatarPath = controller.appProvider.userData.value?.avatar;
        final name = controller.appProvider.userData.value?.name;
        final phone = controller.appProvider.userData.value?.phoneNumber;
        return Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: AppColors.black262626,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.black262626,
                    width: 2,
                  ),
                ),
                child: AppAvatar(
                  name: name ?? 'name',
                  avatarPath: avatarPath,
                  size: 65,
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name ?? 'name',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      phone ?? 'phone',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 13),
              ScaleButton(
                onTap: () => Get.toNamed(RouteName.editProfile),
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: SvgPicture.asset(
                    SvgPaths.icEditPen,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildAppOptions() {
    return Column(
      children: [
        _buildOption(
          title: 'Vé của tôi',
          icon: SvgPaths.icTicket,
          onTap: () {
            Get.toNamed(RouteName.myTicket);
          },
        ),
      ],
    );
  }

  Widget _buildAccountOptions() {
    return Column(
      children: [
        _buildOption(
          title: 'Đổi mật khẩu',
          icon: SvgPaths.icChange,
          onTap: () {
            Get.toNamed(RouteName.changePass);
          },
        ),
        _buildDividerProfileOption(),
        _buildOption(
          title: 'Đăng xuất',
          icon: SvgPaths.icLogout,
          onTap: () {
            showConfirmLogoutBottomsheet(controller: controller);
          },
        ),
      ],
    );
  }

  _buildDividerProfileOption() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      height: 1,
      color: AppColors.black262626,
    );
  }

  _buildOption({
    required String title,
    required String icon,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: () {
        onTap?.call();
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
            SizedBox(
              width: 20,
              height: 20,
              child: SvgPicture.asset(
                SvgPaths.icArrowRightV2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
