import 'package:base_flutter/app/base/helper/log.dart';
import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/data/entity/popcorn_entity.dart';
import 'package:base_flutter/data/page_data/select_popcorn_data.dart';
import 'package:base_flutter/data/repositories/popcorn_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopcornController extends BaseController with GetTickerProviderStateMixin {
  final SelectPopcornPageData pageData;

  PopcornController(this.pageData);

  final _popcornRepos = Get.find<PopcornRepository>();

  RxList<PopcornEntity> listPopcorn = <PopcornEntity>[].obs;

  RxMap<PopcornEntity, int> listFoodOrder = <PopcornEntity, int>{}.obs;

  late AnimationController animationShowPriceController;
  late Animation<double> animationShowPrice;
  bool isShowPrice = false;

  @override
  void onInit() {
    super.onInit();

    animationShowPriceController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    animationShowPrice = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: animationShowPriceController, curve: Curves.easeInOut));

    _fetchPopcorns();
  }

  onAddFood(PopcornEntity food) {
    Map<PopcornEntity, int> tmpMap = Map.from(listFoodOrder);

    if (tmpMap.containsKey(food)) {
      if (tmpMap[food]! >= 99) {
        return;
      }
      tmpMap[food] = tmpMap[food]! + 1;
    } else {
      tmpMap[food] = 1;
    }

    listFoodOrder.value = tmpMap;

    checkNeedShowBottomSheet();
  }

  onDecreaseFood(PopcornEntity food) {
    Map<PopcornEntity, int> tmpMap = Map.from(listFoodOrder);

    if (tmpMap.containsKey(food)) {
      if (tmpMap[food]! > 1) {
        tmpMap[food] = tmpMap[food]! - 1;
      } else {
        tmpMap.remove(food);
      }
    }

    listFoodOrder.value = tmpMap;
    checkNeedShowBottomSheet();
  }

  canRemoveFood(PopcornEntity food) {
    return listFoodOrder.containsKey(food);
  }

  checkNeedShowBottomSheet() {
    if (listFoodOrder.isNotEmpty && !isShowPrice) {
      isShowPrice = true;
      animationShowPriceController.forward();
    }

    if (listFoodOrder.isEmpty && isShowPrice) {
      isShowPrice = false;
      animationShowPriceController.reverse();
    }
  }

  _fetchPopcorns() async {
    loading.value = true;

    final rs = await _popcornRepos.getPopcorns();

    rs.when(
      apiSuccess: (res) {
        if (res.status == 200) {
          listPopcorn.value = (res.data as List).map((e) => PopcornEntity.fromJson(e)).toList();
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
