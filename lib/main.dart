import 'package:final_project/screens/create_account_1.dart';
import 'package:final_project/screens/create_account_2.dart';
import 'package:final_project/screens/login.dart';
import 'package:final_project/screens/profile.dart';
import 'package:final_project/screens/settings.dart';
import 'package:final_project/screens/splash.dart';
import 'package:flutter/material.dart';

import 'screens/create_account.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash',
      routes: {
        'splash': (context) => Splash(),
        'login': (context) => Login(),
        'createAccountSlider': (context) => CreateAccountSlider(),
        'createAccount1': (context) => CreateAccount1(),
        'createAccount2': (context) => CreateAccount2(),
        'profile': (context) => ProfileScreen(),
        'settings': (context) => SettingsScreen(),
      },
    );
  }
}
