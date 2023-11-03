import 'package:flutter/material.dart';

import 'package:flutter_timetable/flutter_timetable.dart';
import 'package:provider/provider.dart';

import 'package:weplan/components/drawer/divider.dart';
import 'package:weplan/components/drawer/subject.dart';
import 'package:weplan/components/snackbar.dart';
import 'package:weplan/components/timetable.dart';
import 'package:weplan/models/channel.dart';
import 'package:weplan/services/api_service.dart';
import 'package:weplan/services/auth_service.dart';

var items = [
  TimetableItem(
    DateTime.parse('2023-11-04 09:00:00'),
    DateTime.parse('2023-11-04 12:00:00'),
    data: 'test',
  ),
  TimetableItem(
    DateTime.parse('2023-11-03 10:00:00'),
    DateTime.parse('2023-11-03 12:00:00'),
    data: 'test',
  ),
  TimetableItem(
    DateTime.parse('2023-11-03 12:00:00'),
    DateTime.parse('2023-11-03 15:00:00'),
    data: 'test',
  ),
  TimetableItem(
    DateTime.parse('2023-11-05 12:00:00'),
    DateTime.parse('2023-11-05 15:00:00'),
    data: 'test',
  ),
  TimetableItem(
    DateTime.parse('2023-11-06 12:00:00'),
    DateTime.parse('2023-11-06 15:00:00'),
    data: 'test',
  ),
  TimetableItem(
    DateTime.parse('2023-11-08 17:00:00'),
    DateTime.parse('2023-11-08 19:00:00'),
    data: 'test',
  ),
];

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Channel> channels = [];
  int _selectedIndex = 0;
  void handleSelect(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    context
        .read<ApiService>()
        .getChannels()
        .then((value) => channels = value)
        .catchError((e) {
      showErrorSnackBar(context, '채널목록을 불러오는 중 오류가 발생했습니다.');
      throw e;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
      ),
      drawer: NavigationDrawer(
        selectedIndex: _selectedIndex,
        onDestinationSelected: handleSelect,
        children: [
          const NavigationDrawerDestination(
            icon: Icon(Icons.list_outlined),
            label: Text('나의 예약'),
          ),
          const DrawerDivider(),

          // Channel Menu
          const DrawerSubjects('채널목록'),
          const NavigationDrawerDestination(
            icon: Icon(Icons.tv),
            label: Text('Home'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.boy),
            label: Text('Home'),
          ),
          const DrawerDivider(),

          // Admin Menu
          if (context.watch<AuthService>().isAdmin) const DrawerSubjects('관리자'),
          if (context.watch<AuthService>().isAdmin)
            const NavigationDrawerDestination(
              icon: Icon(Icons.add_rounded),
              label: Text('채널 생성'),
            ),
          if (context.watch<AuthService>().isAdmin)
            const NavigationDrawerDestination(
              icon: Icon(Icons.task_outlined),
              label: Text('예약요청 목록'),
            ),
          if (context.watch<AuthService>().isAdmin) const DrawerDivider(),

          const NavigationDrawerDestination(
            icon: Icon(Icons.logout),
            label: Text('로그아웃'),
          ),
        ],
      ),
      body: TimeTableComponent(
        items: items,
        onTap: (item) {
          showSnackBar(context, item.toString());
        },
      ),
      // body: TimeTable(channel: channel),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
