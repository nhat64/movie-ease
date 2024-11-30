import 'dart:convert';
import 'dart:io';

import 'package:base_flutter/app/base/helper/log.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class DioClient {
  late Dio _dio;

  final String baseUrl;
  final String? token;

  final List<Interceptor>? interceptors;

  DioClient(
    Dio dio, {
    required this.baseUrl,
    this.token,
    this.interceptors,
  }) {
    _dio = dio;

    _dio
      ..options.baseUrl = baseUrl
      ..options.headers = getHeader()
      ..options.connectTimeout = const Duration(seconds: 10)
      ..options.receiveTimeout = const Duration(seconds: 10)
      ..httpClientAdapter;

    if (interceptors?.isNotEmpty ?? false) {
      _dio.interceptors.addAll(interceptors!);
    }

    // ADD LOG
    _dio.interceptors.add(LoggingInterceptor());

    _dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        // Don't trust any certificate just because their root cert is trusted.
        final HttpClient client = HttpClient(context: SecurityContext(withTrustedRoots: false));
        // You can test the intermediate / root cert here. We just ignore it.
        client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
        return client;
      },
    );
  }

  Map<String, dynamic> getHeader() {
    String? token = this.token;
    if (token == null || token.isEmpty) {
      return {
        'Content-Type': 'application/json; charset=UTF-8',
      };
    } else {
      return {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      };
    }
  }

  Future<Map<String, dynamic>> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return jsonDecode(response.data);
    } on SocketException catch (e) {
      Log.console(e, where: 'GET $baseUrl$uri', level: LogLevel.error);
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      Log.console('Unable to process the data', where: 'GET $baseUrl$uri', level: LogLevel.error);
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return jsonDecode(response.data);
    } on FormatException catch (_) {
      Log.console('Unable to process the data', where: 'POST $baseUrl$uri', level: LogLevel.error);
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> patch(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return jsonDecode(response.data);
    } on FormatException catch (_) {
      Log.console('Unable to process the data', where: 'PATCH $baseUrl$uri', level: LogLevel.error);
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return jsonDecode(response.data);
    } on FormatException catch (_) {
      Log.console('Unable to process the data', where: 'PUT $baseUrl$uri', level: LogLevel.error);
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      var response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return jsonDecode(response.data);
    } on FormatException catch (_) {
      Log.console('Unable to process the data', where: 'DELETE $baseUrl$uri', level: LogLevel.error);
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }
}

class LoggingInterceptor extends Interceptor {
  LoggingInterceptor();

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.extra['start_time'] = DateTime.now().millisecondsSinceEpoch;

    var msg = 'URI: ${options.uri}\n';
    msg += 'METHOD: ${options.method}\n';
    msg += 'HEADERS: ${options.headers}\n';
    if (options.data != null) {
      msg += 'BODY: ${options.data}';
    }

    Log.console(msg, where: 'REQUEST', level: LogLevel.info);

    return handler.next(options);
  }

  @override
  void onError(err, ErrorInterceptorHandler handler) {
    // Error when send reqest to server
    var msg = 'URI: ${err.requestOptions.uri}\n';
    msg += 'METHOD: ${err.requestOptions.method}\n';
    msg += 'REQUEST HEADER: ${err.requestOptions.headers}\n';
    if (err.response != null) {
      msg += 'STATUS CODE: ${err.response?.statusCode}\n';
      msg += 'BODY: ${err.response?.data.toString() ?? ''}\n';
    }
    msg += 'ERROR: ${err.toString()}';

    Log.console(msg, where: 'ERROR WHEN SEND REQUEST', level: LogLevel.error);

    return handler.next(err);
  }

  @override
  Future onResponse(response, ResponseInterceptorHandler handler) async {
    var msg = 'URI: ${response.requestOptions.uri}\n';
    msg += 'METHOD: ${response.requestOptions.method}\n';
    msg += 'REQUEST HEADER: ${response.requestOptions.headers}\n';
    msg += 'STATUS CODE: ${response.statusCode}\n';
    msg += 'BODY: ${response.data.toString()}';

    Log.console(msg, where: 'RESPONSE', level: LogLevel.info);

    return handler.next(response);
  }
}
