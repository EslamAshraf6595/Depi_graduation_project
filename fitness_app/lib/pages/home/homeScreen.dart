import 'dart:math';

import 'package:fitness_app/utils/app_assets.dart';
import 'package:fitness_app/utils/app_color.dart';
import 'package:fitness_app/utils/app_theme.dart';
import 'package:fitness_app/utils/tabs_list.dart';
import 'package:fitness_app/utils/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("app_title".tr())),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text("welcome".tr(),
      //           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      //       const SizedBox(height: 20),
      //       ElevatedButton(
      //         onPressed: () {
      //           if (context.locale.languageCode == 'en') {
      //             context.setLocale(Locale('ar', 'EG'));
      //           } else {
      //             context.setLocale(Locale('en', 'US'));
      //           }
      //         },
      //         child: Text("change_language".tr()),
      //       ),
      //       ElevatedButton(
      //         onPressed: () {
      //           if (themeProvider.themeMode == ThemeMode.light) {
      //             themeProvider.updateTheme(ThemeMode.dark);
      //             print("change to dark");
      //           } else {
      //             themeProvider.updateTheme(ThemeMode.light);
      //             print("change to light");
      //           }
      //         },
      //         child: Text(
      //           "change_theme".tr(),
      //         ),
      //       ),

      //     ],
      //   ),
      // ),
      
      body: TabsList.tabs[selectedIndex],
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primeOrange,
        unselectedItemColor: AppColors.grey,
        items: [
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(AppAssets.home),
              ),
              label: "home".tr()),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(AppAssets.gym),
                size: 30,
              ),
              label: "gym".tr()),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline), label: "Workout".tr()),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(AppAssets.calendar)),
              label: "calendar".tr()),
          BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: selectedIndex == 4
                        ? AppColors.primeOrange
                        : Theme.of(context).scaffoldBackgroundColor,
                    width: 2,
                  ),
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: 14,
                  backgroundImage: AssetImage(AppAssets.user),
                ),
              ),
              label: "profile".tr()),
        ],
      ),
      
    );
  }
}
