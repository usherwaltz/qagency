import 'package:dio/dio.dart';

import '../../business_logic/models/models.dart';
import '../../utils/utils.dart';
import '../flavor_config.dart';
import 'interceptors/interceptors.dart';

/// All RESTful methods
enum RequestMethod { get, post, put, patch, delete, head, options, trace }

class DioClient {
  DioClient._internal();
  static final DioClient instance = DioClient._internal();

  late final Dio _dio;

  Future<void> initialize() async {
    _dio = Dio(_options);
    _dio.interceptors.addAll([
      AuthInterceptor(),
      ResponseTypeInterceptor(),
    ]);
  }

  static final _options = BaseOptions(
    baseUrl: FlavorConfig.instance.values.apiUrl,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
  );

  /// Only defining "get" method since we won't be using any other REST type
  Future<APIResponseModel> get(
    String url, {
    Map<String, dynamic>? queryParams,
    Options? options,
  }) async {
    return await _request(
      method: RequestMethod.get,
      url: url,
      queryParams: queryParams,
      options: options,
    );
  }

  Future<APIResponseModel> _request({
    required RequestMethod method,
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParams,
    Options? options,
  }) async {
    try {
      logger.i('${method.name.toUpperCase()} :: $url');

      Response response;

      /// Setting only default because we only send GET requests
      /// We could use _dio.request(), but it doesn't prepend baseUrl from [BaseOptions]
      switch (method) {
        /// example of a POST method
        case RequestMethod.post:
          response = await _dio.post(
            url,
            queryParameters: queryParams,
            data: data,
            options: options,
          );

        default:
          response = await _dio.get(
            url,
            queryParameters: queryParams,
            data: data,
            options: options,
          );
          break;
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
    final statusCode = response?.statusCode;
    final data = response?.data;
    final statusMessage = response?.statusMessage;
    logger.i("Response :: $statusCode :: $statusMessage \nDATA :: => $data");

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
