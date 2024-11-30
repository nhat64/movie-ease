import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/app/constans/app_assets.dart';
import 'package:base_flutter/data/entity/payment_menthod_entity.dart';
import 'package:base_flutter/data/page_data/payment_page_data.dart';
import 'package:get/get.dart';

class PaymentController extends BaseController {
  final PaymentPageData pageData;

  PaymentController({required this.pageData});

  final List<PaymentMenthodEntity> listMenthod = [
    PaymentMenthodEntity(id: 0, name: 'MoMo', image: ImagePaths.imgMomo),
    PaymentMenthodEntity(id: 1, name: 'Zalopay', image: ImagePaths.imgZalopay),
  ];

  Rx<PaymentMenthodEntity?> selectedMenthod = Rx(null);

  @override
  void onInit() {
    super.onInit();
    selectedMenthod.value = listMenthod.first;
  }
}
