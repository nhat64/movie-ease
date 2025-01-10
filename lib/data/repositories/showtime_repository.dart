import 'package:base_flutter/app/base/mvvm/model/base_repository.dart';
import 'package:base_flutter/app/base/mvvm/model/source/local/local_storage.dart';
import 'package:base_flutter/app/base/mvvm/model/source/network/api_result.dart';
import 'package:base_flutter/app/base/mvvm/model/source/network/base_response.dart';
import 'package:base_flutter/app/constans/app_strings.dart';

abstract class ShowtimePath {
  static const String getShowtimes = '/api/app/show-time/get-list';
  static String getDetailShowtime(int id) => '/api/app/room/get/$id';
}

class ShowtimeRepository extends BaseRepository {
  ShowtimeRepository()
      : super(
          baseUrl: AppStrings.baseUrl,
          token: LocalStorage.getString(LocalStorageKeys.accessToken),
        );

  Future<ApiResult> getShowtimes({
    int? movieId,
    required int cinemaId,
    required String date,
  }) async {
    try {
      final rs = await dioClient.get(ShowtimePath.getShowtimes, queryParameters: {
        'movie_id': movieId,
        'cinema_id': cinemaId,
        'date': date,
      });

      return ApiResult.apiSuccess(BaseResponse.fromJson(rs));
    } on Exception catch (e) {
      return ApiResult.apiFailure(e);
    }
  }

  Future<ApiResult> getDetailShowtime(int id) async {
    try {
      final rs = await dioClient.get(ShowtimePath.getDetailShowtime(id));

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

  Future<ApiResult> getMatrixSeatFake(int id) async {
    final BaseResponse rs = BaseResponse(
      status: 200,
      data: {
        'room_name': 'Phòng 1',
        'seat_list': matrixSeatEntities,
      },
    );
    return ApiResult.apiSuccess(rs);
  }
}

List<Map<String, dynamic>> listShowtime = [
  {
    "movie": {
      "id": 1,
      "poster": "https://iguov8nhvyobj.vcdn.cloud/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/3/5/350x495-linhmieu.jpg",
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
      "poster": "https://iguov8nhvyobj.vcdn.cloud/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/a/m/amazon-main-poster-printing.jpg",
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

final List<List<Map<String, dynamic>>> matrixSeatEntities = [
  [
    {"id": null, "code": null, "price": null, "type": null, "status": null},
    {"id": 1, "code": "A1", "price": 50000, "type": 2, "status": 1},
    {"id": 2, "code": "A2", "price": 50000, "type": 2, "status": 1},
    {"id": null, "code": null, "price": null, "type": null, "status": null},
    {"id": null, "code": null, "price": null, "type": null, "status": null},
    {"id": null, "code": null, "price": null, "type": null, "status": null},
    {"id": 3, "code": "A6", "price": 50000, "type": 2, "status": 1},
    {"id": 4, "code": "A7", "price": 50000, "type": 2, "status": 1},
    {"id": null, "code": null, "price": null, "type": null, "status": null},
    {"id": null, "code": null, "price": null, "type": null, "status": null},
    {"id": null, "code": null, "price": null, "type": null, "status": null},
    {"id": 5, "code": "A11", "price": 50000, "type": 2, "status": 1},
    {"id": 6, "code": "A12", "price": 50000, "type": 2, "status": 0},
    {"id": null, "code": null, "price": null, "type": null, "status": null},
    {"id": null, "code": null, "price": null, "type": null, "status": null},
  ],
  [
    {"id": 7, "code": "B0", "price": 50000, "type": 2, "status": 1},
    {"id": 8, "code": "B1", "price": 50000, "type": 2, "status": 0},
    {"id": 9, "code": "B2", "price": 50000, "type": 2, "status": 0},
    {"id": 10, "code": "B3", "price": 50000, "type": 2, "status": 0},
    {"id": null, "code": null, "price": null, "type": null, "status": null},
    {"id": 11, "code": "B5", "price": 50000, "type": 2, "status": 0},
    {"id": 12, "code": "B6", "price": 50000, "type": 2, "status": 0},
    {"id": 13, "code": "B7", "price": 50000, "type": 2, "status": 1},
    {"id": 14, "code": "B8", "price": 50000, "type": 2, "status": 1},
    {"id": null, "code": null, "price": null, "type": null, "status": null},
    {"id": 15, "code": "B10", "price": 50000, "type": 2, "status": 0},
    {"id": 16, "code": "B11", "price": 50000, "type": 2, "status": 0},
    {"id": 17, "code": "B12", "price": 50000, "type": 2, "status": 1},
    {"id": 18, "code": "B13", "price": 50000, "type": 2, "status": 1},
    {"id": null, "code": null, "price": null, "type": null, "status": null},
  ],
  [
    {"id": 19, "code": "C0", "price": 50000, "type": 2, "status": 0},
    {"id": 20, "code": "C1", "price": 50000, "type": 2, "status": 1},
    {"id": 21, "code": "C2", "price": 50000, "type": 2, "status": 1},
    {"id": 22, "code": "C3", "price": 50000, "type": 2, "status": 0},
    {"id": null, "code": null, "price": null, "type": null, "status": null},
    {"id": 23, "code": "C5", "price": 50000, "type": 2, "status": 0},
    {"id": 24, "code": "C6", "price": 50000, "type": 2, "status": 1},
    {"id": 25, "code": "C7", "price": 50000, "type": 2, "status": 0},
    {"id": 26, "code": "C8", "price": 50000, "type": 2, "status": 0},
    {"id": null, "code": null, "price": null, "type": null, "status": null},
    {"id": 27, "code": "C10", "price": 50000, "type": 2, "status": 1},
    {"id": 28, "code": "C11", "price": 50000, "type": 2, "status": 1},
    {"id": 29, "code": "C12", "price": 50000, "type": 2, "status": 1},
    {"id": 30, "code": "C13", "price": 50000, "type": 2, "status": 0},
    {"id": null, "code": null, "price": null, "type": null, "status": null},
  ],
  [
    {"id": 31, "code": "D0", "price": 50000, "type": 2, "status": 1},
    {"id": 32, "code": "D1", "price": 50000, "type": 2, "status": 0},
    {"id": 33, "code": "D2", "price": 50000, "type": 2, "status": 0},
    {"id": 34, "code": "D3", "price": 50000, "type": 2, "status": 1},
    {"id": null, "code": null, "price": null, "type": null, "status": null},
    {"id": 35, "code": "D5", "price": 50000, "type": 2, "status": 0},
    {"id": 36, "code": "D6", "price": 50000, "type": 2, "status": 0},
    {"id": 37, "code": "D7", "price": 50000, "type": 2, "status": 1},
    {"id": 38, "code": "D8", "price": 50000, "type": 2, "status": 0},
    {"id": null, "code": null, "price": null, "type": null, "status": null},
    {"id": 39, "code": "D10", "price": 50000, "type": 2, "status": 1},
    {"id": 40, "code": "D11", "price": 50000, "type": 2, "status": 0},
    {"id": 41, "code": "D12", "price": 50000, "type": 2, "status": 0},
    {"id": 42, "code": "D13", "price": 50000, "type": 2, "status": 0},
    {"id": null, "code": null, "price": null, "type": null, "status": null},
  ],
  [
    {"id": 43, "code": "E0", "price": 50000, "type": 1, "status": 1},
    {"id": 44, "code": "E1", "price": 50000, "type": 1, "status": 1},
    {"id": 45, "code": "E2", "price": 50000, "type": 1, "status": 1},
    {"id": 46, "code": "E3", "price": 50000, "type": 1, "status": 0},
    {"id": null, "code": null, "price": null, "type": null, "status": null},
    {"id": 47, "code": "E5", "price": 50000, "type": 1, "status": 1},
    {"id": 48, "code": "E6", "price": 50000, "type": 1, "status": 1},
    {"id": 49, "code": "E7", "price": 50000, "type": 1, "status": 1},
    {"id": 50, "code": "E8", "price": 50000, "type": 1, "status": 0},
    {"id": null, "code": null, "price": null, "type": null, "status": null},
    {"id": 51, "code": "E10", "price": 50000, "type": 1, "status": 0},
    {"id": 52, "code": "E11", "price": 50000, "type": 1, "status": 0},
    {"id": 53, "code": "E12", "price": 50000, "type": 1, "status": 1},
    {"id": 54, "code": "E13", "price": 50000, "type": 1, "status": 0},
    {"id": 55, "code": "E14", "price": 50000, "type": 1, "status": 1},
  ],
  [
    {"id": 56, "code": "F0", "price": 50000, "type": 1, "status": 0},
    {"id": 57, "code": "F1", "price": 50000, "type": 1, "status": 0},
    {"id": 58, "code": "F2", "price": 50000, "type": 1, "status": 0},
    {"id": 59, "code": "F3", "price": 50000, "type": 1, "status": 1},
    {"id": null, "code": null, "price": null, "type": null, "status": null},
    {"id": 60, "code": "F5", "price": 50000, "type": 1, "status": 1},
    {"id": 61, "code": "F6", "price": 50000, "type": 1, "status": 0},
    {"id": 62, "code": "F7", "price": 50000, "type": 1, "status": 1},
    {"id": 63, "code": "F8", "price": 50000, "type": 1, "status": 0},
    {"id": null, "code": null, "price": null, "type": null, "status": null},
    {"id": 64, "code": "F10", "price": 50000, "type": 1, "status": 0},
    {"id": 65, "code": "F11", "price": 50000, "type": 1, "status": 0},
    {"id": 66, "code": "F12", "price": 50000, "type": 1, "status": 1},
    {"id": 67, "code": "F13", "price": 50000, "type": 1, "status": 1},
    {"id": 68, "code": "F14", "price": 50000, "type": 1, "status": 1},
  ],
  [
    {"id": 69, "code": "G0", "price": 50000, "type": 1, "status": 1},
    {"id": 70, "code": "G1", "price": 50000, "type": 1, "status": 0},
    {"id": 71, "code": "G2", "price": 50000, "type": 1, "status": 1},
    {"id": 72, "code": "G3", "price": 50000, "type": 1, "status": 0},
    {"id": null, "code": null, "price": null, "type": null, "status": null},
    {"id": 73, "code": "G5", "price": 50000, "type": 1, "status": 1},
    {"id": 74, "code": "G6", "price": 50000, "type": 1, "status": 1},
    {"id": 75, "code": "G7", "price": 50000, "type": 1, "status": 0},
    {"id": 76, "code": "G8", "price": 50000, "type": 1, "status": 1},
    {"id": null, "code": null, "price": null, "type": null, "status": null},
    {"id": 77, "code": "G10", "price": 50000, "type": 1, "status": 1},
    {"id": 78, "code": "G11", "price": 50000, "type": 1, "status": 1},
    {"id": 79, "code": "G12", "price": 50000, "type": 1, "status": 1},
    {"id": 80, "code": "G13", "price": 50000, "type": 1, "status": 1},
    {"id": 81, "code": "G14", "price": 50000, "type": 1, "status": 1},
  ],
  [
    {"id": 82, "code": "H0", "price": 50000, "type": 1, "status": 0},
    {"id": 83, "code": "H1", "price": 50000, "type": 1, "status": 0},
    {"id": 84, "code": "H2", "price": 50000, "type": 1, "status": 0},
    {"id": 85, "code": "H3", "price": 50000, "type": 1, "status": 0},
    {"id": null, "code": null, "price": null, "type": null, "status": null},
    {"id": 86, "code": "H5", "price": 50000, "type": 1, "status": 0},
    {"id": 87, "code": "H6", "price": 50000, "type": 1, "status": 1},
    {"id": 88, "code": "H7", "price": 50000, "type": 1, "status": 1},
    {"id": 89, "code": "H8", "price": 50000, "type": 1, "status": 0},
    {"id": null, "code": null, "price": null, "type": null, "status": null},
    {"id": 90, "code": "H10", "price": 50000, "type": 1, "status": 1},
    {"id": 91, "code": "H11", "price": 50000, "type": 1, "status": 0},
    {"id": 92, "code": "H12", "price": 50000, "type": 1, "status": 1},
    {"id": 93, "code": "H13", "price": 50000, "type": 1, "status": 0},
    {"id": 94, "code": "H14", "price": 50000, "type": 1, "status": 1},
  ],
  [
    {"id": 95, "code": "I0", "price": 50000, "type": 2, "status": 1},
    {"id": 96, "code": "I1", "price": 50000, "type": 2, "status": 0},
    {"id": 97, "code": "I2", "price": 50000, "type": 2, "status": 0},
    {"id": 98, "code": "I3", "price": 50000, "type": 2, "status": 1},
    {"id": null, "code": null, "price": null, "type": null, "status": null},
    {"id": 99, "code": "I5", "price": 50000, "type": 2, "status": 1},
    {"id": 100, "code": "I6", "price": 50000, "type": 2, "status": 0},
    {"id": 101, "code": "I7", "price": 50000, "type": 2, "status": 0},
    {"id": 102, "code": "I8", "price": 50000, "type": 2, "status": 1},
    {"id": null, "code": null, "price": null, "type": null, "status": null},
    {"id": 103, "code": "I10", "price": 50000, "type": 2, "status": 1},
    {"id": 104, "code": "I11", "price": 50000, "type": 2, "status": 1},
    {"id": 105, "code": "I12", "price": 50000, "type": 2, "status": 1},
    {"id": 106, "code": "I13", "price": 50000, "type": 2, "status": 0},
    {"id": 107, "code": "I14", "price": 50000, "type": 2, "status": 0},
  ],
  [
    {"id": 108, "code": "J0", "price": 50000, "type": 2, "status": 1},
    {"id": 109, "code": "J1", "price": 50000, "type": 2, "status": 1},
    {"id": 110, "code": "J2", "price": 50000, "type": 2, "status": 1},
    {"id": 111, "code": "J3", "price": 50000, "type": 2, "status": 1},
    {"id": null, "code": null, "price": null, "type": null, "status": null},
    {"id": 112, "code": "J5", "price": 50000, "type": 2, "status": 0},
    {"id": 113, "code": "J6", "price": 50000, "type": 2, "status": 1},
    {"id": 114, "code": "J7", "price": 50000, "type": 2, "status": 0},
    {"id": 115, "code": "J8", "price": 50000, "type": 2, "status": 1},
    {"id": null, "code": null, "price": null, "type": null, "status": null},
    {"id": 116, "code": "J10", "price": 50000, "type": 2, "status": 0},
    {"id": 117, "code": "J11", "price": 50000, "type": 2, "status": 1},
    {"id": 118, "code": "J12", "price": 50000, "type": 2, "status": 1},
    {"id": 119, "code": "J13", "price": 50000, "type": 2, "status": 0},
    {"id": 120, "code": "J14", "price": 50000, "type": 2, "status": 0},
  ],
];
