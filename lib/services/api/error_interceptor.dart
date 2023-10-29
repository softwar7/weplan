import 'package:dio/dio.dart';

import 'package:weplan/services/api/error.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final error = ErrorResponse.fromJson(err.response?.data);
    // somehow alert

    super.onError(err, handler);
  }
}
