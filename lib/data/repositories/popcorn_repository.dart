import 'package:base_flutter/app/base/mvvm/model/base_repository.dart';
import 'package:base_flutter/app/base/mvvm/model/source/local/local_storage.dart';
import 'package:base_flutter/app/base/mvvm/model/source/network/api_result.dart';
import 'package:base_flutter/app/base/mvvm/model/source/network/base_response.dart';
import 'package:base_flutter/app/constans/app_strings.dart';

abstract class PopcornPath {
  static const String getPopcorns = '/api/admin/foods';
}

class PopcornRepository extends BaseRepository {
  PopcornRepository()
      : super(
          baseUrl: AppStrings.baseUrl,
          token: LocalStorage.getString(LocalStorageKeys.accessToken),
        );

  Future<ApiResult> getPopcorns() async {
    try {
      final rs = await dioClient.get(PopcornPath.getPopcorns);

      return ApiResult.apiSuccess(BaseResponse.fromJson(rs));
    } on Exception catch (e) {
      return ApiResult.apiFailure(e);
    }
  }
}