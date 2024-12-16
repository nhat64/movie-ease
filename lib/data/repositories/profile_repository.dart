import 'package:base_flutter/app/base/mvvm/model/base_repository.dart';
import 'package:base_flutter/app/base/mvvm/model/source/local/local_storage.dart';
import 'package:base_flutter/app/base/mvvm/model/source/network/api_result.dart';
import 'package:base_flutter/app/base/mvvm/model/source/network/base_response.dart';
import 'package:base_flutter/app/constans/app_strings.dart';

abstract class ProfilePath {
  static const String getProfile = '/api/app/profile';
  static const String changedPass = '/api/app/change-password';
}

class ProfileRepository extends BaseRepository {
  ProfileRepository()
      : super(
          baseUrl: AppStrings.baseUrl,
          token: LocalStorage.getString(LocalStorageKeys.accessToken),
        );

  Future<ApiResult> getProfile() async {
    try {
      final rs = await dioClient.get(ProfilePath.getProfile);

      return ApiResult.apiSuccess(BaseResponse.fromJson(rs));
    } on Exception catch (e) {
      return ApiResult.apiFailure(e);
    }
  }

  Future<ApiResult> changePass({required String oldPass, required String newPass, required String confirm}) async {
    try {
      final rs = await dioClient.post(ProfilePath.changedPass, data: {
        "current_password": oldPass,
        "new_password": newPass,
        "new_password_confirmation": confirm,
      });

      return ApiResult.apiSuccess(BaseResponse.fromJson(rs));
    } on Exception catch (e) {
      return ApiResult.apiFailure(e);
    }
  }
}
