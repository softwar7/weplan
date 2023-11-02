import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:weplan/utils/logger.dart';

part 'error.g.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      err.response!.statusMessage =
          ErrorResponse.fromJson(err.response!.data).message;
      logger.e('status: ${err.response?.statusCode}');
      logger.e('message: ${err.response?.statusMessage}');
    }

    return handler.next(err);
  }
}

@JsonSerializable()
class ErrorResponse {
  final String statusCode;
  final String message;

  ErrorResponse({
    required this.statusCode,
    required this.message,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}
