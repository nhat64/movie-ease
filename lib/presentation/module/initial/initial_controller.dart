import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/presentation/routes/route_names.dart';
import 'package:get/get.dart';

class InitialController extends BaseController with GetSingleTickerProviderStateMixin {
  InitialController();

  @override
  void onReady() {
    Future.delayed(
      const Duration(milliseconds: 1500),
      () async {
        await _initData();
        await appProvider.determinePosition();
        Get.offNamed(RouteName.root);
      },
    );
  }

  _initData() async {
    appProvider.showingMovies.value = await appProvider.callApiGetListMovie(videoStatus: 1);
    appProvider.comingMovies.value = await appProvider.callApiGetListMovie(videoStatus: 2);
    await appProvider.getApiProfile();
  }
}
