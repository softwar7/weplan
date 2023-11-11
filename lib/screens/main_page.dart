import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weplan/components/drawer/divider.dart';
import 'package:weplan/components/drawer/subject.dart';
import 'package:weplan/screens/forms/channel_form.dart';
import 'package:weplan/services/auth_service.dart';
import 'package:weplan/viewmodels/channels.dart';

class Menu {
  NavigationDrawerDestination navDrawer;
  Widget body;

  Menu({
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
      navDrawer: const NavigationDrawerDestination(
        icon: Icon(Icons.add_rounded),
        label: Text('채널 생성'),
      ),
      body: const ChannelForm(),
      // body: Container(),
    ),
    Menu(
      navDrawer: const NavigationDrawerDestination(
        icon: Icon(Icons.task_outlined),
        label: Text('예약요청 목록'),
      ),
      body: Container(),
    ),
  ];
  List<Menu> etc = [
    Menu(
      navDrawer: const NavigationDrawerDestination(
        icon: Icon(Icons.list_outlined),
        label: Text('나의 예약'),
      ),
      body: Container(child: const Text('my reservation')),
    ),
    Menu(
      navDrawer: const NavigationDrawerDestination(
        icon: Icon(Icons.logout),
        label: Text('로그아웃'),
      ),
      body: Container(child: const Text('logout')),
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

    if (index == logoutIndex) {
      handleLogout();
      return;
    }
  }

  void handleLogout() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('로그아웃'),
        content: const Text('로그아웃 하시겠습니까?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => context.read<AuthService>().signOut(),
            child: const Text('확인'),
          ),
        ],
      ),
    );
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

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Main Page'),
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
      body: [...channels, ...admins, ...etc][_selectedIndex].body,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
