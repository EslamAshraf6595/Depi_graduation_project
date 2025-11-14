import 'package:fitness_app/calendar/calendar_screen.dart';
import 'package:fitness_app/createPlan/create_new_plan.dart';
import 'package:fitness_app/pages/homePage/home_page.dart';
import 'package:fitness_app/pages/workOut/work_out.dart';
import 'package:fitness_app/profile/user_profile.dart';
import 'package:flutter/material.dart';

class TabsList {
  static List<Widget> tabs = [
<<<<<<< HEAD
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
=======
    const HomePage(),
    const WorkoutPage(),
    const CreateNewPlan(),
    const Calendar(),
    const UserProfile(),
>>>>>>> parent of 834b5d0 (Revert "workout pages")
  ];
}
