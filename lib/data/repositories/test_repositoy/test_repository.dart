import 'dart:developer';

import 'package:base_flutter/app/constans/app_strings.dart';
import 'package:base_flutter/app/base/mvvm/model/base_repository.dart';
import 'package:base_flutter/app/base/mvvm/model/source/local/local_storage.dart';
import 'package:base_flutter/app/base/mvvm/model/source/network/api_result.dart';
import 'package:base_flutter/app/base/mvvm/model/source/network/base_response.dart';

class TestApiPath {
  static const test = '/test';
}

class TestRepository extends BaseRepository {
  TestRepository()
      : super(
          baseUrl: AppStrings.baseUrl,
          token: LocalStorage.getString(LocalStorageKeys.accessToken),
        );

  Future<ApiResult> testFunc() async {
    log('repository 1');

    try {
      final rs = BaseResponse.fromJson(await dioClient.get(TestApiPath.test));

      return ApiResult.apiSuccess(rs);
    } on Exception catch (e) {
      return ApiResult.apiFailure(e);
    }
  }
}
