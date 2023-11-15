import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weplan/components/menus.dart';
import 'package:weplan/models/channel.dart';
import 'package:weplan/screens/timetable_page.dart';
import 'package:weplan/services/api_provider.dart';
import 'package:weplan/utils/navigator.dart';
import 'package:weplan/viewmodels/channel.dart';

class ChannelsViewModel extends ChangeNotifier {
  final ApiProvider _api = navigatorKey.currentContext!.read<ApiProvider>();

  Map<int, ChannelViewModel> _channels = {};
  Map<int, ChannelViewModel> get channels => this._channels;
  Map<int, Channel> get models => this._channels.map(
        (key, value) => MapEntry(key, value.model),
      );

  Future<Map<int, ChannelViewModel>> updateChannels() async {
    this._channels = {
      for (Channel e in (await _api.guest.getChannels()).channels)
        e.id: ChannelViewModel(e),
    };
    notifyListeners();
    return this._channels;
  }

  List<Menu> get menus {
    return _channels.values
        .map(
          (e) => Menu(
            title: e.name,
            icon: const Icon(Icons.calendar_today_outlined),
            body: TimeTable(channel: e),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {},
              ),
            ],
          ),
        )
        .toList();
  }

  // Admin Only
  Future<void> createChannel(String name, String place) async {
    await _api.admin.createChannel(
      name: name,
      place: place,
    );
    updateChannels();
  }
}
