import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import 'package:weplan/models/channel.dart';
import 'package:weplan/screens/channel_timetable.dart';
import 'package:weplan/screens/main_page.dart';
import 'package:weplan/services/api_service.dart';
import 'package:weplan/utils/navigator.dart';

class ChannelsViewModel extends ChangeNotifier {
  var context = navigatorKey.currentContext!;
  List<Channel> channels = [];

  Future<void> createChannel(String name, String place) async {
    try {
      await context.read<ApiService>().createChannel(name, place);
    } on DioException catch (e) {
      throw Exception(e.response!.statusMessage!);
    } catch (e) {
      throw Exception('채널을 생성하는 중 오류가 발생했습니다.');
    }
    updateChannels();
  }

  void updateChannels() async {
    try {
      channels = await context.read<ApiService>().getChannels();
      notifyListeners();
    } on DioException catch (e) {
      throw Exception(e.response!.statusMessage!);
    } catch (e) {
      throw Exception('채널목록을 불러오는 중 오류가 발생했습니다.');
    }
  }

  List<Menu> get menus {
    return channels
        .map(
          (e) => Menu(
            title: e.name,
            navDrawer: NavigationDrawerDestination(
              icon: const Icon(Icons.calendar_month_outlined),
              label: Text(e.name),
            ),
            body: TimeTable(channel: e),
          ),
        )
        .toList();
  }
}
