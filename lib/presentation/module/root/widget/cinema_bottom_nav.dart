import 'dart:math';

import 'package:base_flutter/app/base/helper/log.dart';
import 'package:base_flutter/app/base/widget_common/colored_icon.dart';
import 'package:base_flutter/app/base/widget_common/scale_button.dart';
import 'package:base_flutter/app/constans/app_assets.dart';
import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/app/localization/locale_keys.g.dart';
import 'package:base_flutter/app/utils/custom_path.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CinemaBottomNavItem {
  final String title;
  final SvgPicture icon;
  final SvgPicture iconSelected;

  CinemaBottomNavItem({
    required this.title,
    required this.icon,
    required this.iconSelected,
  });
}

class CinemaBottomNav extends StatefulWidget {
  CinemaBottomNav({super.key, this.onIndexChange, this.onNotchTap});

  // tạm thời nhớ phải khai báo số chẵn
  final List<CinemaBottomNavItem> listItem = [
    CinemaBottomNavItem(title: LocaleKeys.home, icon: SvgPicture.asset(SvgPaths.icHome), iconSelected: SvgPicture.asset(SvgPaths.icHomeSelected)),
    CinemaBottomNavItem(title: 'Bắp nước', icon: SvgPicture.asset(SvgPaths.icPopcorn), iconSelected: SvgPicture.asset(SvgPaths.icPopcornSelected)),
    CinemaBottomNavItem(title: 'Khuyễn mãi', icon: SvgPicture.asset(SvgPaths.icGift), iconSelected: SvgPicture.asset(SvgPaths.icGiftSelected)),
    CinemaBottomNavItem(title: LocaleKeys.profile, icon: SvgPicture.asset(SvgPaths.icUser), iconSelected: SvgPicture.asset(SvgPaths.icUserSelected)),
  ];

  final void Function(int index)? onIndexChange;
  final VoidCallback? onNotchTap;

  @override
  State<CinemaBottomNav> createState() => CinemaBottomNavState();
}

class CinemaBottomNavState extends State<CinemaBottomNav> {
  int currentIndex = 0;

  toggleIndex(int index) {
    setState(() {
      currentIndex = index;
    });

    widget.onIndexChange?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 5,
            child: ClipPath(
              clipper: _NotchClipath(
                itemCount: 5,
                notchHeight: 32,
                notchDistance: 18,
                boderRadius: 20,
              ),
              child: CustomPaint(
                foregroundPainter: _NavPaint(
                  itemCount: 5,
                  notchHeight: 32,
                  notchDistance: 18,
                  boderRadius: 20,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: 60,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.9),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ...widget.listItem.sublist(0, widget.listItem.length ~/ 2).asMap().entries.map((entry) {
                        final index = entry.key;
                        final item = entry.value;
                        return _buildNavItem(item, index);
                      }),
                      const Expanded(
                        child: SizedBox.shrink(),
                      ),
                      ...widget.listItem.sublist(widget.listItem.length ~/ 2, widget.listItem.length).asMap().entries.map((entry) {
                        final index = entry.key;
                        final item = entry.value;
                        return _buildNavItem(item, index + widget.listItem.length ~/ 2);
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 60 - 32 + 22,
            child: ScaleButton(
              onTap: () {
                widget.onNotchTap?.call();
              },
              child: Transform.rotate(
                angle: pi / 4,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.yellowFCC434, Color(0xFFF28C2C)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  height: 48,
                  width: 48,
                  alignment: Alignment.center,
                  child: Transform.rotate(
                    angle: -pi / 4,
                    child: ColoredIcon(
                      height: 28,
                      width: 28,
                      color: Colors.black,
                      child: SvgPicture.asset(SvgPaths.icAddTicket),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildNavItem(CinemaBottomNavItem item, int index) {
    Log.console('index $index rebuild');
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (currentIndex == index) {
            return;
          }
          toggleIndex(index);
        },
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: index == currentIndex ? item.iconSelected : item.icon,
            ),
            const SizedBox(height: 4),
            Text(
              item.title,
              style: TextStyle(
                color: index == currentIndex ? AppColors.yellowFCC434 : AppColors.greyCCCCCC,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ).tr(),
          ],
        ),
      ),
    );
  }
}

Path _getNavPath(
  Size size, {
  double boderRadius = 0,
  required int itemCount,
  required double notchHeight,
  required double notchDistance,
}) {
  final rrectPath = Path();

  rrectPath.addRRect(
    RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(boderRadius),
    ),
  );

  final notchPath = Path();

  final notchWidth = size.width / itemCount;

  final Point<double> p1 = Point(notchWidth * (itemCount ~/ 2) + 3, 0);
  final Point<double> p2 = Point(notchWidth * (itemCount ~/ 2) + notchWidth / 2, notchHeight);
  final Point<double> p3 = Point(notchWidth * (itemCount ~/ 2) + notchWidth - 3, 0);

  CustomPath.roundSharpCorners(p1, p2, p3, notchDistance, notchPath);

  notchPath.close();

  final navPath = Path.combine(
    PathOperation.reverseDifference,
    notchPath,
    rrectPath,
  );

  return navPath;
}

class _NavPaint extends CustomPainter {
  _NavPaint({
    required this.itemCount,
    required this.notchHeight,
    required this.notchDistance,
    this.boderRadius = 0,
  });

  final int itemCount;
  final double notchHeight;
  final double notchDistance;
  final double boderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.neutral565656
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final navPath = _getNavPath(size, itemCount: itemCount, notchHeight: notchHeight, notchDistance: notchDistance, boderRadius: boderRadius);

    canvas.drawPath(navPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _NotchClipath extends CustomClipper<Path> {
  _NotchClipath({
    required this.itemCount,
    required this.notchHeight,
    required this.notchDistance,
    this.boderRadius = 0,
  });

  final int itemCount;
  final double notchHeight;
  final double notchDistance;
  final double boderRadius;

  @override
  Path getClip(Size size) {
    return _getNavPath(size, itemCount: itemCount, notchHeight: notchHeight, notchDistance: notchDistance, boderRadius: boderRadius);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
