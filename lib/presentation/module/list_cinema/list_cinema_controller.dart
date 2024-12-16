import 'package:base_flutter/app/base/helper/log.dart';
import 'package:base_flutter/app/base/mvvm/model/source/network/api_result.dart';
import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/data/entity/cinema_entity.dart';
import 'package:base_flutter/data/repositories/cinema_repository.dart';
import 'package:get/get.dart';

class ListCinemaController extends BaseController {
  ListCinemaController();

  final CinemaRepository _cinemaRepository = CinemaRepository();

  RxList<CinemaEntity> cinemas = <CinemaEntity>[].obs;

  @override
  void onReady() {
    super.onReady();
    _fetchCinemas();
  }

  _fetchCinemas() async {
    loading.value = true;

    if (appProvider.position.value == null) {
      await appProvider.determinePosition();
    }

    final ApiResult rs = await _cinemaRepository.getCinemas(
      latitude: appProvider.position.value?.latitude,
      longitude: appProvider.position.value?.longitude,
    );

    List<CinemaEntity> tmpCinemas = [];

    rs.when(
      apiSuccess: (res) {
        tmpCinemas = (res.data as List).map((e) => CinemaEntity.fromJson(e)).toList();
        cinemas.value = tmpCinemas;

        loading.value = false;
      },
      apiFailure: (error) {
        Log.console('error: $error');
        loading.value = false;
      },
    );
  }
}
