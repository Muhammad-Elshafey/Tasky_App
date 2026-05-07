import 'package:flutter/material.dart';
import 'package:projects/core/theme/dark_theme.dart';
import 'package:projects/core/theme/light_theme.dart';
import 'package:projects/core/theme/theme_controller.dart';
import 'package:projects/features/home/home_screen.dart';
import 'package:projects/features/navigation/main_screen.dart';
import 'package:projects/features/welcome/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/constants/storage_key.dart';
import 'core/services/preferences_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //prefs.clear();
  await PreferencesManager().init();
  ThemeController().init();

  String? username = PreferencesManager().getString(StorageKey.username);
  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.username});

  final String? username;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ThemeController.themeNotifier,
      builder: (context, ThemeMode currentTheme, Widget? child) {
        return MaterialApp(
          title: 'Tasky',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: currentTheme,
          debugShowCheckedModeBanner: false,
          home: username == null ? WelcomeScreen() : MainScreen(),
        );
      },
    );
  }
}
