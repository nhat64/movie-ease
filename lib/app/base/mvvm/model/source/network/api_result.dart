import 'package:base_flutter/app/base/mvvm/model/source/network/base_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_result.freezed.dart';

@freezed
abstract class ApiResult with _$ApiResult {
  const factory ApiResult.apiSuccess(BaseResponse data) = Success;

  const factory ApiResult.apiFailure(Exception error) = Failure;
}
