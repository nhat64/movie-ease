import 'package:base_flutter/app/base/mvvm/model/source/network/dio_client.dart';
import 'package:dio/dio.dart';

class BaseRepository {
  late DioClient dioClient;

  BaseRepository({
    required String baseUrl,
    String? token,
  }) {
    var dio = Dio();
    dioClient = DioClient(dio, baseUrl: baseUrl, token: token);
  }
}
