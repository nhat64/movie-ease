import 'package:base_flutter/data/entity/popcorn_entity.dart';
import 'package:base_flutter/data/entity/promotion_entity.dart';
import 'package:base_flutter/data/entity/seat_entity.dart';

String joinSeatToText(List<SeatEntity> listSelected) {
  return listSelected.reversed.map((e) => e.code).join(", ");
}

int caculatePrice({required List<SeatEntity> listSelected, PopcornEntity? popcorns, PromotionEntity? promotion}) {
  int price = 0;
  for (final seat in listSelected) {
    price += seat.price ?? 0;
  }

  if (popcorns != null) {
    price += popcorns.price;
  }

  if (promotion != null) {
    price -= promotion.discount;
  }

  return price > 0 ? price : 0;
}
