import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:base_flutter/app/base/helper/log.dart';
import 'package:base_flutter/app/base/mvvm/model/source/network/api_result.dart';
import 'package:base_flutter/app/base/timer_countdown/timer_countdown_service.dart';
import 'package:base_flutter/app/base/widget_common/call_api_widget.dart';
import 'package:base_flutter/app/base/widget_common/custom_snack_bar.dart';
import 'package:base_flutter/data/param_request/payment_request.dart';
import 'package:base_flutter/data/repositories/book_repository.dart';
import 'package:base_flutter/data/response/payment_reponse.dart';
import 'package:base_flutter/presentation/module/booking/select_seats/select_seats_controller.dart';
import 'package:base_flutter/presentation/widgets/app_dialog/show_aler_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentService {
  BookRepository get _bookRepository => BookRepository();

  PaymentService() {
    _appLinkHandel();
    _listenerRegister();
  }

  // thông tin thanh toán
  PaymentRequest? request;

  // link thanh toán
  String paymentLink = '';

  // hoá đơn chưa thanh toán
  // Bill? bill

  // timmer
  final TimerCountdownService timerCountdownService = TimerCountdownService();

  Rx<bool> isWaitingPayment = false.obs;

  StreamSubscription<Uri>? _appLinkSubscription;

  setPaymentRequest(PaymentRequest data) {
    request = data;
  }

  dispose() {
    request = null;
    paymentLink = '';
    isWaitingPayment.value = false;
    timerCountdownService.cancelTimer();
    _appLinkSubscription?.cancel();
  }

  _listenerRegister() {
    timerCountdownService.currentSeconds.addListener(
      () {
        if (timerCountdownService.currentSeconds.value == 0) {
          WidgetsBinding.instance.addPostFrameCallback(
            (timeStamp) {
              showAlerDialog(
                content: 'Hết thời gian thanh toán',
                onOk: () {
                  Get.close(3);
                  Get.find<SelectSeatsController>().selectedSeats.value = [];
                  Get.find<SelectSeatsController>().onRefresh();
                },
              );
            },
          );
        }
      },
    );
  }

  // xử lý app link thanh toán trả về
  _appLinkHandel() {
    final appLinks = AppLinks();

    _appLinkSubscription = appLinks.uriLinkStream.listen((uri) async {
      Log.console('uri: $uri');

      if (uri.toString() != 'http://movieease.com/' && uri.toString() != 'http://movieease.com') {
        return;
      }

      timerCountdownService.cancelTimer();

      isWaitingPayment.value = false;

      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          showAlerDialog(
            content: 'Thanh toán thành công !',
            onOk: () {
              if (Get.currentRoute == '/payment') {
                Get.close(5);
              }
            },
          );
        },
      );
    });
  }

  callApiPayment() async {
    if (request == null || isWaitingPayment.value) {
      return;
    }

    final ApiResult rs = await CallApiWidget.checkTimeCallApi(
      api: _bookRepository.payment(data: request!),
      context: Get.context!,
    );

    await rs.when(
      apiSuccess: (res) async {
        if (res.status == 200) {
          PaymentResponse data = PaymentResponse.fromJson(res.data);

          paymentLink = data.payUrl ?? '';

          await launchLinkPayment();
          timerCountdownService.startCountdown(10 * 60);

          isWaitingPayment.value = true;
        } else {
          isWaitingPayment.value = false;
          showCustomSnackBar(title: 'Thanh toán', message: res.message ?? '');
        }
      },
      apiFailure: (error) async {
        Log.console('error: $error');
        isWaitingPayment.value = false;
      },
    );
  }

  launchLinkPayment() async {
    Uri uri = Uri.tryParse(paymentLink) ?? Uri();
    if (await canLaunchUrl(uri)) {
      launchUrl(uri);
    } else {
      showCustomSnackBar(title: 'Thanh toán', message: 'Không thể mở liên kết thanh toán');
    }
  }
}
