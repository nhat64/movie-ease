import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/data/entity/cinema_entity.dart';

class CinemaDetailController extends BaseController {
  final CinemaEntity cinema;

  CinemaDetailController(
    this.cinema,
  );
}