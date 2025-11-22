import 'package:flutter/material.dart';
import 'colors.dart';


class TextStyles {
  static TextStyle bigText = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );
  static TextStyle titles = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
  static TextStyle smallText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Color(0xffC0C0C0),
  );
  static TextStyle forgotPassword = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Color(0xffC6C6C6),
    decoration: TextDecoration.underline,
    decorationColor: Color(0xffC6C6C6),
    decorationThickness: 4,
  );
  static TextStyle label = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.label,
  );
}