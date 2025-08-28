import 'dart:math';

import 'package:fitness_app/theme/app_theme.dart';
import 'package:fitness_app/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("app_title".tr())),
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("welcome".tr(),
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (context.locale.languageCode == 'en') {
                  context.setLocale(Locale('ar', 'EG'));
                } else {
                  context.setLocale(Locale('en', 'US'));
                }
              },
              child: Text("change_language".tr()),
            ),
            ElevatedButton(
              onPressed: () {
                if (themeProvider.themeMode == ThemeMode.light) {
                  themeProvider.updateTheme(ThemeMode.dark);
                  print("change to dark");
                } else {
                  themeProvider.updateTheme(ThemeMode.light);
                  print("change to light");
                }
              },
              child: Text(
                "change_theme".tr(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
