import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
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

    int myReservationIndex =
        channels.length + (context.read<AuthService>().isAdmin ? 2 : 0);
    if (index == myReservationIndex) {
      // TODO: 나의 예약 페이지로 이동
      showSnackBar(context, '나의 예약');
      return;
    }

    int logoutIndex = myReservationIndex + 1;
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
    context.read<ApiService>().getChannels().then((value) {
      setState(() {
        channels = value;
      });
      showSnackBar(context, '채널목록을 불러왔습니다.');
    }).catchError((e) {
      if (e is DioException)
        showErrorSnackBar(context, e.response!.statusMessage!);
      else
        showErrorSnackBar(context, '채널목록을 불러오는 중 오류가 발생했습니다.');
      throw e;
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthService authService = context.watch<AuthService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
      ),
      drawer: NavigationDrawer(
        selectedIndex: _selectedIndex,
        onDestinationSelected: handleSelect,
        children: [
          // Channel Menu
          if (channels.isNotEmpty) const DrawerSubjects('채널목록'),
          ...channels.map(
            (e) => NavigationDrawerDestination(
              icon: const Icon(Icons.calendar_month_outlined),
              label: Text(e.name),
            ),
          ),
          if (channels.isNotEmpty) const DrawerDivider(),

          // Admin Menu
          if (authService.isAdmin) const DrawerSubjects('관리자'),
          if (authService.isAdmin)
            const NavigationDrawerDestination(
              icon: Icon(Icons.add_rounded),
              label: Text('채널 생성'),
            ),
          if (authService.isAdmin)
            const NavigationDrawerDestination(
              icon: Icon(Icons.task_outlined),
              label: Text('예약요청 목록'),
            ),
          if (authService.isAdmin) const DrawerDivider(),

          const NavigationDrawerDestination(
            icon: Icon(Icons.list_outlined),
            label: Text('나의 예약'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.logout),
            label: Text('로그아웃'),
          ),
        ],
      ),
      // TODO: 매칭되는 페이지 표시
      // body: TimeTable(),
      body: TimeTableComponent(
        items: items,
        onTap: (item) {
          showSnackBar(context, item.toString());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
