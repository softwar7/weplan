import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weplan/components/snackbar.dart';
import 'package:weplan/models/channel.dart';
import 'package:weplan/models/schedule.dart';
import 'package:weplan/services/api/guest.dart';
import 'package:weplan/services/api_provider.dart';
import 'package:weplan/utils/navigator.dart';
import 'package:weplan/viewmodels/schedule.dart';

class ChannelViewModel extends ChangeNotifier {
  final ApiProvider _api = navigatorKey.currentContext!.read<ApiProvider>();
  BuildContext context = navigatorKey.currentContext!;

  Channel _channel;
  ChannelViewModel(this._channel);

  Channel get model => _channel;
  int get id => _channel.id;
  String get name => _channel.name;
  String get place => _channel.place;
  String get createdBy => _channel.createdBy;

  Map<int, ScheduleViewModel> _schedules = {};
  Map<int, ScheduleViewModel> get schedules => _schedules;

  Future<Channel> updateChannel({
    bool verbose = true,
  }) async {
    this._channel =
        await _api.guest.getChannel(channelId: this._channel.id).then((value) {
      if (verbose) showSnackBar(context, '${_channel.name} 채널 동기화 완료');
      return value;
    }).catchError((e) {
      if (verbose)
        showErrorSnackBar(context, '${_channel.name} 채널을 불러오는 중 오류가 발생했습니다.');
      throw e;
    });
    notifyListeners();
    return this._channel;
  }

  Future<Map<int, ScheduleViewModel>> updateSchedules({
    DateTime? start,
    DateTime? end,
    bool verbose = true,
  }) async {
    List<Schedule> schedules =
        await _api.guest.getSchedules(channelId: id).then((value) {
      if (verbose) showSnackBar(context, '채널 스케쥴 동기화 완료');
      return value.schedules;
    }).catchError((e) {
      if (verbose) showErrorSnackBar(context, '채널 스케쥴을 불러오는 중 오류가 발생했습니다.');
      throw e;
    });

    this._schedules = {
      for (Schedule e in schedules) e.id: ScheduleViewModel(e),
    };
    notifyListeners();

    return this._schedules;
  }

  Future<void> createSchedule({
    int? channelId,
    required String name,
    required DateTime start,
    required DateTime end,
    String? content,
    bool verbose = true,
  }) async {
    return await _api.guest
        .createSchedule(
      CreateScheduleRequest(
        channelId: channelId ?? _channel.id,
        name: name,
        start: start,
        end: end,
        content: content,
      ),
    )
        .then((value) {
      if (verbose) showSnackBar(context, '스케쥴 생성 완료');
    }).catchError((e) {
      if (verbose) showErrorSnackBar(context, '스케쥴 생성 중 오류가 발생했습니다.');
      throw e;
    });
  }
}
