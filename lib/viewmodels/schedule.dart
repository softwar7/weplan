import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:weplan/components/snackbar.dart';
import 'package:weplan/models/enum/approval.dart';
import 'package:weplan/models/schedule.dart';
import 'package:weplan/services/api_provider.dart';
import 'package:weplan/utils/navigator.dart';
import 'package:weplan/utils/relative_date.dart';

class ScheduleViewModel extends ChangeNotifier {
  ApiProvider api = navigatorKey.currentContext!.read<ApiProvider>();
  BuildContext context = navigatorKey.currentContext!;

  Schedule _schedule;

  Schedule get model => _schedule;
  int get id => _schedule.id;
  String get name => _schedule.name;
  String? get content => _schedule.content;
  DateTime get start => _schedule.start;
  DateTime get end => _schedule.end;
  int get channelId => _schedule.channelId;
  Approval get approval => _schedule.approval;

  ScheduleViewModel(this._schedule);

  String get startToEnd {
    String relativeStart = relativeDate(start);
    String relativeEnd = relativeDate(end);

    if (DateUtils.isSameDay(start, end))
      return "$relativeStart ${DateFormat("HH:mm").format(start)} - ${DateFormat("HH:mm").format(end)}";
    else
      return "$relativeStart ${DateFormat("HH:mm").format(start)} - $relativeEnd ${DateFormat("HH:mm").format(end)}";
  }

  Future<Schedule> updateSchedule() async {
    Schedule schedule =
        await api.guest.getSchedule(scheduleId: _schedule.id).then((value) {
      showSnackBar(context, '스케쥴 동기화 완료');
      return value;
    }).catchError((e) {
      showErrorSnackBar(context, '스케쥴을 불러오는 중 오류가 발생했습니다.');
      throw e;
    });
    this._schedule = schedule;

    notifyListeners();
    return this._schedule;
  }

  Future<void> approve(Approval approval) async {
    // TODO: Is there any way to send approval instead of approval.name?
    return await api.admin
        .approveSchedule(id: this._schedule.id, approval: approval.name);
  }
}
