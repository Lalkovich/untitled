import 'package:dio/dio.dart';
import 'package:untitled/data/api/service/app_interceptors.dart';

import '../model/api_day.dart';
import '../request/get_day_body.dart';

class SunriseService {
  static const _BASE_URL = 'https://api.sunrise-sunset.org';
  final dio = createDio();
  static final Duration _constReceiveTimeout = Duration(seconds: 15);
  static final Duration _connectTimeout = Duration(seconds: 15);
  static final Duration _sendTimeout = Duration(seconds: 15);

  final Dio _dio = Dio(
    BaseOptions(baseUrl: _BASE_URL),
  );

  static Dio createDio(){
    var dio = Dio(BaseOptions(
      baseUrl: _BASE_URL,
      receiveTimeout: _constReceiveTimeout,
      connectTimeout: _connectTimeout,
      sendTimeout: _sendTimeout,
    ));
    dio.interceptors.add(AppInterceptors(dio));
    return dio;
  }

  Future<ApiDay> getDay(GetDayBody body) async {
    try {
      final response = await dio.get(
        '/json',
        queryParameters: body.toApi(),
      );
      return ApiDay.fromApi(response.data);
    } on DioException catch (error) {
      throw error;
    }
  }
}
