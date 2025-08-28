import 'package:fitness_app/theme/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    //fontFamily: GoogleFonts.inter().fontFamily,
    primaryColor: AppColors.white,

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      elevation: 0,
      // centerTitle: true,
      // titleTextStyle: AppStyles.primaryRegular16,
      // iconTheme: IconThemeData(color: AppColors.primaryYellowColor),
    ),
    // textTheme: TextTheme(
    //   bodySmall: lightMedium14,
    //   labelSmall: lightMedium12,
    //   bodyMedium: lightMedium20,
    //   bodyLarge: lightMedium24,
    //   headlineSmall: lightGrayMedium12,
    // ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkColor,
    //fontFamily: GoogleFonts.inter().fontFamily,
    primaryColor: AppColors.darkColor,


    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkColor,
      // elevation: 0,
      // centerTitle: true,
      // titleTextStyle: AppStyles.primaryRegular16,
      // iconTheme: IconThemeData(color: AppColors.primaryYellowColor),
    ),
    // textTheme: TextTheme(
    //   bodySmall: darkMedium14,
    //   labelSmall: darkMedium12,
    //   bodyMedium: darkMedium20,
    //   bodyLarge: darkMedium24,
    //   headlineSmall: lightGrayMedium12,
    // ),
  );
}
