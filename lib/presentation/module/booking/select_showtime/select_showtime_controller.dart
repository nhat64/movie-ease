import 'package:base_flutter/app/base/helper/log.dart';
import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/data/entity/group_showtime_entity.dart';
import 'package:base_flutter/data/page_data/select_showtime_page_data.dart';
import 'package:base_flutter/data/repositories/showtime_repository.dart';
import 'package:get/get.dart';

class SelectShowtimeController extends BaseController {
  final SelectShowtimePageData pageData;

  SelectShowtimeController({required this.pageData});

  final ShowtimeRepository _showtimeRepository = ShowtimeRepository();

  // 2 tuần kể từ hiện tại
  final List<DateTime> timeItems = List<DateTime>.generate(
    7,
    (index) {
      return DateTime.utc(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ).add(Duration(days: index));
    },
  );

  Rx<DateTime> selectedTime = Rx<DateTime>(DateTime.now());

  RxList<GroupShowtimeEntity> listGroupShowtime = <GroupShowtimeEntity>[].obs;

  @override
  onInit() {
    super.onInit();
    _fetchShowtime(dateTime: selectedTime.value);
  }

  _fetchShowtime({required DateTime dateTime}) async {
    listGroupShowtime.value = [];

    final result = await _showtimeRepository.getShowtimesFake();

    result.when(
      apiSuccess: (res) {
        listGroupShowtime.value = (res.data as List).map((e) => GroupShowtimeEntity.fromJson(e)).toList();
      },
      apiFailure: (error) {
        Log.console(error);
      },
    );
  }
}
