import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/app/utils/day_time.dart';
import 'package:flutter/material.dart';

class TimeItemWidget extends StatelessWidget {
  const TimeItemWidget({
    super.key,
    required this.time,
    required this.isSelected,
    this.onTap,
  });

  final DateTime time;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 3, right: 3, bottom: 3, top: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isSelected ? AppColors.yellowFCC434 : AppColors.neutral1C1C1C,
        ),
        width: 46,
        height: 83,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              getShortNameOfDay(time),
              style: TextStyle(
                color: isSelected ? Colors.black : AppColors.neutralF2F2F2,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: isSelected ? AppColors.neutral1D1D1D : AppColors.neutral3B3B3B,
                shape: BoxShape.circle,
              ),
              width: 40,
              height: 40,
              alignment: Alignment.center,
              child: SizedBox(
                height: 16,
                child: Text(
                  time.day.toString(),
                  style: const TextStyle(
                    color: AppColors.neutralF2F2F2,
                    fontSize: 14,
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
