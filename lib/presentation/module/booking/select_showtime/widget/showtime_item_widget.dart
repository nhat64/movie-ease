import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/data/entity/showtime_entiry.dart';
import 'package:flutter/material.dart';

class ShowtimeItemWidget extends StatelessWidget {
  const ShowtimeItemWidget({
    super.key,
    required this.showtime,
    required this.width,
    required this.aspectRatio,
    this.onTap,
  });

  final ShowtimeEntity showtime;

  final double width;

  /// width / height
  final double aspectRatio;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: width / aspectRatio,
        decoration: BoxDecoration(
          color: AppColors.neutral1D1D1D,
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              showtime.name ?? 'Screen',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Text(
              '13:30-15:50',
              style: TextStyle(
                color: AppColors.yellowFCC434,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '50/70 Ghế',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
