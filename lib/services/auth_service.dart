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

  final AuthStorage _authStorage = AuthStorage();

  AuthService() {
    _dio.interceptors.addAll([
      ErrorInterceptor(),
      _accessTokenInterceptor,
      _refreshTokenInterceptor,
    ]);
    _api = SignRestClient(_dio);

    // Assign Token from storage
    _authStorage.accessToken
        .then((value) => _accessToken = value)
        .then((_) => notifyListeners());
    _authStorage.refreshToken
        .then((value) => _refreshToken = value)
        .then((_) => notifyListeners());
    _authStorage.isAdminUser
        .then((value) => _isAdmin = value!)
        .then((_) => notifyListeners());
  }

  InterceptorsWrapper get _accessTokenInterceptor {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        if (this._accessToken != null) {
          options.headers['AccessToken'] = this._accessToken;
          logger.i(
            '[AccessTokenInterceptor] AccessToken Injection: ${this._accessToken}',
          );
        }
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        if (response.headers['AccessToken'] != null) {
          String prevToken = this._accessToken.toString();
          setAccessToken(response.headers['AccessToken']![0]);
          if (this._accessToken == response.headers['AccessToken']![0])
            logger.i(
              '[AccessTokenInterceptor] AccessToken Update: $prevToken => ${this._accessToken}',
            );
        }
        return handler.next(response);
      },
    );
  }

  InterceptorsWrapper get _refreshTokenInterceptor {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        if (this._refreshToken != null) {
          options.headers['RefreshToken'] = this._refreshToken;
          logger.i(
            '[RefreshTokenInterceptor] RefreshToken Injection: ${this._refreshToken}',
          );
        }
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        if (response.headers['RefreshToken'] != null) {
          String prevToken = this._refreshToken.toString();
          setRefreshToken(response.headers['RefreshToken']![0]);
          if (this._refreshToken == response.headers['RefreshToken']![0])
            logger.i(
              '[RefreshTokenInterceptor] RefreshToken: $prevToken => ${this._refreshToken}',
            );
        }
        return handler.next(response);
      },
      onError: (e, handler) {
        if (e.response!.statusCode == 401) signOut();
        throw e;
      },
    );
  }

  void setAccessToken(String token) async {
    this._accessToken = token;
    await _authStorage.setAccessToken(token);
    notifyListeners();
  }

  void setRefreshToken(String token) async {
    this._refreshToken = token;
    await _authStorage.setRefreshToken(token);
    notifyListeners();
  }

  void setIsAdmin(bool value) async {
    this._isAdmin = value;
    await _authStorage.setIsAdminUser(value);
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

    setAccessToken(response.response.headers['AccessToken']![0]);
    setRefreshToken(response.response.headers['RefreshToken']![0]);
    setIsAdmin(response.data.isAdmin);

    return response;
  }

  Future<void> signOut() async {
    await Future.wait([
      _authStorage.deleteAccessToken(),
      _authStorage.deleteRefreshToken(),
      _authStorage.deleteIsAdminUser(),
    ]).then((_) {
      this._accessToken = null;
      this._refreshToken = null;
      this._isAdmin = false;
      notifyListeners();
    });
  }
}
