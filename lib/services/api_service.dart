import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import 'package:weplan/services/api/admin.dart';
import 'package:weplan/services/api/guest.dart';
import 'package:weplan/services/auth_service.dart';

class ApiService extends ChangeNotifier {
  AdminRestClient? _adminApi;
  late RestClient _guestApi;

  ApiService(
    AuthService authService,
  ) {
    Dio dio = authService.dio;
    if (authService.isAdmin) this._adminApi = AdminRestClient(dio);
    this._guestApi = RestClient(dio);
  }
}
