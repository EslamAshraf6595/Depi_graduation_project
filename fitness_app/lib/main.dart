import 'package:fitness_app/models/exercise_model.dart';
import 'package:fitness_app/pages/goal/create_exercise_screen.dart';
import 'package:fitness_app/pages/goal/create_plan_screen.dart';
import 'package:fitness_app/pages/goal/goal_screen.dart';
import 'package:fitness_app/pages/goal/super_set_screen.dart';
import 'package:fitness_app/pages/form_tracking/ui/form_tracking_screen.dart';
import 'package:fitness_app/pages/metrics/widgets/body_weight_page.dart';
import 'package:fitness_app/pages/metrics/metrics_screen.dart';
import 'package:fitness_app/calories/ui/calories_screen.dart';
import 'package:fitness_app/pages/workOut/workout_page.dart';
import 'package:fitness_app/provider/exercise_provider.dart';
import 'package:fitness_app/provider/plan_provider.dart';
import 'package:fitness_app/provider/workout_provider.dart';
import 'package:fitness_app/roots/app_roots.dart';
import 'package:fitness_app/timeTension/ui/time_under_tension_screen.dart';
import 'package:fitness_app/utils/app_theme.dart';
import 'package:fitness_app/auth/login.dart';
import 'package:fitness_app/profile/create_account.dart';
import 'package:fitness_app/profile/create_account_1.dart';
import 'package:fitness_app/profile/create_account_2.dart';
import 'package:fitness_app/profile/settings.dart';
import 'package:fitness_app/profile/user_profile.dart';
import 'package:fitness_app/splash.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'pages/home/homeScreen.dart';
import '../provider/theme_provider.dart';
import 'package:fitness_app/data/services/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // Initialize Hive with all models
  // await HiveService.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ExerciseProvider()),
        ChangeNotifierProvider(create: (_) => PlanProvider()),
         ChangeNotifierProvider(create: (_) => WorkoutProvider()),
      ],
      child: EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ar', 'EG'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // Localization
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,

          // Theme
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,

          // Start on Splash (then navigate to home/login)
          initialRoute: AppRoots.homeScreen,

          routes: {
            // 🔹 Splash + Auth + Profile
            'splash': (context) => Splash(),
            'login': (context) => Login(),
            'createAccountSlider': (context) => CreateAccountSlider(),
            'createAccount1': (context) => CreateAccount1(),
            'createAccount2': (context) => CreateAccount2(),
            'profile': (context) => UserProfile(),
            'settings': (context) => SettingsScreen(),

            // 🔹 Main App Routes
            AppRoots.homeScreen: (context) => HomeScreen(),
            AppRoots.metricsScreen: (context) => MetricsScreen(),
            AppRoots.boywheight: (context) => BodyWeightScreen(),
            AppRoots.caloriesScreen: (context) => CaloriesScreen(),
            AppRoots.timeTensionScreen: (context) => TimeUnderTensionScreen(),
            AppRoots.golsScreen: (context) => GoalScreen(),
            AppRoots.createPlan: (context) => GoalScreen(),
            AppRoots.formScreen: (context) => FormTrackingScreen(),
            AppRoots.workoutPage: (context) {
              final args = ModalRoute.of(context)!.settings.arguments;

              // If no arguments passed, fallback to default exercise
              final exercise = args is ExerciseModel
                  ? args
                  : ExerciseModel(
                      title: "Default Exercise",
                      maxReps: 10,
                      maxSets: 3,
                      weight: 0,
                      rest: 30,
                    );

              return WorkoutPage(exercise: exercise);
            },

            AppRoots.exercisePage: (context) => CreateExerciseScreen(),
            // AppRoots.createPlan: (context) => CreatePlanScreen(),
            AppRoots.superSet: (context) => SuperSetScreen(),
          },
        );
      },
    );
  }
}
