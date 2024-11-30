import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/data/page_data/select_seats_page_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

enum TypeSeat {
  normal(0),
  vip(1),
  none(2);

  final int value;
  const TypeSeat(this.value);

  TypeSeat fromValue(int value) {
    switch (value) {
      case 0:
        return TypeSeat.normal;
      case 1:
        return TypeSeat.vip;
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

class SeatEntity {
  @JsonKey(name: 'seat_id')
  final int? id;
  @JsonKey(name: 'seat_code')
  final String? code;
  @JsonKey(name: 'seat_type_id')
  final TypeSeat? type;
  @JsonKey(name: 'status')
  final StatusSeat? status;
  @JsonKey(name: 'ticket_price')
  final int? price;

  SeatEntity({
    required this.id,
    required this.code,
    required this.type,
    required this.status,
    required this.price,
  });
}

class SelectSeatsController extends BaseController with GetTickerProviderStateMixin {
  final SelectSeatsPageData pageData;

  SelectSeatsController({required this.pageData});

  final TransformationController transformationController = TransformationController();

  late AnimationController animationShowPriceController;
  late Animation<double> animationShowPrice;

  RxList<SeatEntity> selectedSeats = <SeatEntity>[].obs;

  bool isShowPrice = false;

  @override
  void onInit() {
    super.onInit();
    transformationController.value = Matrix4.identity()..scale(1.2);
    animationShowPriceController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    animationShowPrice = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: animationShowPriceController, curve: Curves.easeInOut));
  }

  @override
  void onReady() {}

  @override
  dispose() {
    transformationController.dispose();
    super.dispose();
  }

  onSelect(SeatEntity seat) {
    if (selectedSeats.contains(seat)) {
      selectedSeats.value = selectedSeats.where((element) => element != seat).toList();
      if (selectedSeats.isEmpty && isShowPrice) {
        isShowPrice = false;
        animationShowPriceController.reverse();
      }
    } else {
      selectedSeats.value = [...selectedSeats, seat];
      if (!isShowPrice && selectedSeats.isNotEmpty) {
        isShowPrice = true;
        animationShowPriceController.forward();
      }
    }
  }

  final List<List<int>> matrixSeats = [
    [0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0],
    [1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0],
    [1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0],
    [1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0],
    [1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1]
  ];

  final List<List<SeatEntity>> matrixSeatEntities = [
    [
      SeatEntity(id: null, code: null, price: null, type: TypeSeat.none, status: StatusSeat.none),
      SeatEntity(id: 1, code: "A1", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: 2, code: "A2", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: null, code: null, price: null, type: TypeSeat.none, status: StatusSeat.none),
      SeatEntity(id: null, code: null, price: null, type: TypeSeat.none, status: StatusSeat.none),
      SeatEntity(id: null, code: null, price: null, type: TypeSeat.none, status: StatusSeat.none),
      SeatEntity(id: 3, code: "A6", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: 4, code: "A7", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: null, code: null, price: null, type: TypeSeat.none, status: StatusSeat.none),
      SeatEntity(id: null, code: null, price: null, type: TypeSeat.none, status: StatusSeat.none),
      SeatEntity(id: null, code: null, price: null, type: TypeSeat.none, status: StatusSeat.none),
      SeatEntity(id: 5, code: "A11", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: 6, code: "A12", price: 50000, type: TypeSeat.normal, status: StatusSeat.available),
      SeatEntity(id: null, code: null, price: null, type: TypeSeat.none, status: StatusSeat.none),
      SeatEntity(id: null, code: null, price: null, type: TypeSeat.none, status: StatusSeat.none),
    ],
    [
      SeatEntity(id: 7, code: "B0", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: 8, code: "B1", price: 50000, type: TypeSeat.normal, status: StatusSeat.available),
      SeatEntity(id: 9, code: "B2", price: 50000, type: TypeSeat.normal, status: StatusSeat.available),
      SeatEntity(id: 10, code: "B3", price: 50000, type: TypeSeat.normal, status: StatusSeat.available),
      SeatEntity(id: null, code: null, price: null, type: TypeSeat.none, status: StatusSeat.none),
      SeatEntity(id: 11, code: "B5", price: 50000, type: TypeSeat.normal, status: StatusSeat.available),
      SeatEntity(id: 12, code: "B6", price: 50000, type: TypeSeat.normal, status: StatusSeat.available),
      SeatEntity(id: 13, code: "B7", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: 14, code: "B8", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: null, code: null, price: null, type: TypeSeat.none, status: StatusSeat.none),
      SeatEntity(id: 15, code: "B10", price: 50000, type: TypeSeat.normal, status: StatusSeat.available),
      SeatEntity(id: 16, code: "B11", price: 50000, type: TypeSeat.normal, status: StatusSeat.available),
      SeatEntity(id: 17, code: "B12", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: 18, code: "B13", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: null, code: null, price: null, type: TypeSeat.none, status: StatusSeat.none),
    ],
    [
      SeatEntity(id: 19, code: "C0", price: 50000, type: TypeSeat.normal, status: StatusSeat.available),
      SeatEntity(id: 20, code: "C1", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: 21, code: "C2", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: 22, code: "C3", price: 50000, type: TypeSeat.normal, status: StatusSeat.available),
      SeatEntity(id: null, code: null, price: null, type: TypeSeat.none, status: StatusSeat.none),
      SeatEntity(id: 23, code: "C5", price: 50000, type: TypeSeat.normal, status: StatusSeat.available),
      SeatEntity(id: 24, code: "C6", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: 25, code: "C7", price: 50000, type: TypeSeat.normal, status: StatusSeat.available),
      SeatEntity(id: 26, code: "C8", price: 50000, type: TypeSeat.normal, status: StatusSeat.available),
      SeatEntity(id: null, code: null, price: null, type: TypeSeat.none, status: StatusSeat.none),
      SeatEntity(id: 27, code: "C10", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: 28, code: "C11", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: 29, code: "C12", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: 30, code: "C13", price: 50000, type: TypeSeat.normal, status: StatusSeat.available),
      SeatEntity(id: null, code: null, price: null, type: TypeSeat.none, status: StatusSeat.none),
    ],
    [
      SeatEntity(id: 31, code: "D0", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: 32, code: "D1", price: 50000, type: TypeSeat.normal, status: StatusSeat.available),
      SeatEntity(id: 33, code: "D2", price: 50000, type: TypeSeat.normal, status: StatusSeat.available),
      SeatEntity(id: 34, code: "D3", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: null, code: null, price: null, type: TypeSeat.none, status: StatusSeat.none),
      SeatEntity(id: 35, code: "D5", price: 50000, type: TypeSeat.normal, status: StatusSeat.available),
      SeatEntity(id: 36, code: "D6", price: 50000, type: TypeSeat.normal, status: StatusSeat.available),
      SeatEntity(id: 37, code: "D7", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: 38, code: "D8", price: 50000, type: TypeSeat.normal, status: StatusSeat.available),
      SeatEntity(id: null, code: null, price: null, type: TypeSeat.none, status: StatusSeat.none),
      SeatEntity(id: 39, code: "D10", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: 40, code: "D11", price: 50000, type: TypeSeat.normal, status: StatusSeat.available),
      SeatEntity(id: 41, code: "D12", price: 50000, type: TypeSeat.normal, status: StatusSeat.available),
      SeatEntity(id: 42, code: "D13", price: 50000, type: TypeSeat.normal, status: StatusSeat.available),
      SeatEntity(id: null, code: null, price: null, type: TypeSeat.none, status: StatusSeat.none),
    ],
    [
      SeatEntity(id: 43, code: "E0", price: 50000, type: TypeSeat.vip, status: StatusSeat.reserved),
      SeatEntity(id: 44, code: "E1", price: 50000, type: TypeSeat.vip, status: StatusSeat.reserved),
      SeatEntity(id: 45, code: "E2", price: 50000, type: TypeSeat.vip, status: StatusSeat.reserved),
      SeatEntity(id: 46, code: "E3", price: 50000, type: TypeSeat.vip, status: StatusSeat.available),
      SeatEntity(id: null, code: null, price: null, type: TypeSeat.none, status: StatusSeat.none),
      SeatEntity(id: 47, code: "E5", price: 50000, type: TypeSeat.vip, status: StatusSeat.reserved),
      SeatEntity(id: 48, code: "E6", price: 50000, type: TypeSeat.vip, status: StatusSeat.reserved),
      SeatEntity(id: 49, code: "E7", price: 50000, type: TypeSeat.vip, status: StatusSeat.reserved),
      SeatEntity(id: 50, code: "E8", price: 50000, type: TypeSeat.vip, status: StatusSeat.available),
      SeatEntity(id: null, code: null, price: null, type: TypeSeat.none, status: StatusSeat.none),
      SeatEntity(id: 51, code: "E10", price: 50000, type: TypeSeat.vip, status: StatusSeat.available),
      SeatEntity(id: 52, code: "E11", price: 50000, type: TypeSeat.vip, status: StatusSeat.available),
      SeatEntity(id: 53, code: "E12", price: 50000, type: TypeSeat.vip, status: StatusSeat.reserved),
      SeatEntity(id: 54, code: "E13", price: 50000, type: TypeSeat.vip, status: StatusSeat.available),
      SeatEntity(id: 55, code: "E14", price: 50000, type: TypeSeat.vip, status: StatusSeat.reserved),
    ],
    [
      SeatEntity(id: 56, code: "F0", price: 50000, type: TypeSeat.vip, status: StatusSeat.available),
      SeatEntity(id: 57, code: "F1", price: 50000, type: TypeSeat.vip, status: StatusSeat.available),
      SeatEntity(id: 58, code: "F2", price: 50000, type: TypeSeat.vip, status: StatusSeat.available),
      SeatEntity(id: 59, code: "F3", price: 50000, type: TypeSeat.vip, status: StatusSeat.reserved),
      SeatEntity(id: null, code: null, price: null, type: TypeSeat.none, status: StatusSeat.none),
      SeatEntity(id: 60, code: "F5", price: 50000, type: TypeSeat.vip, status: StatusSeat.reserved),
      SeatEntity(id: 61, code: "F6", price: 50000, type: TypeSeat.vip, status: StatusSeat.available),
      SeatEntity(id: 62, code: "F7", price: 50000, type: TypeSeat.vip, status: StatusSeat.reserved),
      SeatEntity(id: 63, code: "F8", price: 50000, type: TypeSeat.vip, status: StatusSeat.available),
      SeatEntity(id: null, code: null, price: null, type: TypeSeat.none, status: StatusSeat.none),
      SeatEntity(id: 64, code: "F10", price: 50000, type: TypeSeat.vip, status: StatusSeat.available),
      SeatEntity(id: 65, code: "F11", price: 50000, type: TypeSeat.vip, status: StatusSeat.available),
      SeatEntity(id: 66, code: "F12", price: 50000, type: TypeSeat.vip, status: StatusSeat.reserved),
      SeatEntity(id: 67, code: "F13", price: 50000, type: TypeSeat.vip, status: StatusSeat.reserved),
      SeatEntity(id: 68, code: "F14", price: 50000, type: TypeSeat.vip, status: StatusSeat.reserved),
    ],
    [
      SeatEntity(id: 69, code: "G0", price: 50000, type: TypeSeat.vip, status: StatusSeat.reserved),
      SeatEntity(id: 70, code: "G1", price: 50000, type: TypeSeat.vip, status: StatusSeat.available),
      SeatEntity(id: 71, code: "G2", price: 50000, type: TypeSeat.vip, status: StatusSeat.reserved),
      SeatEntity(id: 72, code: "G3", price: 50000, type: TypeSeat.vip, status: StatusSeat.available),
      SeatEntity(id: null, code: null, price: null, type: TypeSeat.none, status: StatusSeat.none),
      SeatEntity(id: 73, code: "G5", price: 50000, type: TypeSeat.vip, status: StatusSeat.reserved),
      SeatEntity(id: 74, code: "G6", price: 50000, type: TypeSeat.vip, status: StatusSeat.reserved),
      SeatEntity(id: 75, code: "G7", price: 50000, type: TypeSeat.vip, status: StatusSeat.available),
      SeatEntity(id: 76, code: "G8", price: 50000, type: TypeSeat.vip, status: StatusSeat.reserved),
      SeatEntity(id: null, code: null, price: null, type: TypeSeat.none, status: StatusSeat.none),
      SeatEntity(id: 77, code: "G10", price: 50000, type: TypeSeat.vip, status: StatusSeat.reserved),
      SeatEntity(id: 78, code: "G11", price: 50000, type: TypeSeat.vip, status: StatusSeat.reserved),
      SeatEntity(id: 79, code: "G12", price: 50000, type: TypeSeat.vip, status: StatusSeat.reserved),
      SeatEntity(id: 80, code: "G13", price: 50000, type: TypeSeat.vip, status: StatusSeat.reserved),
      SeatEntity(id: 81, code: "G14", price: 50000, type: TypeSeat.vip, status: StatusSeat.reserved),
    ],
    [
      SeatEntity(id: 82, code: "H0", price: 50000, type: TypeSeat.vip, status: StatusSeat.available),
      SeatEntity(id: 83, code: "H1", price: 50000, type: TypeSeat.vip, status: StatusSeat.available),
      SeatEntity(id: 84, code: "H2", price: 50000, type: TypeSeat.vip, status: StatusSeat.available),
      SeatEntity(id: 85, code: "H3", price: 50000, type: TypeSeat.vip, status: StatusSeat.available),
      SeatEntity(id: null, code: null, price: null, type: TypeSeat.none, status: StatusSeat.none),
      SeatEntity(id: 86, code: "H5", price: 50000, type: TypeSeat.vip, status: StatusSeat.available),
      SeatEntity(id: 87, code: "H6", price: 50000, type: TypeSeat.vip, status: StatusSeat.reserved),
      SeatEntity(id: 88, code: "H7", price: 50000, type: TypeSeat.vip, status: StatusSeat.reserved),
      SeatEntity(id: 89, code: "H8", price: 50000, type: TypeSeat.vip, status: StatusSeat.available),
      SeatEntity(id: null, code: null, price: null, type: TypeSeat.none, status: StatusSeat.none),
      SeatEntity(id: 90, code: "H10", price: 50000, type: TypeSeat.vip, status: StatusSeat.reserved),
      SeatEntity(id: 91, code: "H11", price: 50000, type: TypeSeat.vip, status: StatusSeat.available),
      SeatEntity(id: 92, code: "H12", price: 50000, type: TypeSeat.vip, status: StatusSeat.reserved),
      SeatEntity(id: 93, code: "H13", price: 50000, type: TypeSeat.vip, status: StatusSeat.available),
      SeatEntity(id: 94, code: "H14", price: 50000, type: TypeSeat.vip, status: StatusSeat.reserved),
    ],
    [
      SeatEntity(id: 95, code: "I0", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: 96, code: "I1", price: 50000, type: TypeSeat.normal, status: StatusSeat.available),
      SeatEntity(id: 97, code: "I2", price: 50000, type: TypeSeat.normal, status: StatusSeat.available),
      SeatEntity(id: 98, code: "I3", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: null, code: null, price: null, type: TypeSeat.none, status: StatusSeat.none),
      SeatEntity(id: 99, code: "I5", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: 100, code: "I6", price: 50000, type: TypeSeat.normal, status: StatusSeat.available),
      SeatEntity(id: 101, code: "I7", price: 50000, type: TypeSeat.normal, status: StatusSeat.available),
      SeatEntity(id: 102, code: "I8", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: null, code: null, price: null, type: TypeSeat.none, status: StatusSeat.none),
      SeatEntity(id: 103, code: "I10", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: 104, code: "I11", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: 105, code: "I12", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: 106, code: "I13", price: 50000, type: TypeSeat.normal, status: StatusSeat.available),
      SeatEntity(id: 107, code: "I14", price: 50000, type: TypeSeat.normal, status: StatusSeat.available),
    ],
    [
      SeatEntity(id: 108, code: "J0", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: 109, code: "J1", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: 110, code: "J2", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: 111, code: "J3", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: null, code: null, price: null, type: TypeSeat.none, status: StatusSeat.none),
      SeatEntity(id: 112, code: "J5", price: 50000, type: TypeSeat.normal, status: StatusSeat.available),
      SeatEntity(id: 113, code: "J6", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: 114, code: "J7", price: 50000, type: TypeSeat.normal, status: StatusSeat.available),
      SeatEntity(id: 115, code: "J8", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: null, code: null, price: null, type: TypeSeat.none, status: StatusSeat.none),
      SeatEntity(id: 116, code: "J10", price: 50000, type: TypeSeat.normal, status: StatusSeat.available),
      SeatEntity(id: 117, code: "J11", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: 118, code: "J12", price: 50000, type: TypeSeat.normal, status: StatusSeat.reserved),
      SeatEntity(id: 119, code: "J13", price: 50000, type: TypeSeat.normal, status: StatusSeat.available),
      SeatEntity(id: 120, code: "J14", price: 50000, type: TypeSeat.normal, status: StatusSeat.available),
    ],
  ];
}
