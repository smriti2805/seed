import 'package:flutter/material.dart';
import 'package:seed/utilities/auth_provider.dart';
import 'package:seed/home_page.dart';
import 'package:provider/provider.dart';
import 'package:seed/utilities/themes.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: SeedSightApp(),
    ),
  );
}

class SeedSightApp extends StatelessWidget {
  const SeedSightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SeedSight',
      home: HomePage(),
      theme: AppTheme.lightTheme,
    );
  }
}
