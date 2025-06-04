import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/config/routes/route.dart';
import 'package:flutter_firebase_crud/config/themes/app_theme.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
      title: 'Evgreen Notes',
      theme: AppTheme.appTheme,
      routerConfig: screenrouter,
      debugShowCheckedModeBanner: false,
    );
  }
}