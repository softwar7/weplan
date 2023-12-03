import 'package:flutter/material.dart';

import 'package:weplan/screens/admin_channel_management.dart';
import 'package:weplan/screens/forms/channel_form.dart';
import 'package:weplan/screens/my_reservations.dart';
import 'package:weplan/screens/reservation_requests.dart';
import 'package:weplan/screens/settings_page.dart';
import 'package:weplan/utils/navigator.dart';

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
      title: '채널 관리',
      icon: const Icon(Icons.list_outlined),
      body: const ChannelManagement(),
      actions: [
        IconButton(
          icon: const Icon(Icons.add_rounded),
          onPressed: () {
            Navigator.push(
              navigatorKey.currentContext!,
              MaterialPageRoute(
                builder: (context) => const ChannelFormScaffold(),
              ),
            );
          },
        ),
      ],
    ),
    Menu(
      title: '예약요청 목록',
      icon: const Icon(Icons.task_outlined),
      body: const ReservationRequests(),
    ),
  ];

  static final List<Menu> etc = [
    Menu(
      title: '나의 예약',
      icon: const Icon(Icons.list_outlined),
      body: const MyReservations(),
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
