import 'package:fitness_app/calories/ui/calories_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/exercise_model.dart';
import 'models/plan_model.dart';
import 'provider/exercise_provider.dart';
import 'provider/plan_provider.dart';
import 'provider/workout_provider.dart';
import 'provider/user_provider.dart';
import 'provider/theme_provider.dart';
import 'roots/app_roots.dart';
import 'utils/app_theme.dart';
import 'auth/login.dart';
import 'splash.dart';
import 'pages/home/homeScreen.dart';
import 'pages/metrics/metrics_screen.dart';
import 'pages/metrics/widgets/body_weight_page.dart';
import 'pages/goal/goal_screen.dart';
import 'pages/form_tracking/ui/form_tracking_screen.dart';
import 'pages/workOut/workout_page.dart';
import 'pages/goal/create_exercise_screen.dart';
import 'pages/goal/super_set_screen.dart';
import 'profile/create_account.dart';
import 'profile/create_account_1.dart';
import 'profile/create_account_2.dart';
import 'profile/settings.dart';
import 'profile/user_profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(ExerciseModelAdapter());
  Hive.registerAdapter(PlanModelAdapter());

  // Open boxes
  await Hive.openBox<PlanModel>('plansBox');
  await Hive.openBox<ExerciseModel>('exercisesBox'); // <- NEW box for exercises
  await Hive.openBox('userBox'); // For auto-login

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ExerciseProvider()), // Hive-backed
        ChangeNotifierProvider(create: (_) => PlanProvider()),
        ChangeNotifierProvider(create: (_) => WorkoutProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
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
      builder: (context, child) {
        return Consumer<UserProvider>(
          builder: (context, userProvider, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,

              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,

              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeProvider.themeMode,

              initialRoute: userProvider.isLoggedIn
                  ? AppRoots.homeScreen
                  : Login.routeName,

              routes: {
                'splash': (context) => Splash(),
                Login.routeName: (context) => const Login(),
                'createAccountSlider': (context) => CreateAccountSlider(),
                'createAccount1': (context) => CreateAccount1(),
                'createAccount2': (context) => CreateAccount2(),
                'profile': (context) => UserProfile(),
                'settings': (context) => SettingsScreen(),

                AppRoots.homeScreen: (context) => const HomeScreen(),
                AppRoots.metricsScreen: (context) => MetricsScreen(),
                AppRoots.boywheight: (context) => BodyWeightScreen(),
                AppRoots.caloriesScreen: (context) => CaloriesScreen(),
                AppRoots.timeTensionScreen: (context) => const SizedBox(),
                AppRoots.golsScreen: (context) => GoalScreen(),
                AppRoots.createPlan: (context) => GoalScreen(),
                AppRoots.formScreen: (context) => FormTrackingScreen(),
                AppRoots.workoutPage: (context) {
                  final args = ModalRoute.of(context)!.settings.arguments;
                  final exercise =
                      args is ExerciseModel ? args : ExerciseModel(title: "Default");
                  return WorkoutPage(exercise: exercise);
                },

                AppRoots.exercisePage: (context) => CreateExerciseScreen(),
                AppRoots.superSet: (context) => SuperSetScreen(),
              },
            );
          },
        );
      },
    );
  }
}
