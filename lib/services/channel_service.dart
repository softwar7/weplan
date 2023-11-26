import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import 'package:weplan/components/menus.dart';
import 'package:weplan/components/snackbar.dart';
import 'package:weplan/models/channel.dart';
import 'package:weplan/screens/forms/schedule_form.dart';
import 'package:weplan/screens/timetable_page.dart';
import 'package:weplan/services/api/guest.dart';
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
                onPressed: () => e.updateSchedules(verbose: true),
              ),
            ],
          ),
        )
        .toList();
  }

  Future<Map<int, ChannelViewModel>> updateChannels({
    bool verbose = false,
  }) async {
    try {
      List<Channel> channels = await _api.guest.getChannels().then((value) {
        return value.channels;
      });

      this._channels = {for (Channel e in channels) e.id: ChannelViewModel(e)};
      if (verbose && context.mounted) showSnackBar(context, '채널 동기화 완료');
      notifyListeners();
      return this._channels;
    } catch (e) {
      if (context.mounted) if (e is DioException &&
          e.response?.statusMessage != null)
        showErrorSnackBar(context, e.response!.statusMessage!);
      else
        showErrorSnackBar(context, '채널을 불러오는 중 오류가 발생했습니다.');

      rethrow;
    }
  }

  Future<void> createSchedule({
    required int channelId,
    required String name,
    required DateTime start,
    required DateTime end,
    String? content,
    bool verbose = false,
  }) async {
    try {
      await _api.guest.createSchedule(
        CreateScheduleRequest(
          channelId: channelId,
          name: name,
          start: start,
          end: end,
          content: content,
        ),
      );

      if (verbose && context.mounted) showSnackBar(context, '스케쥴 생성 완료');
    } catch (e) {
      if (context.mounted) if (e is DioException &&
          e.response?.statusMessage != null)
        showErrorSnackBar(context, e.response!.statusMessage!);
      else
        showErrorSnackBar(context, '스케쥴 생성 중 오류가 발생했습니다.');
      rethrow;
    }
  }

  // Admin Only
  Future<void> createChannel(
    String name,
    String place, {
    bool verbose = false,
  }) async {
    try {
      await _api.admin.createChannel(
        name: name,
        place: place,
      );
      if (verbose && context.mounted) showSnackBar(context, '채널 생성 완료');
      updateChannels(verbose: false);
    } catch (e) {
      if (context.mounted) if (e is DioException &&
          e.response?.statusMessage != null)
        showErrorSnackBar(context, e.response!.statusMessage!);
      else
        showErrorSnackBar(context, '채널 생성 중 오류가 발생했습니다.');
      rethrow;
    }
  }
}
