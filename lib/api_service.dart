import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class APIService {
  static const String following = 'following';
  static const String forYou = 'for_you';
  static const String revealAnswer = 'reveal';

  final Dio _dio = Dio(
      BaseOptions(baseUrl: 'https://cross-platform.rp.devfactory.com/', connectTimeout: const Duration(seconds: 60)))
    ..interceptors.add(RequestInterceptor());
  final http.Client httpClient = http.Client();

  Future<T?> get<T>({required String path, Map<String, dynamic>? queryParams}) async {
    final response = await _dio.get<T>(path, queryParameters: queryParams);
    return response.data;
  }
}

class RequestInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      print("Logic to intercept the request");
    }
    super.onRequest(options, handler);
  }
}
