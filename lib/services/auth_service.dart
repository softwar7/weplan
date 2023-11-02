import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';

import 'package:weplan/services/api/sign.dart';
import 'package:weplan/utils/logger.dart';

class AuthService extends ChangeNotifier {
  final Dio _dio = Dio();
  late SignRestClient _api;
  String? _accessToken;
  String? _refreshToken;
  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;

  AuthService() {
    _dio.interceptors.addAll(
      [
        InterceptorsWrapper(
          onError: (e, handler) {
            if (e.response != null) logger.e(e.response!.data);
            return handler.next(e);
          },
        ),
      ],
    );
    _api = SignRestClient(_dio);
  }

  InterceptorsWrapper get accessTokenInterceptor {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['AccessToken'] = _accessToken;
        return handler.next(options);
      },
    );
  }

  InterceptorsWrapper get refreshTokenInterceptor {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['RefreshToken'] = _refreshToken;
        return handler.next(options);
      },
    );
  }

  Future<HttpResponse<SignInPostResponse>> signIn({
    required String loginId,
    required String password,
  }) async {
    final response = await _api.signIn(
      loginId: loginId,
      password: password,
    );
    _accessToken = response.response.headers['AccessToken'].toString();
    _refreshToken = response.response.headers['RefreshToken'].toString();

    return response;
  }
}
