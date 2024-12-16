import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/app/constans/app_assets.dart';
import 'package:base_flutter/data/entity/payment_menthod_entity.dart';
import 'package:base_flutter/data/entity/promotion_entity.dart';
import 'package:base_flutter/data/page_data/payment_page_data.dart';
import 'package:base_flutter/presentation/module/voucher/voucher_controller.dart';
import 'package:get/get.dart';

class PaymentController extends BaseController {
  final PaymentPageData pageData;

  PaymentController({required this.pageData});

  final List<PaymentMenthodEntity> listMenthod = [
    PaymentMenthodEntity(id: 0, name: 'MoMo', image: ImagePaths.imgMomo),
    PaymentMenthodEntity(id: 1, name: 'Zalopay', image: ImagePaths.imgZalopay),
  ];

  late List<PromotionEntity> promotions;

  Rx<PaymentMenthodEntity?> selectedMenthod = Rx(null);
  Rx<PromotionEntity?> promotionSelected = Rx(null);

  @override
  void onInit() {
    super.onInit();
    selectedMenthod.value = listMenthod.first;
    promotions = Get.find<VoucherController>().listPromotion;
  }

  onSelectPromotion(PromotionEntity promotion) {
    if (promotionSelected.value?.id == promotion.id) {
      promotionSelected.value = null;
    } else {
      promotionSelected.value = promotion;
    }
  }
}
