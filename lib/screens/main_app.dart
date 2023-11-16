import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:weplan/screens/main_page.dart';
import 'package:weplan/services/channel_service.dart';
import 'package:weplan/services/my_reservation_service.dart';
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
        ChangeNotifierProvider(
          create: (context) => MyReservationsService(),
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
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ko', 'KR'),
        ],
        locale: const Locale('ko', 'KR'),
      ),
    );
  }
}
