import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/data/entity/cinema_entity.dart';
import 'package:base_flutter/data/page_data/select_showtime_page_data.dart';
import 'package:base_flutter/presentation/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CinemaItemWidget extends StatelessWidget {
  const CinemaItemWidget({super.key, required this.cinema});

  final CinemaEntity cinema;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          RouteName.selectShowtime,
          arguments: SelectShowtimePageData(cinema: cinema),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.neutral1C1C1C,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cinema.name ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              cinema.address ?? '',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
