import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weplan/models/schedule.dart';
import 'package:weplan/services/api_provider.dart';
import 'package:weplan/utils/navigator.dart';

class SchedulesService extends ChangeNotifier {
  ApiProvider api = navigatorKey.currentContext!.read<ApiProvider>();

  Future<List<Schedule>> getSchedules() async {
    return (await api.guest.getSchedules()).schedules;
  }

  Future<void> createSchedule({
    required int channelId,
    required String name,
    required DateTime start,
    required DateTime end,
    String? content,
  }) async {
    return await api.guest.createSchedule(
      channelId: channelId,
      name: name,
      start: start.toIso8601String(),
      end: end.toIso8601String(),
      content: content,
    );
  }

  Future<List<Schedule>> getRequests() async {
    return (await api.admin.getScheduleRequests()).schedules;
  }
}

class ScheduleService {
  ApiProvider api = navigatorKey.currentContext!.read<ApiProvider>();
  final Schedule _schedule;

  ScheduleService(this._schedule);

  Future<Schedule> getSchedule() async {
    return await api.guest.getSchedule(scheduleId: _schedule.id);
  }
}
