import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weplan/screens/forms/login.dart';
import 'package:weplan/theme/dark.dart';
import 'package:weplan/theme/light.dart';
import 'package:weplan/theme/theme_provider.dart';

class SignMaterialApp extends StatelessWidget {
  const SignMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WePlan Login',
      themeMode: context.watch<ThemeProvider>().themeMode,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const LoginScaffold(),
    );
  }
}
