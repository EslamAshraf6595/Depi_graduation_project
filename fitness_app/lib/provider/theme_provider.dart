import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode themeMode=ThemeMode.dark;

  void updateTheme(ThemeMode newTheme){
    if(themeMode!=newTheme){
      themeMode=newTheme;
    }
    notifyListeners();
  }
}