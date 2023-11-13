import 'package:flutter/material.dart';

import 'package:weplan/components/menus.dart';
import 'package:weplan/models/channel.dart';
import 'package:weplan/screens/timetable_page.dart';

class ChannelsViewModel {
  List<Channel> channels = [];

  ChannelsViewModel(this.channels);

  List<Menu> get menus {
    return channels
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
}
