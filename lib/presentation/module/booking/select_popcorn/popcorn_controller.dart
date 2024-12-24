import 'package:base_flutter/app/base/helper/log.dart';
import 'package:base_flutter/app/base/mvvm/model/source/network/api_result.dart';
import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/app/base/widget_common/call_api_widget.dart';
import 'package:base_flutter/app/base/widget_common/custom_snack_bar.dart';
import 'package:base_flutter/data/entity/popcorn_entity.dart';
import 'package:base_flutter/data/page_data/payment_page_data.dart';
import 'package:base_flutter/data/page_data/select_popcorn_data.dart';
import 'package:base_flutter/data/repositories/book_repository.dart';
import 'package:base_flutter/data/repositories/popcorn_repository.dart';
import 'package:base_flutter/presentation/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopcornController extends BaseController with GetTickerProviderStateMixin {
  final SelectPopcornPageData pageData;

  PopcornController(this.pageData);

  final _popcornRepos = Get.find<PopcornRepository>();
  final _bookRepository = BookRepository();

  RxList<PopcornEntity> listPopcorn = <PopcornEntity>[].obs;

  Rx<PopcornEntity?> selectedPopcorn = Rx<PopcornEntity?>(null);

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

  onSelectPopcorn(PopcornEntity popcorn) {
    if (selectedPopcorn.value?.id == popcorn.id) {
      selectedPopcorn.value = null;
      isShowPrice = false;
      animationShowPriceController.reverse();
    } else {
      selectedPopcorn.value = popcorn;
      if (!isShowPrice) {
        isShowPrice = true;
        animationShowPriceController.forward();
      }
    }
  }

  reservation({PopcornEntity? popcorn}) async {
    final ApiResult rs = await CallApiWidget.checkTimeCallApi(
      api: _bookRepository.reservation(
        cinemaId: pageData.cinema.id,
        showTimeId: pageData.showtime.id,
        seatIds: pageData.selectedSeats.map((e) => e.id!).toList(),
      ),
      context: Get.context!,
    );

    rs.when(
      apiSuccess: (res) {
        if (res.status == 200) {
          Get.toNamed(
            RouteName.payment,
            arguments: PaymentPageData(
              selectedSeats: pageData.selectedSeats,
              movie: pageData.movie,
              cinema: pageData.cinema,
              showtime: pageData.showtime,
              popcorns: popcorn,
            ),
          );
        } else {
          showSnackBar(title: 'Thanh toán', message: res.message ?? '');
        }
      },
      apiFailure: (error) {
        Log.console('error: $error');
      },
    );
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
