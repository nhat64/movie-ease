import 'package:base_flutter/app/base/helper/log.dart';
import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:base_flutter/app/base/widget_common/call_api_widget.dart';
import 'package:base_flutter/app/utils/time_convert.dart';
import 'package:base_flutter/data/entity/movie_entity.dart';
import 'package:base_flutter/data/page_data/select_showtime_page_data.dart';
import 'package:base_flutter/data/repositories/showtime_repository.dart';
import 'package:get/get.dart';

class SelectShowtimeController extends BaseController {
  final SelectShowtimePageData pageData;

  SelectShowtimeController({required this.pageData});

  final _showtimeRepository = Get.find<ShowtimeRepository>();

  // 1 tuần kể từ hiện tại
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

  RxList<MovieEntity> movieShowtime = <MovieEntity>[].obs;

  @override
  void onReady() {
    super.onReady();
    _fetchShowtime(dateTime: selectedTime.value);
  }

  onSelectdTime(DateTime time) {
    selectedTime.value = time;
    _fetchShowtime(dateTime: time);
  }

  _fetchShowtime({required DateTime dateTime}) async {
    movieShowtime.value = [];

    final result = await CallApiWidget.checkTimeCallApi(
      api: _showtimeRepository.getShowtimes(
        movieId: pageData.movie?.id,
        cinemaId: pageData.cinema.id,
        date: convertDateToYYYYMMDD(dateTime),
      ),
      context: Get.context!,
    );

    result.when(
      apiSuccess: (res) {
        movieShowtime.value = (res.data as List).map((e) => MovieEntity.fromJson(e)).toList();
      },
      apiFailure: (error) {
        Log.console(error);
      },
    );
  }
}
