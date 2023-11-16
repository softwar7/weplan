import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:weplan/models/enum/approval.dart';
import 'package:weplan/models/schedule.dart';
import 'package:weplan/services/api_provider.dart';
import 'package:weplan/utils/navigator.dart';
import 'package:weplan/utils/relative_date.dart';

class ScheduleViewModel {
  ApiProvider api = navigatorKey.currentContext!.read<ApiProvider>();

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
    this._schedule = await api.guest.getSchedule(scheduleId: _schedule.id);
    return this._schedule;
  }
}
