import 'package:flutter/material.dart';
import 'package:seed/providers/auth_provider.dart';
import 'package:seed/home_page.dart';
import 'package:provider/provider.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        brightness: Brightness.light,
      ),
    );
  }
}
