import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/app/base/timer_countdown/timer_countdown_service.dart';
import 'package:base_flutter/app/constans/app_assets.dart';
import 'package:base_flutter/app/utils/caculator_book.dart';
import 'package:base_flutter/data/entity/payment_menthod_entity.dart';
import 'package:base_flutter/data/entity/promotion_entity.dart';
import 'package:base_flutter/data/page_data/payment_page_data.dart';
import 'package:base_flutter/data/param_request/payment_request.dart';
import 'package:base_flutter/presentation/module/voucher/voucher_controller.dart';
import 'package:base_flutter/service/payment_service.dart';
import 'package:get/get.dart';

class PaymentController extends BaseController {
  final PaymentPageData pageData;

  final paymentService = Get.find<PaymentService>();

  PaymentController({required this.pageData});

  final List<PaymentMenthodEntity> listMenthod = [
    PaymentMenthodEntity(id: 0, name: 'MoMo', image: ImagePaths.imgMomo),
    // PaymentMenthodEntity(id: 1, name: 'Zalopay', image: ImagePaths.imgZalopay),
  ];
  late List<PromotionEntity> promotions;

  Rx<PaymentMenthodEntity?> selectedMenthod = Rx(null);
  Rx<PromotionEntity?> promotionSelected = Rx(null);

  TimerCountdownService get timerCountdownService => paymentService.timerCountdownService;
  Rx<bool> get isWaitingPayment => paymentService.isWaitingPayment;

  @override
  void onInit() {
    super.onInit();
    selectedMenthod.value = listMenthod.first;
    promotions = Get.find<VoucherController>().listPromotion;
  }

  @override
  void onClose() {
    super.onClose();
    paymentService.dispose();
  }

  onSelectPromotion(PromotionEntity promotion) {
    if (promotionSelected.value?.id == promotion.id) {
      promotionSelected.value = null;
    } else {
      promotionSelected.value = promotion;
    }
  }

  onPayment() {
    if (paymentService.isWaitingPayment.value) {
      paymentService.launchLinkPayment();
    } else {
      payment();
    }
  }

  payment() async {
    final data = PaymentRequest(
      amount: caculatePrice(
        listSelected: pageData.selectedSeats,
        promotion: promotionSelected.value,
        foodOrdered: pageData.foodOrdered,
      ),
      cinemaId: pageData.cinema.id,
      showTimeId: pageData.showtime.id,
      extraData: promotionSelected.value?.id.toString(),
      food: pageData.foodOrdered?.entries.map((e) => FoodOrder(foodId: e.key.id, foodQuantity: e.value)).toList(),
      selectedSeats: pageData.selectedSeats.map((e) => e.id!).toList(),
    );

    paymentService.setPaymentRequest(data);
    paymentService.callApiPayment();
  }
}
