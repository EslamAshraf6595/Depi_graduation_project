import 'package:flutter/material.dart';
import 'screens/goals_screen.dart';
import 'screens/create_exercise_screen.dart';
import 'screens/super_set_screen.dart';
import 'screens/create_plan_screen.dart';

void main() {
  runApp(const FitnessApp());
}

class FitnessApp extends StatelessWidget {
  const FitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Roboto',
      ),

      initialRoute: '/',
      routes: {
        '/': (context) => const GoalsScreen(),
        '/create-exercise': (context) => const CreateExerciseScreen(),
        '/super-set': (context) => const SuperSetScreen(),
        '/create-plan': (context) => const CreatePlanScreen(),
      },
    );
  }
}
