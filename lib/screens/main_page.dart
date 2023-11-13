import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weplan/components/drawer/divider.dart';
import 'package:weplan/components/drawer/subject.dart';
import 'package:weplan/components/menus.dart';
import 'package:weplan/services/auth_service.dart';
import 'package:weplan/services/channel_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  List<Menu> admins = Menus.admins;
  List<Menu> etc = Menus.etc;

  void handleSelect(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState?.openEndDrawer();
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<ChannelsService>().updateChannels();
  }

  @override
  Widget build(BuildContext context) {
    var channels = context.watch<ChannelsService>().viewModel.menus;
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
          ...channels.map(Menus.navDrawerMapper),
          if (channels.isNotEmpty) const DrawerDivider(),

          // Admin Menu
          if (isAdmin) const DrawerSubjects('관리자'),
          if (isAdmin) ...admins.map(Menus.navDrawerMapper),
          if (isAdmin) const DrawerDivider(),

          ...etc.map(Menus.navDrawerMapper),
        ],
      ),
      body: selectedMenu.body,
      floatingActionButton: selectedMenu.floatingActionButton,
    );
  }
}
