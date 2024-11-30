import 'package:base_flutter/app/base/helper/log.dart';
import 'package:base_flutter/app/base/mvvm/view/base_screen.dart';
import 'package:base_flutter/app/base/widget_common/scale_button.dart';
import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/data/page_data/payment_page_data.dart';
import 'package:base_flutter/presentation/module/booking/select_seats/select_seats_controller.dart';
import 'package:base_flutter/presentation/module/booking/select_seats/widget/money_text_widget.dart';
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
    const int rowCount = 10;
    const int columnCount = 15;

    const double paddingHorizontalSeats = 30;
    const double gapColumnSeats = 10;
    const double gapRowSeats = 10;
    const double sizeSeat = 25;

    return LayoutBuilder(builder: (context, constraints) {
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
                  child: Obx(
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
                                      final SeatEntity seatEntity = controller.matrixSeatEntities[i][j];
                                      if ((seatEntity.status?.value ?? StatusSeat.none.value) == StatusSeat.available.value && seatEntity.id != null) {
                                        controller.onSelect(seatEntity);
                                        Log.console('onSelect: ${seatEntity.id}');
                                      }
                                    },
                                    child: _buildSeat(
                                      id: controller.matrixSeatEntities[i][j].id,
                                      title: controller.matrixSeats[i][j] == 0 ? "" : controller.matrixSeatEntities[i][j].code,
                                      isSelected: listSelected.contains(controller.matrixSeatEntities[i][j]),
                                      statusSeatValue: controller.matrixSeatEntities[i][j].status?.value,
                                      typeSeatValue: controller.matrixSeatEntities[i][j].type?.value,
                                      size: sizeSeat,
                                    ),
                                  ),
                                  if (i != columnCount - 1) const SizedBox(width: gapColumnSeats),
                                ],
                              ],
                            ),
                            if (i != rowCount - 1) const SizedBox(height: gapRowSeats),
                          ],
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
                _buildNoteTypeSeats(),
              ],
            ),
          ),
        ),
      );
    });
  }

  _buildNoteTypeSeats() {
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

  _buildSeat({
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

  _buildBottomSelected(BuildContext context) {
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
                            money: caculatePrice(controller.selectedSeats),
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
                  RouteName.payment,
                  arguments: PaymentPageData(
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

  String joinSeatToText(List<SeatEntity> listSelected) {
    return listSelected.reversed.map((e) => e.code).join(", ");
  }

  int caculatePrice(List<SeatEntity> listSelected) {
    int price = 0;
    for (final seat in listSelected) {
      price += seat.price ?? 0;
    }
    return price;
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
