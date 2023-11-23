import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weplan/components/menus.dart';
import 'package:weplan/components/snackbar.dart';
import 'package:weplan/models/channel.dart';
import 'package:weplan/screens/forms/schedule_form.dart';
import 'package:weplan/screens/timetable_page.dart';
import 'package:weplan/services/api_provider.dart';
import 'package:weplan/utils/navigator.dart';
import 'package:weplan/viewmodels/channel.dart';

class ChannelService extends ChangeNotifier {
  final ApiProvider _api = navigatorKey.currentContext!.read<ApiProvider>();
  BuildContext context = navigatorKey.currentContext!;

  Map<int, ChannelViewModel> _channels = {};
  Map<int, ChannelViewModel> get map => this._channels;
  List<ChannelViewModel> get list => this._channels.values.toList();
  Map<int, Channel> get models => this._channels.map(
        (key, value) => MapEntry(key, value.model),
      );

  List<Menu> get menus {
    return _channels.values
        .map(
          (e) => Menu(
            title: e.name,
            icon: const Icon(Icons.calendar_today_outlined),
            body: TimeTable(channel: e),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScheduleForm(channel: e),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: e.updateSchedules,
              ),
            ],
          ),
        )
        .toList();
  }

  Future<Map<int, ChannelViewModel>> updateChannels({
    bool verbose = true,
  }) async {
    List<Channel> channels = await _api.guest.getChannels().then((value) {
      if (verbose) showSnackBar(context, '채널 동기화 완료');
      return value.channels;
    }).catchError((e) {
      if (verbose) showErrorSnackBar(context, '채널을 불러오는 중 오류가 발생했습니다.');
      throw e;
    });

    this._channels = {for (Channel e in channels) e.id: ChannelViewModel(e)};
    notifyListeners();
    return this._channels;
  }

  Future<void> createSchedule({
    required int channelId,
    required String name,
    required DateTime start,
    required DateTime end,
    String? content,
    bool verbose = true,
  }) {
    return _api.guest
        .createSchedule(
      channelId: channelId,
      name: name,
      start: start.toIso8601String(),
      end: end.toIso8601String(),
    )
        .then((value) {
      if (verbose) showSnackBar(context, '스케쥴 생성 완료');
    }).catchError((e) {
      if (verbose) showErrorSnackBar(context, '스케쥴 생성 중 오류가 발생했습니다.');
      throw e;
    });
  }

  // Admin Only
  Future<void> createChannel(
    String name,
    String place, {
    bool verbose = true,
  }) async {
    await _api.admin
        .createChannel(
      name: name,
      place: place,
    )
        .then((value) {
      if (verbose) showSnackBar(context, '채널 생성 완료');
    }).catchError((e) {
      if (verbose) showErrorSnackBar(context, '채널 생성 중 오류가 발생했습니다.');
      throw e;
    });

    await updateChannels(verbose: false);
  }
}
