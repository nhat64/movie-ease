import 'package:base_flutter/app/base/mvvm/model/base_repository.dart';
import 'package:base_flutter/app/base/mvvm/model/source/local/local_storage.dart';
import 'package:base_flutter/app/base/mvvm/model/source/network/api_result.dart';
import 'package:base_flutter/app/base/mvvm/model/source/network/base_response.dart';
import 'package:base_flutter/app/constans/app_strings.dart';

abstract class MoviePath {
  static const String getCinemas = '';
}

class CinemaRepository extends BaseRepository {
  CinemaRepository()
      : super(
          baseUrl: AppStrings.baseUrl,
          token: LocalStorage.getString(SharedPreferencesKeys.accessToken),
        );

  Future<ApiResult> getCinemas() async {
    try {
      final rs = await dioClient.get(MoviePath.getCinemas);

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
    "created_at": "2024-10-20T14:11:39.000000Z",
    "updated_at": "2024-10-20T14:11:39.000000Z",
  }
];
