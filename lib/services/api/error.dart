import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'error.g.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final error = ErrorResponse.fromJson(err.response?.data);
    // somehow alert

    super.onError(err, handler);
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
