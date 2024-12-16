import 'package:base_flutter/app/base/mvvm/model/base_repository.dart';
import 'package:base_flutter/app/base/mvvm/model/source/local/local_storage.dart';
import 'package:base_flutter/app/base/mvvm/model/source/network/api_result.dart';
import 'package:base_flutter/app/base/mvvm/model/source/network/base_response.dart';
import 'package:base_flutter/app/constans/app_strings.dart';

abstract class MoviePath {
  static const String getCinemas = '/api/app/cinema/get-list';
  static const String getCinemasLocation = '/api/app/cinema/location';
}

class CinemaRepository extends BaseRepository {
  CinemaRepository()
      : super(
          baseUrl: AppStrings.baseUrl,
          token: LocalStorage.getString(LocalStorageKeys.accessToken),
        );

  Future<ApiResult> getCinemas({
    double? latitude,
    double? longitude,
  }) async {
    try {
      final rs = await dioClient.get(
        (latitude != null && longitude != null) ? MoviePath.getCinemasLocation : MoviePath.getCinemas,
        queryParameters: (latitude != null && longitude != null)
            ? {
                'latitude': latitude,
                'longitude': longitude,
              }
            : null,
      );

      return ApiResult.apiSuccess(BaseResponse.fromJson(rs));
    } on Exception catch (e) {
      return ApiResult.apiFailure(e);
    }
  }
}

extension FakeDataCinema on CinemaRepository {
  Future<ApiResult> getCinemasFake() async {
    final BaseResponse rs = BaseResponse(
      status: 200,
      data: listCinema,
    );
    return ApiResult.apiSuccess(rs);
  }
}

List<dynamic> listCinema = [
  {
    "id": 1,
    "name": "CinemaEase Hà Đông",
    "address": "Số 10 - Trần Phú - Hà Đông - Hà Nội",
    "distance": "1.2 km",
  }
];
