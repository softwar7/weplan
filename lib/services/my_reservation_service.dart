import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weplan/models/enum/approval.dart';
import 'package:weplan/models/schedule.dart';
import 'package:weplan/services/api_provider.dart';
import 'package:weplan/utils/navigator.dart';
import 'package:weplan/viewmodels/schedule.dart';

class MyReservationsService extends ChangeNotifier {
  final ApiProvider _api = navigatorKey.currentContext!.read<ApiProvider>();

  MyReservationsService();

  Map<int, ScheduleViewModel> _scheduleMap = {};
  Map<int, ScheduleViewModel> get map => this._scheduleMap;
  // List<ScheduleViewModel> get list => this._scheduleMap.values.toList();

  // Dummy Data
  List<ScheduleViewModel> get list => [
        ScheduleViewModel(
          Schedule(
            id: 3,
            name: '승인된 일정',
            start: DateTime.parse('2023-11-20 10:00:00'),
            end: DateTime.parse('2023-11-20 11:00:00'),
            approval: Approval.APPROVED,
            channelId: 1,
          ),
        ),
        ScheduleViewModel(
          Schedule(
            id: 1,
            name: '승인 대기중인 일정',
            start: DateTime.parse('2023-11-20 23:00:00'),
            end: DateTime.parse('2023-11-21 01:00:00'),
            approval: Approval.PENDING,
            channelId: 1,
          ),
        ),
        ScheduleViewModel(
          Schedule(
            id: 2,
            name: '거절된 일정',
            start: DateTime.parse('2023-12-31 23:00:00'),
            end: DateTime.parse('2024-01-01 01:00:00'),
            approval: Approval.REJECTED,
            channelId: 1,
          ),
        ),
        ScheduleViewModel(
          Schedule(
            id: 4,
            name: 'This is Dummy Data',
            start: DateTime.parse('2023-12-31 23:00:00'),
            end: DateTime.parse('2024-01-01 01:00:00'),
            approval: Approval.REJECTED,
            channelId: 1,
          ),
        ),
      ];

  Future<Map<int, ScheduleViewModel>> update() async {
    this._scheduleMap = {
      for (Schedule e in (await _api.guest.getScheduleRequests()).schedules)
        e.id: ScheduleViewModel(e),
    };
    notifyListeners();
    return this._scheduleMap;
  }
}
