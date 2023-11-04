import 'package:employee_forums/common/themes/themes.dart';
import 'package:employee_forums/features/home/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/home/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppThemes.light,
        home: const HomeScreen(),
      ),
    );
  }
}
