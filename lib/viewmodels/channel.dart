import 'package:provider/provider.dart';

import 'package:weplan/models/channel.dart';
import 'package:weplan/models/schedule.dart';
import 'package:weplan/services/api_provider.dart';
import 'package:weplan/utils/navigator.dart';
import 'package:weplan/viewmodels/schedule.dart';

class ChannelViewModel {
  final ApiProvider _api = navigatorKey.currentContext!.read<ApiProvider>();
  Channel _channel;
  ChannelViewModel(this._channel);

  Channel get model => _channel;
  int get id => _channel.id;
  String get name => _channel.name;
  String get place => _channel.place;
  String get createdBy => _channel.createdBy;

  Map<int, ScheduleViewModel> _schedules = {};
  Map<int, ScheduleViewModel> get schedules => _schedules;

  Future<Channel> updateChannel() async {
    this._channel = await _api.guest.getChannel(channelId: this._channel.id);
    return this._channel;
  }

  Future<Map<int, ScheduleViewModel>> updateSchedules({
    DateTime? start,
    DateTime? end,
  }) async {
    this._schedules = {
      for (Schedule e
          in (await _api.guest.getSchedules(channelId: id)).schedules)
        e.id: ScheduleViewModel(e),
    };

    return this._schedules;
  }

  Future<void> createSchedule({
    int? channelId,
    required String name,
    required DateTime start,
    required DateTime end,
    String? content,
  }) async {
    return await _api.guest.createSchedule(
      channelId: channelId ?? _channel.id,
      name: name,
      start: start.toIso8601String(),
      end: end.toIso8601String(),
      content: content,
    );
  }
}
