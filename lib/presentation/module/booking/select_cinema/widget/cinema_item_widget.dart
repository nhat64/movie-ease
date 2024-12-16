import 'package:base_flutter/app/constans/app_assets.dart';
import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/data/entity/cinema_entity.dart';
import 'package:flutter/material.dart';

class CinemaItemWidget extends StatelessWidget {
  const CinemaItemWidget({
    super.key,
    required this.cinema,
    this.onTap,
  });

  final CinemaEntity cinema;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.neutral1C1C1C,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 130,
        child: Row(
          children: [
            Container(
              width: 110,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                ImagePaths.imgBannerVoucher,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 6, bottom: 8, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cinema.name ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      cinema.address ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.neutral878787,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 16,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: AppColors.yellowFCC434,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            cinema.distance ?? 'km',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
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
  }
}
