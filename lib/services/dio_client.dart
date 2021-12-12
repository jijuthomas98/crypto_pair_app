import 'package:crypto_pair_app/utils/enviroment_config.dart';
import 'package:dio/dio.dart';

class Client {
  Dio getDio() {
    final Dio _dio = Dio();
    _dio.options.baseUrl = EnvironmentConfig.apiBaseUrl;
    // we can add Interceptor here to inject API key, but this crypto API doest have any.
    return _dio;
  }
}
