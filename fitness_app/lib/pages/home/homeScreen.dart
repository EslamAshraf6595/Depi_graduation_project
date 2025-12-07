import 'package:fitness_app/utils/app_assets.dart';
import 'package:fitness_app/utils/app_color.dart';
import 'package:fitness_app/utils/tabs_list.dart';
import 'package:fitness_app/provider/theme_provider.dart';
import 'package:fitness_app/provider/user_provider.dart';
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
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),

      /// MAIN BODY
      body: TabsList.tabs[selectedIndex],

      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      /// BOTTOM NAVBAR
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
              icon: const ImageIcon(AssetImage(AppAssets.home)),
              label: "home".tr()),
          BottomNavigationBarItem(
              icon: const ImageIcon(AssetImage(AppAssets.gym), size: 30),
              label: "goals".tr()),
          BottomNavigationBarItem(
              icon: const Icon(Icons.add_circle_outline),
              label: "Workout".tr()),
          BottomNavigationBarItem(
              icon: const ImageIcon(AssetImage(AppAssets.calendar)),
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
                child: const CircleAvatar(
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
