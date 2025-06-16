// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:trackizer/common/App_Colors.dart';
import 'package:trackizer/pages/main_tab_screen.dart';
// import 'package:trackizer/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trackizer',
      theme: ThemeData(
        fontFamily: "Inter",
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          background: AppColors.gray80,
          primary: AppColors.primary,
          primaryContainer: AppColors.gray60,
          secondary: AppColors.secondary,
        ),
        useMaterial3: false,
      ),
      home: MainTabScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

