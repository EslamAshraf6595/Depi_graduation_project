import 'package:fitness_app/calendar/calendar_screen.dart';
import 'package:fitness_app/createPlan/create_new_plan.dart';
import 'package:fitness_app/pages/homePage/home_page.dart';
import 'package:fitness_app/pages/workout/workout_page.dart';
import 'package:fitness_app/pages/workout/workout_screen.dart';
import 'package:fitness_app/profile/user_profile.dart';
import 'package:flutter/material.dart';

class TabsList {
  static List<Widget> tabs = [
    HomePage(),
    CreateNewPlan(),//goals
    WorkoutPage(),
    CalendarScreen(),
    UserProfile(),
    

    //   HomePage(),
    // WorkOut(),
    // CreateNewPlan(),
    // Calendar(),
    // UserProfile(),
  ];
}
