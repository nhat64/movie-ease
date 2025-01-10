import 'package:base_flutter/app/base/helper/log.dart';
import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/data/entity/promotion_entity.dart';
import 'package:base_flutter/data/repositories/promotion_repository.dart';
import 'package:get/get.dart';

class VoucherController extends BaseController {
  VoucherController();

  RxList<PromotionEntity> listPromotion = <PromotionEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPromotions();
  }

  fetchPromotions() async {
    final promotionRepos = PromotionRepository();

    loading.value = true;

    final rs = await promotionRepos.getPromotions();

    rs.when(
      apiSuccess: (res) {
        if (res.status == 200) {
          listPromotion.value = (res.data as List).map((e) => PromotionEntity.fromJson(e)).toList();
        } else {
          Log.console('error: ${res.message}');
        }
        loading.value = false;
      },
      apiFailure: (error) async {
        Log.console('error: $error');
        loading.value = false;
      },
    );
  }
}
