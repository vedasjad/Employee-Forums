import 'package:employee_forums/common/colors/colors.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.white),
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
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
    searchBarTheme: const SearchBarThemeData(
      backgroundColor: MaterialStatePropertyAll(AppColors.coldWhite),
      textStyle: MaterialStatePropertyAll(
        TextStyle(
          color: AppColors.greyTextColor,
        ),
      ),
      elevation: MaterialStatePropertyAll(0),
      constraints: BoxConstraints(minHeight: 44, maxHeight: 44),
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
