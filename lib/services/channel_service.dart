import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weplan/models/channel.dart';
import 'package:weplan/models/schedule.dart';
import 'package:weplan/services/api_provider.dart';
import 'package:weplan/utils/navigator.dart';
import 'package:weplan/viewmodels/channels.dart';

class ChannelsService extends ChangeNotifier {
  static ApiProvider api = navigatorKey.currentContext!.read<ApiProvider>();
  List<Channel> channels = [];
  ChannelsViewModel get viewModel => ChannelsViewModel(channels);

  Future<List<Channel>> updateChannels() async {
    this.channels = (await api.guest.getChannels()).channels;
    return this.channels;
  }

  Future<void> createChannel(String name, String place) async {
    await api.admin.createChannel(
      name: name,
      place: place,
    );
  }
}

class ChannelService {
  ApiProvider api = navigatorKey.currentContext!.read<ApiProvider>();
  ChannelService(this._channel);

  Channel _channel;
  Channel get channel => _channel;
  int get id => _channel.id;
  String get name => _channel.name;
  String get place => _channel.place;
  String get createdBy => _channel.createdBy;

  List<Schedule> schedules = [];

  Future<Channel> updateChannel() async {
    this._channel = await api.guest.getChannel(channelId: this._channel.id);
    return this._channel;
  }

  Future<void> createSchedule({
    required String name,
    required DateTime start,
    required DateTime end,
    String? content,
  }) async {
    return await api.guest.createSchedule(
      channelId: _channel.id,
      name: name,
      start: start.toIso8601String(),
      end: end.toIso8601String(),
      content: content,
    );
  }

  Future<List<Schedule>> getSchedules({
    required start,
    required end,
  }) async {
    return (await api.guest.getSchedules(channelId: _channel.id)).schedules;
  }
}
