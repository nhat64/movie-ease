import 'package:base_flutter/app/base/mvvm/model/source/network/api_result.dart';
import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/app/base/widget_common/call_api_widget.dart';
import 'package:base_flutter/data/entity/seat_entity.dart';
import 'package:base_flutter/data/page_data/select_seats_page_data.dart';
import 'package:base_flutter/data/repositories/showtime_repository.dart';
import 'package:base_flutter/data/response/showtime_detail_response.dart';
import 'package:base_flutter/presentation/widgets/app_dialog/show_aler_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum TypeSeat {
  vip(1),
  normal(2),
  twin(3),
  none(4);

  final int value;
  const TypeSeat(this.value);

  TypeSeat fromValue(int value) {
    switch (value) {
      case 1:
        return TypeSeat.vip;
      case 2:
        return TypeSeat.normal;
      case 3:
        return TypeSeat.twin;
      default:
        return TypeSeat.none;
    }
  }
}

enum StatusSeat {
  available(0),
  reserved(1),
  none(2);

  final int value;
  const StatusSeat(this.value);

  StatusSeat fromValue(int value) {
    switch (value) {
      case 0:
        return StatusSeat.available;
      case 1:
        return StatusSeat.reserved;
      default:
        return StatusSeat.none;
    }
  }
}

class SelectSeatsController extends BaseController with GetTickerProviderStateMixin {
  final SelectSeatsPageData pageData;

  SelectSeatsController({required this.pageData});

  final _showtimeRepository = Get.find<ShowtimeRepository>();

  final TransformationController transformationController = TransformationController();

  late AnimationController animationShowPriceController;
  late Animation<double> animationShowPrice;

  RxList<SeatEntity> selectedSeats = <SeatEntity>[].obs;
  RxList<List<SeatEntity>> matrixSeat = <List<SeatEntity>>[].obs;

  bool isShowPrice = false;

  @override
  void onInit() {
    super.onInit();
    transformationController.value = Matrix4.identity()..scale(1.2);
    animationShowPriceController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    animationShowPrice = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: animationShowPriceController, curve: Curves.easeInOut));
  }

  @override
  void onReady() {
    super.onReady();
    _callApiGetDetail();
  }

  @override
  dispose() {
    transformationController.dispose();
    super.dispose();
  }

  onRefresh() {
    if (selectedSeats.isEmpty && isShowPrice) {
      isShowPrice = false;
      animationShowPriceController.reverse();
    }
    _callApiGetDetail();
  }

  onSelect(SeatEntity seat) {
    if (selectedSeats.contains(seat)) {
      selectedSeats.value = selectedSeats.where((element) => element != seat).toList();
      if (selectedSeats.isEmpty && isShowPrice) {
        isShowPrice = false;
        animationShowPriceController.reverse();
      }
    } else {
      if (_checkSeatMoreThan8()) {
        return;
      }

      selectedSeats.value = [...selectedSeats, seat];
      if (!isShowPrice && selectedSeats.isNotEmpty) {
        isShowPrice = true;
        animationShowPriceController.forward();
      }
    }
  }

  _checkSeatMoreThan8() {
    if (selectedSeats.length >= 8) {
      showAlerDialog(content: 'Bạn chỉ được chọn tối đa 8 ghế');
      return true;
    }
    return false;
  }

  _callApiGetDetail() async {
    final ApiResult result = await CallApiWidget.checkTimeCallApi(
      api: _showtimeRepository.getDetailShowtime(pageData.showtime.id),
      context: Get.context!,
    );

    result.when(
      apiSuccess: (res) {
        if (res.status == 200) {
          final showtimeDetail = ShowtimeDetailResponse.fromJson(res.data);
          matrixSeat.value = showtimeDetail.seatList ?? [];
        } else {
          // do something
        }
      },
      apiFailure: (error) {
        // do something
      },
    );
  }
}
  // final List<List<int>> matrixSeats = [
  //   [0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0],
  //   [1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0],
  //   [1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0],
  //   [1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0],
  //   [1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1],
  //   [1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1],
  //   [1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1],
  //   [1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1],
  //   [1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1],
  //   [1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1]
  // ];