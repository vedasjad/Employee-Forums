import 'package:employee_forums/common/themes/themes.dart';
import 'package:flutter/material.dart';

import 'features/main/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.light,
      home: const MainScreen(),
    );
  }
}
