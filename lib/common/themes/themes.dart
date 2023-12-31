import 'package:employee_forums/common/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static ThemeData light = ThemeData(
    textTheme: GoogleFonts.ubuntuTextTheme(),
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.white),
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      surfaceTintColor: AppColors.white,
      backgroundColor: AppColors.white,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: AppColors.black,
      ),
      titleTextStyle: TextStyle(
        fontSize: 19,
        color: AppColors.black,
      ),
    ),
    searchBarTheme: SearchBarThemeData(
      backgroundColor: const MaterialStatePropertyAll(AppColors.coldWhite),
      textStyle: const MaterialStatePropertyAll(
        TextStyle(
          color: AppColors.charcoalGrey,
        ),
      ),
      elevation: const MaterialStatePropertyAll(0),
      constraints: const BoxConstraints(minHeight: 44, maxHeight: 44),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0,
      showUnselectedLabels: true,
      selectedLabelStyle: TextStyle(
        color: AppColors.white,
        fontSize: 10,
      ),
      unselectedLabelStyle: TextStyle(
        color: AppColors.white,
        fontSize: 10,
      ),
      selectedIconTheme: IconThemeData(
        size: 35,
        color: AppColors.blue,
      ),
      unselectedIconTheme: IconThemeData(
        size: 35,
        color: AppColors.white,
      ),
    ),
  );
}
