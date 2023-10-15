// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';

const _LOG = 'API_LOG';

class ApiLogsInterceptor extends Interceptor {
  ApiLogsInterceptor();

  // @override
  // void onRequest(
  //     RequestOptions options, RequestInterceptorHandler handler) async {
  //   String log = '${options.method}: ${options.uri.path}';
  //   if (options.uri.hasQuery) {
  //     log += '\nquery_params: ${options.uri.queryParameters}';
  //   }
  //   // if (options.data != null)
  //   log += '\nbody: ${options.data}';
  //   if (options.extra.isNotEmpty) log += '\nextra ${options.extra}';
  //   if (options.headers.isNotEmpty) log += '\nheaders ${options.headers}';
  //   print("_LOG $log");
  //   handler.next(options);
  // }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    final reqOptions = response.requestOptions;
    String log = '${reqOptions.method}: ${reqOptions.uri.path}';
    if (reqOptions.uri.hasQuery) {
      log += '\nquery_params: ${reqOptions.uri.queryParameters}';
    }

    if (reqOptions.data != null) log += '\nbody: ${reqOptions.data}';

    if (response.data != null) log += '\nresponse data: ${response.data}';

    // if (response.headers.map.isNotEmpty) {
    //   log += '\nextra ${response.headers.map}';
    // }
    // if (reqOptions.extra.isNotEmpty) log += '\nextra ${reqOptions.extra}';

    log += '\n';
    print("_LOG $log \n ${response.statusMessage}");
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final reqOptions = err.requestOptions;
    String log =
        '${reqOptions.method}:${reqOptions.baseUrl}${reqOptions.uri.path}';
    if (reqOptions.uri.hasQuery) {
      log += '\nquery_params: ${reqOptions.uri.queryParameters}';
    }
    if (reqOptions.data != null) log += '\nbody: ${reqOptions.data}';
    // if (reqOptions.extra.isNotEmpty) log += '\nextra ${reqOptions.extra}';
    if (reqOptions.headers.isNotEmpty) {
      log += '\nheaders ${reqOptions.headers}';
    }
    log += '\n';
    print("_LOG $log \n ${err.response}");
    handler.next(err);
  }
}

class ApiErrorNotiInterceptor extends Interceptor {
  ApiErrorNotiInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // final reqOptions = err.requestOptions;

    // LeherPushNotification.instance.showApiFailure(
    //   title: reqOptions.uri.toString(),
    //   body: err.response?.data,
    //   response: {
    //     'request_uri': reqOptions.uri.toString(),
    //     'request_query_params': reqOptions.queryParameters,
    //     'request_body': reqOptions.data,
    //     'response_status_code': err.response?.statusCode,
    //     'response_data': err.response?.data,
    //   },
    // );
    // handler.next(err);
  }
}
