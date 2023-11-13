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

  List<Channel> _channels = [];

  ChannelsViewModel();

  Future<List<Channel>> updateChannels() async {
    this._channels = (await _api.guest.getChannels()).channels;
    notifyListeners();
    return this._channels;
  }

  List<ChannelViewModel> get channels =>
      this._channels.map((e) => ChannelViewModel(e)).toList();

  List<Menu> get menus {
    return _channels
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
