import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weplan/components/snackbar.dart';
import 'package:weplan/models/enum/approval.dart';
import 'package:weplan/models/schedule.dart';
import 'package:weplan/services/api_provider.dart';
import 'package:weplan/utils/navigator.dart';
import 'package:weplan/viewmodels/schedule.dart';

class ReservationRequestService extends ChangeNotifier {
  final ApiProvider _api = navigatorKey.currentContext!.read<ApiProvider>();
  BuildContext context = navigatorKey.currentContext!;

  ReservationRequestService() {
    this.update(verbose: false);
  }

  Map<int, ScheduleViewModel> _scheduleMap = {};
  Map<int, ScheduleViewModel> get map => this._scheduleMap;
  List<ScheduleViewModel> get list => this._scheduleMap.values.toList();

  Future<Map<int, ScheduleViewModel>> update({
    bool verbose = true,
  }) async {
    List<Schedule> schedules =
        await _api.admin.getScheduleRequests().then((value) {
      if (verbose) showSnackBar(navigatorKey.currentContext!, '예약 동기화 완료');
      return value.schedules;
    }).catchError((e) {
      if (verbose) showErrorSnackBar(context, '예약을 불러오는 중 오류가 발생했습니다.');
      throw e;
    });

    this._scheduleMap = {
      for (Schedule e in schedules) e.id: ScheduleViewModel(e),
    };
    notifyListeners();
    return this._scheduleMap;
  }

  Future<void> approve(
    int id,
    Approval approval, {
    bool verbose = true,
  }) async {
    return await _api.admin
        // TODO: Is there any way to send approval instead of approval.name?
        .approveSchedule(id: id, approval: approval.name)
        .then((value) {
      if (verbose) showSnackBar(context, '예약 승인 완료');
    }).catchError((e) {
      if (verbose) showErrorSnackBar(context, '예약 승인 중 오류가 발생했습니다.');
      throw e;
    });
  }
}