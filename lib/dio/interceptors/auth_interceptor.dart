import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor._internal() {
    _fetchBearerToken();
  }

  static AuthInterceptor? _instance;

  factory AuthInterceptor() {
    _instance ??= AuthInterceptor._internal();
    return _instance!;
  }

  Future<void> _fetchBearerToken() async {
    await dotenv.load();
    _bearerToken = dotenv.maybeGet('API_KEY');
  }

  AuthInterceptor? get instance => _instance;

  static late String? _bearerToken;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({"Authorization": "Bearer $_bearerToken"});
    return super.onRequest(options, handler);
  }
}
