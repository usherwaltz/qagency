import 'package:dio/dio.dart';

class ResponseTypeInterceptor extends Interceptor {
  static final _headers = {
    'Content-Type': 'application/json',
    'accept': 'application/json',
  };

  static final _byteDataHeaders = {
    'Content-Type': 'application/octet-stream',
    'accept': 'application/octet-stream',
  };

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    switch (options.responseType) {
      case ResponseType.bytes:
        options.headers.addAll(_byteDataHeaders);
        break;

      default:
        options.headers.addAll(_headers);
        break;
    }
    return super.onRequest(options, handler);
  }
}
