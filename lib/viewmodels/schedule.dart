import 'package:provider/provider.dart';

import 'package:weplan/models/enum/approval.dart';
import 'package:weplan/models/schedule.dart';
import 'package:weplan/services/api_provider.dart';
import 'package:weplan/utils/navigator.dart';

class ScheduleViewModel {
  ApiProvider api = navigatorKey.currentContext!.read<ApiProvider>();

  final Schedule _schedule;

  int get id => _schedule.id;
  String get name => _schedule.name;
  String? get content => _schedule.content;
  DateTime get start => _schedule.start;
  DateTime get end => _schedule.end;
  int get channelId => _schedule.channelId;
  Approval get approval => _schedule.approval;

  ScheduleViewModel(this._schedule);

  Future<Schedule> getSchedule() async {
    return await api.guest.getSchedule(scheduleId: _schedule.id);
  }
}
