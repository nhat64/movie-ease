import 'package:base_flutter/app/base/helper/log.dart';
import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/data/entity/cinema_entity.dart';
import 'package:base_flutter/data/page_data/select_cinema_page_data.dart';
import 'package:base_flutter/data/repositories/cinema_repository.dart';
import 'package:get/get.dart';

class SelectCinemaController extends BaseController {
  final SelectCinemaPageData pageData;

  SelectCinemaController({required this.pageData});

  final CinemaRepository _cinemaRepository = CinemaRepository();

  RxList<CinemaEntity> cinemas = <CinemaEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchCinemas();
  }

  _fetchCinemas() async {
    final rs = await _cinemaRepository.getCinemasFake();

    List<CinemaEntity> tmpCinemas = [];

    await rs.when(
      apiSuccess: (res) async {
        tmpCinemas = (res.data as List).map((e) => CinemaEntity.fromJson(e)).toList();
        cinemas.value = tmpCinemas;
      },
      apiFailure: (error) async {
        Log.console('error: $error');
      },
    );

    return tmpCinemas;
  }
}
