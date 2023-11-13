import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weplan/components/drawer/divider.dart';
import 'package:weplan/components/drawer/subject.dart';
import 'package:weplan/screens/forms/channel_form.dart';
import 'package:weplan/screens/settings_page.dart';
import 'package:weplan/services/auth_service.dart';
import 'package:weplan/viewmodels/channels.dart';

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

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  List<Menu> admins = [
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
  List<Menu> etc = [
    Menu(
      title: '나의 예약',
      icon: const Icon(Icons.list_outlined),
      body: Container(child: const Text('my reservation')),
    ),
    Menu(
      title: '설정',
      icon: const Icon(Icons.settings),
      body: SettingsPage(),
    ),
  ];

  void handleSelect(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState?.openEndDrawer();
    }

    var channels = context.read<ChannelsViewModel>().channels;
    int myReservationIndex = channels.length + admins.length + 0;
    int logoutIndex = channels.length + admins.length + 1;
  }

  @override
  void initState() {
    super.initState();
    context.read<ChannelsViewModel>().updateChannels();
  }

  Widget navDrawerMapper(Menu menu) {
    return NavigationDrawerDestination(
      icon: menu.icon,
      label: Text(menu.title),
    );
  }

  @override
  Widget build(BuildContext context) {
    var channels = context.watch<ChannelsViewModel>().menus;
    var isAdmin = context.watch<AuthService>().isAdmin;
    var selectedMenu = [...channels, ...admins, ...etc][_selectedIndex];

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(selectedMenu.title),
        actions: selectedMenu.actions,
      ),
      drawer: NavigationDrawer(
        selectedIndex: _selectedIndex,
        onDestinationSelected: handleSelect,
        children: [
          // Channel Menu
          if (channels.isNotEmpty) const DrawerSubjects('채널목록'),
          ...channels.map(navDrawerMapper),
          if (channels.isNotEmpty) const DrawerDivider(),

          // Admin Menu
          if (isAdmin) const DrawerSubjects('관리자'),
          if (isAdmin) ...admins.map(navDrawerMapper),
          if (isAdmin) const DrawerDivider(),

          ...etc.map(navDrawerMapper),
        ],
      ),
      body: selectedMenu.body,
      floatingActionButton: selectedMenu.floatingActionButton,
    );
  }
}
