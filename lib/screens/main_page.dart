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
  NavigationDrawerDestination navDrawer;
  Widget body;

  Menu({
    required this.title,
    required this.navDrawer,
    required this.body,
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
      navDrawer: const NavigationDrawerDestination(
        icon: Icon(Icons.add_rounded),
        label: Text('채널 생성'),
      ),
      body: const ChannelForm(),
    ),
    Menu(
      title: '예약요청 목록',
      navDrawer: const NavigationDrawerDestination(
        icon: Icon(Icons.task_outlined),
        label: Text('예약요청 목록'),
      ),
      body: Container(),
    ),
  ];
  List<Menu> etc = [
    Menu(
      title: '나의 예약',
      navDrawer: const NavigationDrawerDestination(
        icon: Icon(Icons.list_outlined),
        label: Text('나의 예약'),
      ),
      body: Container(child: const Text('my reservation')),
    ),
    Menu(
      title: '설정',
      navDrawer: const NavigationDrawerDestination(
        icon: Icon(Icons.settings),
        // icon: Icon(Icons.logout),
        label: Text('설정'),
      ),
      body: SettingsPage(),
      // body: Container(child: const Text('logout')),
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

  @override
  Widget build(BuildContext context) {
    var channels = context.watch<ChannelsViewModel>().menus;
    var isAdmin = context.watch<AuthService>().isAdmin;
    var selectedMenu = [...channels, ...admins, ...etc][_selectedIndex];

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(selectedMenu.title),
      ),
      drawer: NavigationDrawer(
        selectedIndex: _selectedIndex,
        onDestinationSelected: handleSelect,
        children: [
          // Channel Menu
          if (channels.isNotEmpty) const DrawerSubjects('채널목록'),
          ...channels.map((channel) => channel.navDrawer),
          if (channels.isNotEmpty) const DrawerDivider(),

          // Admin Menu
          if (isAdmin) const DrawerSubjects('관리자'),
          if (isAdmin) ...admins.map((admin) => admin.navDrawer),
          if (isAdmin) const DrawerDivider(),

          ...etc.map((e) => e.navDrawer),
        ],
      ),
      body: selectedMenu.body,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
