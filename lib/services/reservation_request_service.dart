import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weplan/models/schedule.dart';
import 'package:weplan/services/api_provider.dart';
import 'package:weplan/utils/navigator.dart';
import 'package:weplan/viewmodels/schedule.dart';

class ReservationRequestService extends ChangeNotifier {
  final ApiProvider _api = navigatorKey.currentContext!.read<ApiProvider>();

  ReservationRequestService() {
    this.update();
  }

  Map<int, ScheduleViewModel> _scheduleMap = {};
  Map<int, ScheduleViewModel> get map => this._scheduleMap;
  List<ScheduleViewModel> get list => this._scheduleMap.values.toList();

  Future<Map<int, ScheduleViewModel>> update() async {
    this._scheduleMap = {
      for (Schedule e in (await _api.admin.getScheduleRequests()).schedules)
        e.id: ScheduleViewModel(e),
    };
    notifyListeners();
    return this._scheduleMap;
  }
}
