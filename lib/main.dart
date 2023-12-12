import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:weplan/firebase_options.dart';
import 'package:weplan/screens/main_app.dart';
import 'package:weplan/screens/sign_app.dart';
import 'package:weplan/services/api_provider.dart';
import 'package:weplan/services/auth_service.dart';
import 'package:weplan/theme/theme_provider.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  timeago.setLocaleMessages('ko', timeago.KoMessages());

  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<AuthService>(
          create: (_) => AuthService(),
          lazy: false,
        ),
      ],
      builder: (context, child) => context.watch<AuthService>().isAuthenticated
          ? Provider<ApiProvider>(
              create: (_) => ApiProvider(context.watch<AuthService>()),
              lazy: false,
              child: const MainMaterialApp(),
            )
          : const SignMaterialApp(),
    );
  }
}
