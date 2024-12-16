import 'package:base_flutter/app/base/helper/log.dart';
import 'package:base_flutter/app/base/mvvm/view/base_screen.dart';
import 'package:base_flutter/app/base/widget_common/scale_button.dart';
import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/app/utils/caculator_book.dart';
import 'package:base_flutter/data/entity/seat_entity.dart';
import 'package:base_flutter/data/page_data/select_popcorn_data.dart';
import 'package:base_flutter/presentation/module/booking/select_seats/select_seats_controller.dart';
import 'package:base_flutter/presentation/widgets/money_text_widget.dart';
import 'package:base_flutter/presentation/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectSeatsPage extends BaseScreen<SelectSeatsController> {
  const SelectSeatsPage({super.key});

  @override
  Color? get screenBackgroundColor => Colors.black;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      title: Text(controller.pageData.showtime.name ?? ''),
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
    return Stack(
      children: [
        Positioned.fill(child: _buildBody(context)),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: _buildBottomSelected(context),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(
          () {
            if (controller.matrixSeat.isEmpty) {
              return const SizedBox();
            }

            int rowCount = controller.matrixSeat.length;
            int columnCount = controller.matrixSeat.first.length;

            const double gapColumnSeats = 10;
            const double gapRowSeats = 10;
            const double sizeSeat = 25;

            const double paddingHorizontalSeats = 30;

            return InteractiveViewer(
              transformationController: controller.transformationController,
              constrained: false,
              panEnabled: true,
              scaleEnabled: true,
              panAxis: PanAxis.free,
              boundaryMargin: EdgeInsets.zero,
              minScale: 1,
              maxScale: 5.0,
              child: Container(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  minWidth: constraints.maxWidth,
                ),
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: IntrinsicWidth(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      _bulildScreenMovie(
                        context,
                        width: columnCount * sizeSeat + (columnCount - 1) * gapColumnSeats + 2 * paddingHorizontalSeats,
                        height: 65,
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: paddingHorizontalSeats),
                        child: _buildMatrixSeat(
                          rowCount: rowCount,
                          columnCount: columnCount,
                          gapColumnSeats: gapColumnSeats,
                          gapRowSeats: gapRowSeats,
                          sizeSeat: sizeSeat,
                        ),
                      ),
                      const SizedBox(height: 30),
                      _buildNoteTypeSeats(),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildMatrixSeat({
    required int rowCount,
    required int columnCount,
    required double gapColumnSeats,
    required double gapRowSeats,
    required double sizeSeat,
  }) {
    return Obx(
      () {
        List<SeatEntity> listSelected = controller.selectedSeats;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < rowCount; i++) ...[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int j = 0; j < columnCount; j++) ...[
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        final SeatEntity seatEntity = controller.matrixSeat[i][j];
                        if (seatEntity.id != null && (seatEntity.status ?? StatusSeat.none.value) == StatusSeat.available.value) {
                          controller.onSelect(seatEntity);
                          Log.console('onSelect: ${seatEntity.id}');
                        }
                      },
                      child: _buildSeat(
                        id: controller.matrixSeat[i][j].id,
                        title: controller.matrixSeat[i][j].code,
                        isSelected: listSelected.contains(controller.matrixSeat[i][j]),
                        statusSeatValue: controller.matrixSeat[i][j].status,
                        typeSeatValue: controller.matrixSeat[i][j].type,
                        size: sizeSeat,
                      ),
                    ),
                    if (i != columnCount - 1) SizedBox(width: gapColumnSeats),
                  ],
                ],
              ),
              if (i != rowCount - 1) SizedBox(height: gapRowSeats),
            ],
          ],
        );
      },
    );
  }

  Widget _buildNoteTypeSeats() {
    buildRowNote(String title, Color color) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            buildRowNote("Ghế thường", AppColors.neutral1C1C1C),
            const SizedBox(height: 12),
            buildRowNote("Ghế VIP", const Color(0xFFFF5733)),
          ],
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            buildRowNote("Ghế đã chọn", AppColors.yellowFCC434),
            const SizedBox(height: 12),
            buildRowNote("Ghế đã đặt", const Color(0xFF261D08)),
          ],
        )
      ],
    );
  }

  Widget _buildSeat({
    required int? id,
    required String? title,
    required bool isSelected,
    required int? statusSeatValue,
    required int? typeSeatValue,
    double size = 25,
  }) {
    const Color normalColor = AppColors.neutral1C1C1C;
    const Color textNormalColor = Colors.white;

    const Color vipColor = Color(0xFFFF5733);
    const Color textVipColor = Colors.white;

    const Color selectedColor = AppColors.yellowFCC434;
    const Color textSelectedColor = Colors.black;

    const Color reservedColor = Color(0xFF261D08);
    const Color textReservedColor = AppColors.yellowFCC434;

    final Color color = statusSeatValue == StatusSeat.available.value
        ? (isSelected
            ? selectedColor
            : typeSeatValue == TypeSeat.normal.value
                ? normalColor
                : vipColor)
        : reservedColor;

    final Color textColor = statusSeatValue == StatusSeat.available.value
        ? (isSelected
            ? textSelectedColor
            : typeSeatValue == TypeSeat.normal.value
                ? textNormalColor
                : textVipColor)
        : textReservedColor;

    if (id == null) {
      return SizedBox(
        height: size,
        width: size,
      );
    }
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
      alignment: Alignment.center,
      child: Text(
        title ?? '',
        style: TextStyle(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _bulildScreenMovie(BuildContext context, {required double width, required double height}) {
    return SizedBox(
      height: height,
      child: Stack(
        children: [
          Positioned(
            top: -5,
            width: width < 500 ? 500 : width,
            child: ClipPath(
              clipper: ClipBorder(),
              child: Container(
                width: double.infinity,
                height: 70,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.yellowFCC434.withOpacity(0.3), Colors.transparent],
                    stops: const [
                      0.35,
                      1,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Màn hình",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: -10,
            width: width,
            child: ClipPath(
              clipper: ClipShadow(),
              child: Container(
                height: 50,
                width: double.infinity,
                color: AppColors.yellowFCC434,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSelected(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.animationShowPriceController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 90 * (1 - controller.animationShowPrice.value)),
          child: child,
        );
      },
      child: Container(
        height: 90,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () {
                      return Row(
                        children: [
                          const Text(
                            "Ghế ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              joinSeatToText(controller.selectedSeats),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 5),
                  Obx(
                    () {
                      return Row(
                        children: [
                          const Text(
                            "Tạm tính: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 5),
                          MoneyTextWidget(
                            money: caculatePrice(listSelected:  controller.selectedSeats),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            unitStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            unitRight: true,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            ScaleButton(
              onTap: () {
                Get.toNamed(
                  RouteName.selectPopcorn,
                  arguments: SelectPopcornPageData(
                    selectedSeats: controller.selectedSeats,
                    movie: controller.pageData.movie,
                    cinema: controller.pageData.cinema,
                    showtime: controller.pageData.showtime,
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.yellowFCC434,
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: const Text(
                  "Tiếp tục",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
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

class ClipShadow extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 2, -20, size.width, size.height);
    path.lineTo(size.width, size.height - 1);
    path.quadraticBezierTo(size.width / 2, -25, 0, size.height - 1);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class ClipBorder extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height - 30);
    path.quadraticBezierTo(size.width / 2, -20, 0, size.height - 30);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
