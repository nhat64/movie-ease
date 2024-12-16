import 'package:base_flutter/app/base/mvvm/model/base_repository.dart';
import 'package:base_flutter/app/base/mvvm/model/source/local/local_storage.dart';
import 'package:base_flutter/app/base/mvvm/model/source/network/api_result.dart';
import 'package:base_flutter/app/base/mvvm/model/source/network/base_response.dart';
import 'package:base_flutter/app/constans/app_strings.dart';

abstract class AuthPath {
  static const String login = '/api/app/auth/login';
  static const String register = '/api/app/auth/register';
  static const String forgot = '/api/app/forgot-password';
}

class AuthRepository extends BaseRepository {
  AuthRepository()
      : super(
          baseUrl: AppStrings.baseUrl,
          token: LocalStorage.getString(LocalStorageKeys.accessToken),
        );

  Future<ApiResult> login(
      {required String username, required String pass}) async {
    try {
      final rs = await dioClient.post(AuthPath.login, data: {
        "username": username,
        "password": pass,
        "device_token": "xxxx"
      });

      return ApiResult.apiSuccess(BaseResponse.fromJson(rs));
    } on Exception catch (e) {
      return ApiResult.apiFailure(e);
    }
  }

  Future<ApiResult> register({
    required String name,
    required String username,
    required String pass,
    required String phone,
    required String email,
  }) async {
    try {
      final rs = await dioClient.post(AuthPath.register, data: {
        "email": email,
        "name": name,
        "phone_number": phone,
        "username": username,
        "password": pass,
      });

      return ApiResult.apiSuccess(BaseResponse.fromJson(rs));
    } on Exception catch (e) {
      return ApiResult.apiFailure(e);
    }
  }

  Future<ApiResult> forgot({required String email}) async {
    try {
      final rs = await dioClient.post(AuthPath.forgot, data: {
        "email": email,
      });

      return ApiResult.apiSuccess(BaseResponse.fromJson(rs));
    } on Exception catch (e) {
      return ApiResult.apiFailure(e);
    }
  }
}
