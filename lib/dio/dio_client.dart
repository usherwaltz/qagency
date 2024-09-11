import 'package:dio/dio.dart';

import '../flavor_config.dart';
import '../models/models.dart';
import '../utils/utils.dart';
import 'interceptors/interceptors.dart';

/// All RESTful methods
enum RequestMethod { get, post, put, patch, delete, head, options, trace }

class DioClient {
  DioClient._internal() {
    _init();
  }

  factory DioClient() {
    _instance ??= DioClient._internal();
    return _instance!;
  }

  static DioClient? _instance;
  DioClient? get instance => _instance;

  late final Dio _dio;

  void _init() {
    _dio = Dio(_options);
    _dio.interceptors.add(AuthInterceptor());
  }

  static final headers = {
    'Content-Type': 'application/json',
    'accept': 'application/json',
  };

  static final _options = BaseOptions(
    baseUrl: FlavorConfig.instance.values.apiUrl,
    headers: headers,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
  );

  /// Only defining "get" method since we won't be using any other REST type
  Future<APIResponseModel> get(
    String url, {
    Map<String, dynamic>? queryParams,
  }) async {
    return await _request(
      method: RequestMethod.get,
      url: url,
      queryParams: queryParams,
    );
  }

  Future<APIResponseModel> _request({
    required RequestMethod method,
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      logger.i('${method.name.toUpperCase()} :: $url');

      Response response;

      /// Setting only default because we only send GET requests
      /// We could use _dio.request(), but it doesn't prepend baseUrl from [BaseOptions]
      switch (method) {
        /// example of a POST method
        case RequestMethod.post:
          response = await _dio.get(
            url,
            queryParameters: queryParams,
            data: data,
          );

        default:
          response = await _dio.get(
            url,
            queryParameters: queryParams,
          );
      }

      return _parseResponse(response);
    } on DioException catch (e) {
      logger.e("DioException :: ${e.type.name}");
      return _parseError(e);
    } catch (e) {
      logger.e("Unknown Exception :: ${e.toString()}");
      return APIResponseModel(
        responseType: ResponseTypes.unexpected,
        data: e.toString(),
      );
    }
  }

  Future<APIResponseModel> _parseResponse(Response? response) async {
    var statusCode = response?.statusCode;
    var data = response?.data;
    var statusMessage = response?.statusMessage;
    logger.i("Response: $statusCode => $data => $statusMessage");

    if (response != null) {
      return APIResponseModel(
        responseType: ResponseTypes.ok,
        data: response.data,
      );
    }
    return APIResponseModel(
      responseType: ResponseTypes.unexpected,
      data: response?.data,
    );
  }

  Future<APIResponseModel> _parseError(DioException exception) async {
    final type = exception.type;
    final statusCode = exception.response?.statusCode;

    logger.e("Error :: $statusCode => $type => ${exception.response}");

    switch (exception.response?.statusCode) {
      case 400:
        return APIResponseModel(
          responseType: ResponseTypes.badRequest,
          data: exception.response?.data,
        );

      case 401:
        return APIResponseModel(
          responseType: ResponseTypes.unauthorised,
          data: exception.response?.data,
        );

      case 403:
        return APIResponseModel(
          responseType: ResponseTypes.unauthorised,
          data: exception.response?.data,
        );

      case 404:
        return APIResponseModel(
          responseType: ResponseTypes.notFound,
          data: exception.response?.data,
        );

      case 422:
        return APIResponseModel(
          responseType: ResponseTypes.unProcessableEntity,
          data: exception.response?.data,
        );

      case 503:
        return APIResponseModel(
          responseType: ResponseTypes.serviceUnavailable,
          data: exception.response?.data,
        );

      default:
        return APIResponseModel(
          responseType: ResponseTypes.unexpected,
          data: exception.response?.data,
        );
    }
  }
}
