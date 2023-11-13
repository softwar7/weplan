import 'package:dio/dio.dart';

import 'package:weplan/services/api/admin.dart';
import 'package:weplan/services/api/guest.dart';
import 'package:weplan/services/auth_service.dart';

class ApiProvider {
  AdminRestClient? _adminApi;
  late RestClient _guestApi;

  ApiProvider(AuthService authService) {
    Dio dio = authService.dio;
    if (authService.isAdmin) this._adminApi = AdminRestClient(dio);
    this._guestApi = RestClient(dio);
  }

  AdminRestClient get admin {
    if (_adminApi == null) throw Exception('관리자가 아닙니다.');
    return _adminApi!;
  }

  RestClient get guest => _guestApi;
}
