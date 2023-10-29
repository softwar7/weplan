import 'package:dio/dio.dart';

import 'package:weplan/services/api/sign.dart';

class AuthService {
  final Dio _dio = Dio();
  late SignRestClient _api;
  String? _accessToken;
  String? _refreshToken;
  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;

  AuthService() {
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
}
