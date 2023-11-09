import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';

import 'package:weplan/services/api/error.dart';
import 'package:weplan/services/api/sign.dart';
import 'package:weplan/services/storage/auth.dart';
import 'package:weplan/utils/logger.dart';

class AuthService extends ChangeNotifier {
  final Dio _dio = Dio();
  Dio get dio => _dio;

  late SignRestClient _api;
  String? _accessToken;
  String? _refreshToken;

  bool _isAdmin = false;
  bool get isAdmin => _isAdmin;

  bool get isAuthenticated => _accessToken != null;

  AuthStorage authStorage = AuthStorage();

  AuthService() {
    _dio.interceptors.addAll([
      ErrorInterceptor(),
      accessTokenInterceptor,
      refreshTokenInterceptor,
      updateAccessTokenInterceptor,
      updateRefreshTokenInterceptor,
    ]);
    _api = SignRestClient(_dio);

    // Assign Token from storage
    authStorage.accessToken
        .then((value) => _accessToken = value)
        .then((_) => notifyListeners());
    authStorage.refreshToken
        .then((value) => _refreshToken = value)
        .then((_) => notifyListeners());
    authStorage.isAdminUser
        .then((value) => _isAdmin = value!)
        .then((_) => notifyListeners());
  }

  InterceptorsWrapper get accessTokenInterceptor {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        if (this._accessToken != null) {
          options.headers['AccessToken'] = this._accessToken;
          logger.i(
            'accessTokenInterceptor injects "AccessToken" header: ${this._accessToken}',
          );
        }
        return handler.next(options);
      },
    );
  }

  InterceptorsWrapper get refreshTokenInterceptor {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        if (this._refreshToken != null) {
          options.headers['RefreshToken'] = this._refreshToken;
          logger.i(
            'refreshTokenInterceptor injects "RefreshToken" header: ${this._refreshToken}',
          );
        }
        return handler.next(options);
      },
    );
  }

  InterceptorsWrapper get updateAccessTokenInterceptor {
    return InterceptorsWrapper(
      onResponse: (response, handler) async {
        if (response.headers['AccessToken'] != null) {
          String prevToken = this._accessToken.toString();
          setAccessToken(response.headers['AccessToken'].toString());
          if (this._accessToken == response.headers['AccessToken'].toString())
            logger.i(
              'updateAccessTokenInterceptor successfully updated "AccessToken" from $prevToken to ${this._accessToken}',
            );
        }

        return handler.next(response);
      },
    );
  }

  InterceptorsWrapper get updateRefreshTokenInterceptor {
    return InterceptorsWrapper(
      onResponse: (response, handler) async {
        if (response.headers['RefreshToken'] != null) {
          String prevToken = this._refreshToken.toString();
          setRefreshToken(response.headers['RefreshToken'].toString());
          if (this._refreshToken == response.headers['RefreshToken'].toString())
            logger.i(
              'updateRefreshTokenInterceptor successfully updated "RefreshToken" from $prevToken to ${this._refreshToken}',
            );
        }

        return handler.next(response);
      },
    );
  }

  void setAccessToken(String token) async {
    this._accessToken = token;
    await authStorage.setAccessToken(token);
    notifyListeners();
  }

  void setRefreshToken(String token) async {
    this._refreshToken = token;
    await authStorage.setRefreshToken(token);
    notifyListeners();
  }

  void setIsAdmin(bool value) async {
    this._isAdmin = value;
    await authStorage.setIsAdminUser(value);
    notifyListeners();
  }

  Future<HttpResponse<SignInPostResponse>> signIn({
    required String loginId,
    required String password,
  }) async {
    final response = await _api.signIn(
      loginId: loginId,
      password: password,
    );

    setAccessToken(response.response.headers['AccessToken'].toString());
    setRefreshToken(response.response.headers['RefreshToken'].toString());
    setIsAdmin(response.data.isAdmin);

    return response;
  }

  Future<void> signOut() async {
    await Future.wait([
      authStorage.deleteAccessToken(),
      authStorage.deleteRefreshToken(),
      authStorage.deleteIsAdminUser(),
    ]).then((_) {
      this._accessToken = null;
      this._refreshToken = null;
      this._isAdmin = false;
      notifyListeners();
    });
  }
}
