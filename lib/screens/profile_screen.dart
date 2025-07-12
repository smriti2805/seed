import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seed/providers/auth_provider.dart';
import 'package:seed/screens/signin_screen.dart';
import 'package:seed/style/button_style.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Center(
      child: authProvider.isLoggedIn
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(widthFactor: 1.5, child: Icon(Icons.person_outline_rounded, size: 200, color: Colors.green)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: ${authProvider.user?.displayName}', style: TextStyle(fontSize: 30)),
                      SizedBox(height: 20),
                      Text('Email: ${authProvider.user?.email}', style: TextStyle(fontSize: 30)),
                    ],
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      authProvider.logout();
                    },
                    style: elevatedButtonStyle,
                    child: Text(
                      'Log Out',
                      style: elevatedButtonTextStyle
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('You are not logged in', style: TextStyle(fontSize: 35)),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).push(
                      // Use rootNavigator: true
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                    );
                  },
                  style: elevatedButtonStyle,
                  child: Text('Sign In', style: elevatedButtonTextStyle),
                ),
                SizedBox(height: 20),
              ],
            )),
    );
  }
}
