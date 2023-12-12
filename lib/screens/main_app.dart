import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:weplan/screens/main_page.dart';
import 'package:weplan/services/channel_service.dart';
import 'package:weplan/services/my_reservation_service.dart';
import 'package:weplan/services/reservation_request_service.dart';
import 'package:weplan/theme/dark.dart';
import 'package:weplan/theme/light.dart';
import 'package:weplan/theme/theme_provider.dart';
import 'package:weplan/utils/navigator.dart';

class MainMaterialApp extends StatelessWidget {
  const MainMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ChannelService(context),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => MyReservationsService(context),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => ReservationRequestService(context),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'WePlan',
        themeMode: context.watch<ThemeProvider>().themeMode,
        theme: lightTheme,
        darkTheme: darkTheme,
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
