import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weplan/screens/main_page.dart';
import 'package:weplan/services/channel_service.dart';
import 'package:weplan/utils/navigator.dart';

class MainMaterialApp extends StatelessWidget {
  const MainMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ChannelService(),
        ),
      ],
      child: MaterialApp(
        title: 'WePlan',
        themeMode: ThemeMode.system,
        theme: ThemeData(
          colorScheme: const ColorScheme.light(),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: const ColorScheme.dark(),
          useMaterial3: true,
        ),
        navigatorKey: navigatorKey,
        home: const MainPage(),
      ),
    );
  }
}
