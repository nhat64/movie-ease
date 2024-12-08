import 'dart:math';

import 'package:flutter/material.dart';

class CustomPath {
  /// sau khi bo tròn góc đi qua lần lượt 3 điển p1 đến p2 đến p3 thì path sẽ đang ở p3
  /// distance là khoảng cách điểm bo tròn x1, x2 trên hai đường nối p1-p2 và p3-p2 đến p2
  /// 
  /// thực hiện arcToPoint từ x1 đến x2 với bán kính r được tính để bo tròn
  /// 
  /// đường tròn đi qua 2 điểm x1 và x2 sẽ coi hai đường thẳng p1-p2 và p3-p2 là 2 đường tiếp tuyến, vì như này là trông nó mượt nhất, dễ tính r nữa
  ///
  /// cần bổ xung khả năng tự xác định chiều kim đồng hồ sao cho chiều quay khiến hco cung tròn nằm trong góc nhọn
  static void roundSharpCorners(Point<double> p1, Point<double> p2, Point<double> p3, double distance, Path path) {
    final Point<double> x1 = findLinearPoint(p2, Offset(p1.x - p2.x, p1.y - p2.y), distance);
    final Point<double> x2 = findLinearPoint(p2, Offset(p3.x - p2.x, p3.y - p2.y), distance);

    final double h = x1.distanceTo(x2) / 2;

    final double r = (distance * h) / sqrt(distance * distance - h * h);

    path.moveTo(p1.x, p1.y);
    path.lineTo(x1.x, x1.y);
    path.arcToPoint(
      Offset(x2.x, x2.y),
      radius: Radius.circular(r),
      clockwise: false,
    );
    path.lineTo(p3.x, p3.y);
  }

  /// tìm toạ độ điểm cách point một khoảng distance theo vector chỉ phương
  static Point<double> findLinearPoint(Point<double> point, Offset vector, double distance) {
    // Tính độ dài của vectơ
    double distanceAB = vector.distance;

    // Chuẩn hóa vectơ (vectơ đơn vị)
    double unitDx = vector.dx / distanceAB;
    double unitDy = vector.dy / distanceAB;

    // Nhân vectơ đơn vị với khoảng cách z để có vectơ dịch chuyển
    double shiftDx = unitDx * distance;
    double shiftDy = unitDy * distance;

    // Tính tọa độ điểm mới
    return Point<double>(point.x + shiftDx, point.y + shiftDy);
  }
}
