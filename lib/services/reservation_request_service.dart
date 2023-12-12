import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import 'package:weplan/components/snackbar.dart';
import 'package:weplan/models/schedule.dart';
import 'package:weplan/services/api_provider.dart';
import 'package:weplan/utils/navigator.dart';
import 'package:weplan/viewmodels/schedule.dart';

class ReservationRequestService extends ChangeNotifier {
  final ApiProvider _api;

  ReservationRequestService(BuildContext context)
      : this._api = context.read<ApiProvider>();

  Map<int, ScheduleViewModel> _scheduleMap = {};
  Map<int, ScheduleViewModel> get map => this._scheduleMap;
  List<ScheduleViewModel> get list => this._scheduleMap.values.toList();

  Future<Map<int, ScheduleViewModel>> update({
    bool verbose = false,
  }) async {
    BuildContext context = navigatorKey.currentContext!;
    try {
      List<Schedule> schedules = await _api.admin
          .getScheduleRequests()
          .then((value) => value.schedules);

      this._scheduleMap = {
        for (Schedule e in schedules) e.id: ScheduleViewModel(e),
      };

      if (verbose && context.mounted) showSnackBar(context, '예약요청 목록 동기화 완료');
      notifyListeners();
      return this._scheduleMap;
    } catch (e) {
      if (context.mounted) if (e is DioException &&
          e.response?.statusMessage != null)
        showErrorSnackBar(context, e.response!.statusMessage!);
      else
        showErrorSnackBar(context, '예약요청 목록을 불러오는 중 오류가 발생했습니다.');
      rethrow;
    }
  }

  // Future<void> approve(int id, Approval approval, {bool verbose = false}) async {
  //   return await _api.admin
  //       .approveSchedule(id: id, approval: approval)
  //       .then((value) {
  //     if (verbose) showSnackBar(context, '예약 승인 완료');
  //   }).catchError((e) {
  //     if (verbose) showErrorSnackBar(context, '예약 승인 중 오류가 발생했습니다.');
  //     throw e;
  //   });
  // }
}
