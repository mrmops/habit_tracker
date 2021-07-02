import 'package:dio/dio.dart';
import 'package:habit_tracker/data/network/Retrofit/retrofit_client.dart';

import 'api_config.dart';

class RetrofitConfigurationHelper {
  static RetrofitClient? _retrofitClient;

  static RetrofitClient get retrofitInstance {
    if (_retrofitClient == null) {
      var dio = Dio();
      dio.options.headers['Authorization'] = ApiConfig.API_KEY;
      dio.options.contentType = 'application/json';
      _retrofitClient = RetrofitClient(
          dio, baseUrl: ApiConfig.HOST_DOMAIN
      );
    }

    return _retrofitClient!;
  }
}
