import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weplan/screens/theme_selection_page.dart';
import 'package:weplan/services/auth_service.dart';
import 'package:weplan/services/channel_service.dart';
import 'package:weplan/theme/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final List<ListTile Function(BuildContext)> items = [
    (context) => ListTile(
          leading: const Icon(Icons.sync),
          title: const Text('채널 동기화'),
          onTap: () =>
              context.read<ChannelService>().updateChannels(verbose: true),
        ),
    (context) => ListTile(
          leading: const Icon(Icons.contrast), //'테마 설정' 아이콘
          title: const Text('테마 설정'), //'테마 설정' 텍스트
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ThemeSelectionPage(),
              ),
            );
          },
          trailing: Text(
            context.watch<ThemeProvider>().themeMode.toString().split('.').last,
          ),
        ),
    (context) => ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('로그아웃'),
          onTap: () {
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
          },
        ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) =>
          const Divider(height: 1, thickness: 0.1),
      itemCount: items.length,
      itemBuilder: (context, index) => items[index](context),
    );
  }
}
