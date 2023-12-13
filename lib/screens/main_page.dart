import 'dart:async';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weplan/components/drawer/divider.dart';
import 'package:weplan/components/drawer/subject.dart';
import 'package:weplan/components/menus.dart';
import 'package:weplan/services/auth_service.dart';
import 'package:weplan/services/channel_service.dart';
import 'package:weplan/services/my_reservation_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  List<Menu> channels = [];
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

  Timer? timer;

  @override
  void initState() {
    super.initState();

    context.read<ChannelService>().updateChannels();
    timer = Timer.periodic(
      const Duration(seconds: 30),
      (Timer t) =>
          context.read<ChannelService>().updateChannels(verbose: false),
    );

    context.read<MyReservationsService>().update();
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  int _lastChannelLength = 0;
  List<int> _lastChannelIds = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    channels = context.watch<ChannelService>().menus;
    var channelIds =
        context.read<ChannelService>().list.map((e) => e.id).toList();

    if (channels.length != _lastChannelLength) {
      if (channels.length < _lastChannelLength) {
        int deletedChannelIndex = _lastChannelIds.indexWhere(
          (element) => !channelIds.contains(element),
        );

        if (_selectedIndex >= deletedChannelIndex && _selectedIndex > 0)
          _selectedIndex--;
      }
      _lastChannelLength = channels.length;
      _lastChannelIds = channelIds;
    }
  }

  @override
  Widget build(BuildContext context) {
    var isAdmin = context.watch<AuthService>().isAdmin;
    var selectedMenu =
        [...channels, if (isAdmin) ...admins, ...etc][_selectedIndex];

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(selectedMenu.title),
        actions: selectedMenu.actions,
      ),
      drawer: NavigationDrawer(
        // backgroundColor: Color.fromRGBO(238, 245, 255, 1), //원래 회색
        // backgroundColor: Color.fromRGBO(255, 181, 52, 1), //퍼머넌트 옐로우
        backgroundColor: const Color.fromRGBO(250, 238, 209, 1),
        selectedIndex: _selectedIndex,
        onDestinationSelected: handleSelect,
        children: [
          // Channel Menu
          const DrawerSubjects('채널목록'),
          ...channels.map(Menus.navDrawerMapper),
          if (channels.isEmpty) const DrawerSubjects('현재 등록된 채널이 없습니다.'),
          const DrawerDivider(),

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
