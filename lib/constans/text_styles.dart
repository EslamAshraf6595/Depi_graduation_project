import 'package:flutter/material.dart';

import 'package:final_project/constans/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  static TextStyle bigText = GoogleFonts.ramabhadra(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );
  static TextStyle titles = GoogleFonts.ramabhadra(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
  static TextStyle smallText = GoogleFonts.ramabhadra(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Color(0xffC0C0C0),
  );
  static TextStyle forgotPassword = GoogleFonts.ramabhadra(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Color(0xffC6C6C6),
    decoration: TextDecoration.underline,
    decorationColor: Color(0xffC6C6C6),
    decorationThickness: 4,
  );
  static TextStyle label = GoogleFonts.ramabhadra(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.label,
  );
}