import 'package:flutter/material.dart';

import 'package:weplan/screens/forms/channel_form.dart';
import 'package:weplan/screens/my_reservations.dart';
import 'package:weplan/screens/settings_page.dart';

class Menu {
  String title;
  Icon icon;
  Widget body;
  List<Widget>? actions;
  Widget? floatingActionButton;

  Menu({
    required this.title,
    required this.icon,
    required this.body,
    this.actions,
    this.floatingActionButton,
  });
}

class Menus {
  static final List<Menu> admins = [
    Menu(
      title: '채널 생성',
      icon: const Icon(Icons.add_rounded),
      body: const ChannelForm(),
    ),
    Menu(
      title: '예약요청 목록',
      icon: const Icon(Icons.task_outlined),
      body: Container(),
    ),
  ];

  static final List<Menu> etc = [
    Menu(
      title: '나의 예약',
      icon: const Icon(Icons.list_outlined),
      body: const MyReservations(),
      // body: Container(child: const Text('my reservation')),
    ),
    Menu(
      title: '설정',
      icon: const Icon(Icons.settings),
      body: SettingsPage(),
    ),
  ];

  static Widget navDrawerMapper(Menu menu) {
    return NavigationDrawerDestination(
      icon: menu.icon,
      label: Text(menu.title),
    );
  }
}
