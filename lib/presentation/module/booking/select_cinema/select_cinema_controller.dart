import 'package:base_flutter/app/base/helper/log.dart';
import 'package:base_flutter/app/base/mvvm/model/source/network/api_result.dart';
import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/data/entity/cinema_entity.dart';
import 'package:base_flutter/data/page_data/select_cinema_page_data.dart';
import 'package:base_flutter/data/page_data/select_showtime_page_data.dart';
import 'package:base_flutter/data/repositories/cinema_repository.dart';
import 'package:base_flutter/presentation/routes/route_names.dart';
import 'package:base_flutter/presentation/widgets/app_dialog/show_login_warning_dialog.dart';
import 'package:get/get.dart';

class SelectCinemaController extends BaseController {
  final SelectCinemaPageData pageData;

  SelectCinemaController({required this.pageData});

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

    await rs.when(
      apiSuccess: (res) async {
        tmpCinemas = (res.data as List).map((e) => CinemaEntity.fromJson(e)).toList();
        cinemas.value = tmpCinemas;
      },
      apiFailure: (error) async {
        Log.console('error: $error');
      },
    );

    loading.value = false;
  }

  onSelectCinema(CinemaEntity cinema) async {
    if (appProvider.isAuth == false) {
      final isLoginOk = await showShouldLoginDialog();
      if (isLoginOk == false) {
        return;
      }
    }

    Get.toNamed(
      RouteName.selectShowtime,
      arguments: SelectShowtimePageData(
        cinema: cinema,
        movie: pageData.movie,
      ),
    );
  }
}
