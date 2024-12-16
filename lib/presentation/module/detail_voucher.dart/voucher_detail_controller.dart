import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/data/entity/promotion_entity.dart';

class VoucherDetailController extends BaseController {
  final PromotionEntity promotion;

  VoucherDetailController(
    this.promotion,
  );
}
