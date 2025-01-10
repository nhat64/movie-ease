import 'package:base_flutter/app/base/mvvm/model/base_repository.dart';
import 'package:base_flutter/app/base/mvvm/model/source/local/local_storage.dart';
import 'package:base_flutter/app/base/mvvm/model/source/network/api_result.dart';
import 'package:base_flutter/app/base/mvvm/model/source/network/base_response.dart';
import 'package:base_flutter/app/constans/app_strings.dart';
import 'package:base_flutter/data/param_request/payment_request.dart';

abstract class BookPath {
  static const String payment = '/api/app/ticket/momo-payment';
  static String getMyBill(int type) => '/api/app/ticket/get/$type';
  static String getDetailBill(int id) => '/api/app/ticket/detail/$id';
}

class BookRepository extends BaseRepository {
  BookRepository()
      : super(
          baseUrl: AppStrings.baseUrl,
          token: LocalStorage.getString(LocalStorageKeys.accessToken),
        );

  Future<ApiResult> payment({required PaymentRequest data}) async {
    try {
      final rs = await dioClient.post(
        BookPath.payment,
        data: data.toJson(),
      );

      return ApiResult.apiSuccess(BaseResponse.fromJson(rs));
    } on Exception catch (e) {
      return ApiResult.apiFailure(e);
    }
  }

  Future<ApiResult> getListMyBill(int type) async {
    try {
      final rs = await dioClient.get(BookPath.getMyBill(type));

      return ApiResult.apiSuccess(BaseResponse.fromJson(rs));
    } on Exception catch (e) {
      return ApiResult.apiFailure(e);
    }
  }

  Future<ApiResult> getDetailBill(int id) async {
    try {
      final rs = await dioClient.get(BookPath.getDetailBill(id));

      return ApiResult.apiSuccess(BaseResponse.fromJson(rs));
    } on Exception catch (e) {
      return ApiResult.apiFailure(e);
    }
  }
}
