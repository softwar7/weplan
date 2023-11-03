
import 'package:dio/dio.dart';

import 'package:weplan/models/channel.dart';
import 'package:weplan/models/schedule.dart';
import 'package:weplan/services/api/admin.dart';
import 'package:weplan/services/api/guest.dart';
import 'package:weplan/services/auth_service.dart';

class ApiService {
  AdminRestClient? _adminApi;
  late RestClient _guestApi;

  ApiService(
    AuthService authService,
  ) {
    Dio dio = authService.dio;
    if (authService.isAdmin) this._adminApi = AdminRestClient(dio);
    this._guestApi = RestClient(dio);
  }

  Future<List<Channel>> getChannels() async {
    return (await _guestApi.getChannels()).channels;
  }

  Future<List<Schedule>> getSchedules(Channel channel) async {
    return (await _guestApi.getSchedules(channelId: channel.id)).schedules;
  }
}
