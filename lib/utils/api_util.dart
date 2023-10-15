import 'package:dio/dio.dart';
import 'package:weatherapp/utils/app_config.dart';
import './api_logs_interceptor.dart';

class ApiUtil {
  late Dio dio;
  ApiUtil() {
    init();
  }

  init() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.base_url,
        queryParameters: {
          "key": AppConfig.key,
        },
        connectTimeout: const Duration(seconds: 10),
      ),
    );
    dio.interceptors.add(ApiLogsInterceptor());
  }

  Future<dynamic> get(
    String subPath, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParam,
    Map<String, dynamic>? headers,
  }) async {
    try {
      Response response = await dio.get(
        subPath,
        queryParameters: queryParam,
        data: data,
        options: Options(headers: headers),
      );
      return response.data;
    } catch (err) {
      print(err);

      ///
    }
  }
}

// https://openweathermap.org/img/wn/10d@2x.png

// class RepoException {
//   RepoException onError(DioException err) {
//     return RepoException(
//       err.requestOptions.cancelToken.
//     );
//   }
// }
