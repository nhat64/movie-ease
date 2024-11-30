import 'dart:math';

import 'package:json_annotation/json_annotation.dart';

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

enum TypeSeat {
  normal(0),
  vip(1),
  none(2);

  final int value;
  const TypeSeat(this.value);

  static TypeSeat fromValue(int value) {
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

  static StatusSeat fromValue(int value) {
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

int idCounter = 1; // Start IDs from 1

List<SeatEntity> generateSeats(
  List<List<int>> matrix,
  int row,
) {
  List<SeatEntity> seats = [];

  for (int col = 0; col < matrix[row].length; col++) {
    int matrixValue = matrix[row][col];

    if (matrixValue == 1) {
      // Generate a random status (available or reserved)
      final randomStatus = StatusSeat.values[new Random().nextInt(2)]; // 0 or 1
      seats.add(SeatEntity(
        id: idCounter++,
        code: '${rowToKey[row]}$col',
        type: row >= 4 && row <= 7 ? TypeSeat.vip : TypeSeat.normal,
        status: randomStatus,
        price: 50000,
      ));
    } else {
      // No seat
      seats.add(SeatEntity(
        id: null,
        code: null,
        price: null,
        type: TypeSeat.none,
        status: StatusSeat.none,
      ));
    }
  }
  return seats;
}

final Map<int, String> rowToKey = {
  0: 'A',
  1: 'B',
  2: 'C',
  3: 'D',
  4: 'E',
  5: 'F',
  6: 'G',
  7: 'H',
  8: 'I',
  9: 'J',
};

void main() {
  for (int i = 0; i < matrixSeats.length; i++) {
    List<SeatEntity> generatedSeats = generateSeats(matrixSeats, i);
    print('[');
    for (var seat in generatedSeats) {
      print("SeatEntity("
          "id: ${seat.id}, "
          "code: ${seat.code == null ? null : "\"${seat.code}\""}, "
          "price: ${seat.price}, "
          "type: ${seat.type}, "
          "status: ${seat.status}"
          "),");
    }
    print('],');
  }
}
