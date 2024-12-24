import 'package:app_links/app_links.dart';
import 'package:base_flutter/app/base/helper/log.dart';
import 'package:base_flutter/app/base/mvvm/model/source/network/api_result.dart';
import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/app/base/timer_countdown/timer_countdown_service.dart';
import 'package:base_flutter/app/base/widget_common/call_api_widget.dart';
import 'package:base_flutter/app/base/widget_common/custom_snack_bar.dart';
import 'package:base_flutter/app/constans/app_assets.dart';
import 'package:base_flutter/app/utils/caculator_book.dart';
import 'package:base_flutter/data/entity/payment_menthod_entity.dart';
import 'package:base_flutter/data/entity/promotion_entity.dart';
import 'package:base_flutter/data/page_data/payment_page_data.dart';
import 'package:base_flutter/data/repositories/book_repository.dart';
import 'package:base_flutter/data/response/payment_reponse.dart';
import 'package:base_flutter/presentation/module/voucher/voucher_controller.dart';
import 'package:base_flutter/presentation/widgets/app_dialog/show_aler_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentController extends BaseController {
  final PaymentPageData pageData;

  PaymentController({required this.pageData});

  final _bookRepository = BookRepository();

  final TimerCountdownService timerCountdownService = TimerCountdownService();

  final List<PaymentMenthodEntity> listMenthod = [
    PaymentMenthodEntity(id: 0, name: 'MoMo', image: ImagePaths.imgMomo),
    PaymentMenthodEntity(id: 1, name: 'Zalopay', image: ImagePaths.imgZalopay),
  ];

  late List<PromotionEntity> promotions;

  Rx<PaymentMenthodEntity?> selectedMenthod = Rx(null);
  Rx<PromotionEntity?> promotionSelected = Rx(null);

  Rx<bool> isWaitingPayment = false.obs;

  String linkPayment = '';

  @override
  void onInit() {
    super.onInit();
    appLinkHandel();
    selectedMenthod.value = listMenthod.first;
    promotions = Get.find<VoucherController>().listPromotion;
  }

  @override
  onReady() {
    super.onReady();
    timerCountdownService.startCountdown(5 * 60);
  }

  onSelectPromotion(PromotionEntity promotion) {
    if (promotionSelected.value?.id == promotion.id) {
      promotionSelected.value = null;
    } else {
      promotionSelected.value = promotion;
    }
  }

  onPayment() {
    if (isWaitingPayment.value) {
      launchLinkPayment(linkPayment);
    } else {
      payment();
    }
  }

  payment() async {
    final ApiResult rs = await CallApiWidget.checkTimeCallApi(
      api: _bookRepository.payment(
        cinemaId: pageData.cinema.id,
        showTimeId: pageData.showtime.id,
        amount: caculatePrice(
          listSelected: pageData.selectedSeats,
          promotion: promotionSelected.value,
          popcorns: pageData.popcorns,
        ),
        extraData: promotionSelected.value?.id,
        foodId: pageData.popcorns?.id,
        foodQuantity: 1,
      ),
      context: Get.context!,
    );

    await rs.when(
      apiSuccess: (res) async {
        if (res.status == 200) {
          PaymentResponse data = PaymentResponse.fromJson(res.data);

          linkPayment = data.payUrl ?? '';

          await launchLinkPayment(linkPayment);

          isWaitingPayment.value = true;
        } else {
          isWaitingPayment.value = false;
          showSnackBar(title: 'Thanh toán', message: res.message ?? '');
        }
      },
      apiFailure: (error) async {
        Log.console('error: $error');
        isWaitingPayment.value = false;
      },
    );
  }

  launchLinkPayment(String link) async {
    Uri uri = Uri.tryParse(linkPayment) ?? Uri();
    if (await canLaunchUrl(uri)) {
      launchUrl(uri);
    } else {
      showSnackBar(title: 'Thanh toán', message: 'Không thể mở liên kết thanh toán');
    }
  }

  appLinkHandel() {
    final appLinks = AppLinks();

    final sub = appLinks.uriLinkStream.listen((uri) async {
      // Handle the uri
      Log.console('uri: $uri');

      String? partnerCode = uri.queryParameters['partnerCode'];

      if (partnerCode != null && partnerCode.isNotEmpty) {
        final ApiResult rs = await CallApiWidget.checkTimeCallApi(
          api: _bookRepository.handlePayment(partnerCode),
          context: Get.context!,
        );

        await rs.when(
          apiSuccess: (res) async {
            if (res.status == 200) {
              timerCountdownService.cancelTimer();
              WidgetsBinding.instance.addPostFrameCallback(
                (timeStamp) {
                  showAlerDialog(
                    content: 'Thanh toán thành công !',
                    onOk: () {
                      Get.close(4);
                    },
                  );
                },
              );
            } else {
              showSnackBar(title: 'Thanh toán', message: res.message ?? '');
            }
            isWaitingPayment.value = false;
          },
          apiFailure: (error) async {
            Log.console('error: $error');
            isWaitingPayment.value = false;
          },
        );
      }
    });
  }
}
