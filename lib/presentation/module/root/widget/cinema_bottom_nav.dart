import 'package:base_flutter/app/base/widget_common/colored_icon.dart';
import 'package:base_flutter/app/constans/app_assets.dart';
import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/app/localization/locale_keys.g.dart';
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
  CinemaBottomNav({
    super.key,
    this.onIndexChange,
  });

  // tạm thời nhớ phải khai báo số lẻ
  final List<CinemaBottomNavItem> listItem = [
    CinemaBottomNavItem(title: LocaleKeys.home, icon: SvgPicture.asset(SvgPaths.icHome), iconSelected: SvgPicture.asset(SvgPaths.icHomeSelected)),
    CinemaBottomNavItem(title: LocaleKeys.getTicket, icon: SvgPicture.asset(SvgPaths.icTicket), iconSelected: SvgPicture.asset(SvgPaths.icTicketSelected)),
    CinemaBottomNavItem(title: LocaleKeys.profile, icon: SvgPicture.asset(SvgPaths.icUser), iconSelected: SvgPicture.asset(SvgPaths.icUserSelected)),
  ];

  final void Function(int index)? onIndexChange;

  @override
  State<CinemaBottomNav> createState() => CinemaBottomNavState();
}

class CinemaBottomNavState extends State<CinemaBottomNav> {
  int currentIndex = 0;

  toggleIndex(int index) {
    if (index != 1) {
      setState(() {
        currentIndex = index;
      });
    }

    widget.onIndexChange?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 5),
      child: Container(
        height: 70,
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.9),
          border: Border.all(
            color: AppColors.black262626,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: widget.listItem.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  if (currentIndex == index) {
                    return;
                  }
                  toggleIndex(index);
                },
                behavior: HitTestBehavior.opaque,
                child: index == 1
                    ? Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            // color: AppColors.yellowFCC434,
                            borderRadius: BorderRadius.circular(8),
                            gradient: const LinearGradient(
                              colors: [AppColors.yellowFCC434, Color(0xFFF28C2C)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: ColoredIcon(
                            height: 28,
                            width: 28,
                            color: Colors.black,
                            child: SvgPicture.asset(SvgPaths.icAddTicket),
                          ),
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 26,
                            height: 26,
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
          }).toList(),
        ),
      ),
    );
  }
}
