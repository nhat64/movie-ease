import 'package:base_flutter/app/base/mvvm/model/base_repository.dart';
import 'package:base_flutter/app/base/mvvm/model/source/local/local_storage.dart';
import 'package:base_flutter/app/base/mvvm/model/source/network/api_result.dart';
import 'package:base_flutter/app/base/mvvm/model/source/network/base_response.dart';
import 'package:base_flutter/app/constans/app_strings.dart';

abstract class BookPath {
  static const String reservation = '/api/app/ticket/reservation';
  static const String payment = '/api/app/ticket/momo-payment';
  static const String handelPayment = '/api/app/ticket/handle-momo-payment';
}

class BookRepository extends BaseRepository {
  BookRepository()
      : super(
          baseUrl: AppStrings.baseUrl,
          token: LocalStorage.getString(LocalStorageKeys.accessToken),
        );

  Future<ApiResult> reservation({
    required int cinemaId,
    required int showTimeId,
    required List<int> seatIds,
  }) async {
    try {
      final rs = await dioClient.post(
        BookPath.reservation,
        data: {
          'cinema_id': cinemaId,
          'show_time_id': showTimeId,
          'seat_ids': seatIds.toString(),
        },
      );

      return ApiResult.apiSuccess(BaseResponse.fromJson(rs));
    } on Exception catch (e) {
      return ApiResult.apiFailure(e);
    }
  }

  Future<ApiResult> payment({
    required int amount,
    required int cinemaId,
    required int showTimeId,
    int? extraData,
    int? foodId,
    int? foodQuantity,
  }) async {
    try {
      final rs = await dioClient.post(
        BookPath.payment,
        data: {
          'amount': amount,
          'cinema_id': cinemaId,
          'show_time_id': showTimeId,
          'extraData': extraData,
          'food_id': foodId,
          'food_quantity': foodQuantity,
        },
      );

      return ApiResult.apiSuccess(BaseResponse.fromJson(rs));
    } on Exception catch (e) {
      return ApiResult.apiFailure(e);
    }
  }

  handlePayment(String partnerCode) async {
    try {
      final rs = await dioClient.get(
        BookPath.handelPayment,
        queryParameters: {
          'partnerCode': partnerCode,
        },
      );

      return ApiResult.apiSuccess(BaseResponse.fromJson(rs));
    } on Exception catch (e) {
      return ApiResult.apiFailure(e);
    }
  }
}
