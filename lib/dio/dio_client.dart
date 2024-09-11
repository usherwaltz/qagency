import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum RequestMethod { get, post, put, patch, delete, head, options }

class DioClient {
  DioClient._internal() {
    _init();
  }

  static DioClient? _instance;

  DioClient? get instance => _instance;

  factory DioClient() {
    _instance ??= DioClient._internal();
    return _instance!;
  }

  late final Dio _dio;

  Dio get dio => _dio;

  void _init() {
    _dio = Dio();
    _dio.options = _options;
    _dio.interceptors.add(_AuthInterceptor());
  }

  static final headers = {
    'Content-Type': 'application/json',
    'accept': 'application/json',
  };

  static final _options = BaseOptions(
    headers: headers,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
  );

  void request() {}
}

class _AuthInterceptor extends Interceptor {
  _AuthInterceptor._internal() {
    _fetchBearerToken();
  }

  static _AuthInterceptor? _instance;

  factory _AuthInterceptor() {
    _instance ??= _AuthInterceptor._internal();
    return _instance!;
  }

  Future<void> _fetchBearerToken() async {
    await dotenv.load();
    _bearerToken = dotenv.maybeGet('API_KEY');
  }

  _AuthInterceptor? get instance => _instance;

  static late String? _bearerToken;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({"Authorization": "Bearer $_bearerToken"});
    return super.onRequest(options, handler);
  }
}
