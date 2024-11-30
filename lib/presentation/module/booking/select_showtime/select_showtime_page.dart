import 'package:base_flutter/app/base/mvvm/view/base_screen.dart';
import 'package:base_flutter/data/entity/group_showtime_entity.dart';
import 'package:base_flutter/data/page_data/select_seats_page_data.dart';
import 'package:base_flutter/presentation/module/booking/select_showtime/select_showtime_controller.dart';
import 'package:base_flutter/presentation/module/booking/select_showtime/widget/showtime_item_widget.dart';
import 'package:base_flutter/presentation/module/booking/select_showtime/widget/time_item_widget.dart';
import 'package:base_flutter/presentation/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectShowtimePage extends BaseScreen<SelectShowtimeController> {
  const SelectShowtimePage({super.key});

  @override
  Color? get screenBackgroundColor => Colors.black;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      title: const Text('Chọn suất chiếu'),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        _buildSelectDate(),
        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            child: _buildListShowtime(),
          ),
        )
      ],
    );
  }

  _buildSelectDate() {
    return SizedBox(
      height: 83,
      child: Obx(
        () => ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: controller.timeItems
              .map(
                (time) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TimeItemWidget(
                    time: time,
                    isSelected: time.day == controller.selectedTime.value.day,
                    onTap: () {
                      controller.selectedTime.value = time;
                    },
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  _buildListShowtime() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: controller.listGroupShowtime
              .map(
                (element) => _buildGroupShowtime(groupShowtime: element),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildGroupShowtime({
    required GroupShowtimeEntity groupShowtime,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            groupShowtime.movie.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 14),
        LayoutBuilder(
          builder: (context, constraints) {
            final double maxWidth = constraints.maxWidth;
            const double aspectRatio = 0.9;
            const double space = 16;
            return Wrap(
              spacing: space,
              runSpacing: space,
              children: groupShowtime.showtime
                  .map(
                    (e) => ShowtimeItemWidget(
                      showtime: e,
                      width: (maxWidth - 2 * space) / 3,
                      aspectRatio: aspectRatio,
                      onTap: () {
                        Get.toNamed(
                          RouteName.selectSeats,
                          arguments: SelectSeatsPageData(
                            movie: groupShowtime.movie,
                            showtime: e,
                            cinema: controller.pageData.cinema,
                          ),
                        );
                      },
                    ),
                  )
                  .toList(),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
