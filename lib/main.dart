import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weplan/screens/main_app.dart';
import 'package:weplan/screens/sign_app.dart';
import 'package:weplan/services/auth_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<AuthService>(
      create: (_) => AuthService(),
      builder: (context, child) =>
          context.watch<AuthService>().accessToken != null
              ? const MainMaterialApp()
              : const SignMaterialApp(),
    );
  }
}
