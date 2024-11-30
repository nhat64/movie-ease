import 'package:base_flutter/app/base/widget_common/scale_button.dart';
import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/app/utils/time_convert.dart';
import 'package:base_flutter/data/entity/movie_entity.dart';
import 'package:base_flutter/presentation/routes/route_names.dart';
import 'package:base_flutter/presentation/widgets/ticket_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieSlideItemWidget extends StatelessWidget {
  const MovieSlideItemWidget({
    super.key,
    required this.movieItem,
    required this.width,
    required this.height,
    required this.offsetIndex,
  });

  final MovieEntity movieItem;
  final double width;
  final double height;

  /// chênh lêch giữa index của item và index hiện tại của pageView
  final double offsetIndex;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 100),
      opacity: offsetIndex.abs() <= 0.5 ? 1 : 0.4,
      child: TicketWidget(
        width: width,
        height: height,
        borderRadius: 14,
        notchRadius: 20,
        stubHeight: 80,
        backgroundColor: offsetIndex.abs() <= 0.5 ? AppColors.yellowFCC434 : Colors.white,
        contentWidget: _buildContent(),
        stubWidget: _buildStub(),
        onTap: () {
          if (offsetIndex.abs() == 0) {
            Get.toNamed(RouteName.movieDetail, arguments: movieItem);
          }
        },
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    Container(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        movieItem.poster,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 40,
            child: Text(
              movieItem.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.schedule,
                size: 10,
                fill: 1,
                color: Colors.black,
              ),
              const SizedBox(width: 3),
              Text(
                formatDurationToMinuteWord(movieItem.duration),
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 3),
              Text(
                movieItem.date,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _buildStub() {
    return Align(
      alignment: Alignment.center,
      child: LayoutBuilder(
        builder: (context, constraint) {
          return ScaleButton(
            onTap: () {
              if (offsetIndex.abs() == 0) {
                Get.toNamed(RouteName.selectCinema);
              }
            },
            child: Container(
              width: constraint.maxWidth * 0.8,
              height: 46,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white.withOpacity(0.6),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Mua vé',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
