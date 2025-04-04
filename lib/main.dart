import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seed/providers/auth_provider.dart';
import 'package:seed/theme/theme_provider.dart';
import 'package:seed/home_page.dart';
import 'package:seed/theme/theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(options: FirebaseOptions(  apiKey: "AIzaSyAbkYNFnK9PN9cEE4ZBJxz8MZRYxU-dAAc",
        authDomain: "seed-git.firebaseapp.com",
        projectId: "seed-git",
        storageBucket: "seed-git.firebasestorage.app",
        messagingSenderId: "1092252675503",
        appId: "1:1092252675503:web:d84da76e69e67e8150535a"));
  }else{
    await Firebase.initializeApp();
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: SeedSightApp(),
    ),
  );
}

class SeedSightApp extends StatelessWidget {
  const SeedSightApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SeedSight',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeProvider.themeMode, // Apply selected theme
      home: HomePage(),
    );
  }
}


