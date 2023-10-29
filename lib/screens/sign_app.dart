import 'package:flutter/material.dart';

import 'package:weplan/screens/forms/login.dart';

class SignMaterialApp extends StatelessWidget {
  const SignMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WePlan Login',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      home: const LoginScaffold(),
    );
  }
}
