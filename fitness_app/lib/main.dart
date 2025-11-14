import 'package:fitness_app/createPlan/create_new_plan.dart';
import 'package:fitness_app/pages/form_tracking/ui/form_tracking_screen.dart';
import 'package:fitness_app/pages/goals/ui/goals_screen.dart';
import 'package:fitness_app/pages/metrics/widgets/body_weight_page.dart';
import 'package:fitness_app/pages/metrics/metrics_screen.dart';
import 'package:fitness_app/calories/ui/calories_screen.dart';
import 'package:fitness_app/roots/app_roots.dart';
import 'package:fitness_app/timeTension/ui/time_under_tension_screen.dart';
import 'package:fitness_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'pages/home/homeScreen.dart';
import 'utils/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: EasyLocalization(
          supportedLocales: [
            Locale('en', 'US'),
            Locale('ar', 'EG'),
          ],
          path: 'assets/translations',
          fallbackLocale: Locale('en', 'US'),
          child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            initialRoute: AppRoots.homeScreen,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            routes: {
              AppRoots.homeScreen: (context) => HomeScreen(),
              AppRoots.metricsScreen: (context) => MetricsScreen(),
              AppRoots.boywheight: (context) => BodyWeightScreen(),
              AppRoots.caloriesScreen: (context) => CaloriesScreen(),
              AppRoots.timeTensionScreen: (context) => TimeUnderTensionScreen(),
              AppRoots.golsScreen: (context) => GoalsScreen(),
              AppRoots.createPlan: (context) => CreateNewPlan(),
              AppRoots.formScreen: (context) => FormTrackingScreen(),
            },
          );
        });
  }
}
