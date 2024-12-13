import 'package:base_flutter/app/base/mvvm/model/base_repository.dart';
import 'package:base_flutter/app/base/mvvm/model/source/local/local_storage.dart';
import 'package:base_flutter/app/base/mvvm/model/source/network/api_result.dart';
import 'package:base_flutter/app/base/mvvm/model/source/network/base_response.dart';
import 'package:base_flutter/app/constans/app_strings.dart';

abstract class ShowtimePath {
  static const String getShowtimes = '';
}

class ShowtimeRepository extends BaseRepository {
  ShowtimeRepository()
      : super(
          baseUrl: AppStrings.baseUrl,
          token: LocalStorage.getString(LocalStorageKeys.accessToken),
        );

  Future<ApiResult> getShowtimes() async {
    try {
      final rs = await dioClient.get(ShowtimePath.getShowtimes);

      return ApiResult.apiSuccess(BaseResponse.fromJson(rs));
    } on Exception catch (e) {
      return ApiResult.apiFailure(e);
    }
  }
}

extension FakeDataShowtime on ShowtimeRepository {
  // null là tất cả, 1 là đang chiếu, 2 là sắp chiếu
  Future<ApiResult> getShowtimesFake({int? movieStatus}) async {
    final BaseResponse rs = BaseResponse(
      status: 200,
      data: listShowtime,
    );
    return ApiResult.apiSuccess(rs);
  }
}

List<Map<String, dynamic>> listShowtime = [
  {
    "movie": {
      "id": 1,
      "poster":
          "https://iguov8nhvyobj.vcdn.cloud/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/3/5/350x495-linhmieu.jpg",
      "name": "LINH MIÊU",
      "date": "22-11-2024",
      "duration": 7200,
      "trailerUrl": "https://youtu.be/4oxoPMxBO6s",
      "director": "Lưu Thành Luân",
      "movieGenre": ["Kinh dị"],
      "rated": "18+",
      "country": "Việt Nam",
      "description":
          "Linh Miêu: Quỷ Nhập Tràng lấy cảm hứng từ truyền thuyết dân gian về “quỷ nhập tràng” để xây dựng cốt truyện. Phim lồng ghép những nét văn hóa đặc trưng của Huế như nghệ thuật khảm sành - một văn hóa đặc sắc của thời nhà Nguyễn, đề cập đến các vấn đề về giai cấp và quan điểm trọng nam khinh nữ. Đặc biệt, hình ảnh rước kiệu thây ma và những hình nhân giấy không chỉ biểu trưng cho tai ương hay điềm dữ mà còn là hiện thân của nghiệp quả."
    },
    "show_time": [
      {
        "id": 1,
        "movie_id": 1,
        "room_id": 2,
        "start_time": "13:30:00",
        "end_time": "15:50:00",
        "start_date": "2024-11-10",
        "created_at": "2024-10-17T15:54:56.000000Z",
        "updated_at": "2024-10-17T15:54:56.000000Z",
        "cinema_id": 1,
        "name": "Cinema 1",
        "seat_map": "[[1,0,1],[1,1,1],[1,1,1]]"
      },
      {
        "id": 2,
        "movie_id": 1,
        "room_id": 2,
        "start_time": "13:30:00",
        "end_time": "15:50:00",
        "start_date": "2024-11-10",
        "created_at": "2024-10-17T15:54:56.000000Z",
        "updated_at": "2024-10-17T15:54:56.000000Z",
        "cinema_id": 1,
        "name": "Cinema 1",
        "seat_map": "[[1,0,1],[1,1,1],[1,1,1]]"
      }
    ]
  },
  {
    "movie": {
      "id": 2,
      "poster":
          "https://iguov8nhvyobj.vcdn.cloud/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/a/m/amazon-main-poster-printing.jpg",
      "name": "CƯỜI XUYÊN BIÊN GIỚI",
      "date": "15-11-2024",
      "duration": 7200,
      "trailerUrl": "https://youtu.be/4ALt4VT7grw",
      "director": "KIM Chang-ju",
      "movieGenre": ["Hài"],
      "rated": "13+",
      "country": "Hàn Quốc",
      "description":
          "Cười Xuyên Biên Giới kể về hành trình của Jin-bong (Ryu Seung-ryong) - cựu vô địch bắn cung quốc gia, sau khi nghỉ hưu, anh đã trở thành một nhân viên văn phòng bình thường. Đứng trước nguy cơ bị sa thải, Jin-bong phải nhận một nhiệm vụ bất khả thi là bay đến nửa kia của trái đất trong nỗ lực tuyệt vọng để sinh tồn. Sống sót sau một sự cố đe doạ tính mạng, Jin-bong đã “hạ cánh” xuống khu rừng Amazon, nơi anh gặp bộ ba thổ dân bản địa có kỹ năng bắn cung thượng thừa: Sika, Eeba và Walbu. Tin rằng đã tìm ra cách để tự cứu mình, Jin-bong hợp tác với phiên dịch ngáo ngơ Bbang-sik (Jin Sun-kyu) và đưa ba chiến thần cung thủ đến Hàn Quốc cho một nhiệm vụ táo bạo."
    },
    "show_time": [
      {
        "id": 1,
        "movie_id": 2,
        "room_id": 2,
        "start_time": "13:30:00",
        "end_time": "15:50:00",
        "start_date": "2024-11-10",
        "created_at": "2024-10-17T15:54:56.000000Z",
        "updated_at": "2024-10-17T15:54:56.000000Z",
        "cinema_id": 1,
        "name": "Cinema 1",
        "seat_map": "[[1,0,1],[1,1,1],[1,1,1]]"
      },
      {
        "id": 2,
        "movie_id": 2,
        "room_id": 2,
        "start_time": "13:30:00",
        "end_time": "15:50:00",
        "start_date": "2024-11-10",
        "created_at": "2024-10-17T15:54:56.000000Z",
        "updated_at": "2024-10-17T15:54:56.000000Z",
        "cinema_id": 1,
        "name": "Cinema 1",
        "seat_map": "[[1,0,1],[1,1,1],[1,1,1]]"
      }
    ]
  }
];
