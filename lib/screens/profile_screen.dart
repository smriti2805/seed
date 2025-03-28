import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seed/providers/auth_provider.dart';
import 'package:seed/screens/signin_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Center(
      child: authProvider.isLoggedIn
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text('Profile Screen', style: TextStyle(fontSize: 24)),
                      Text('Username: XYZ', style: TextStyle(fontSize: 24)),
                      Text('Email: xyz@email.com', style: TextStyle(fontSize: 24)),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      authProvider.logout();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Button color
                      // padding: EdgeInsets.symmetric(
                      //   horizontal: 30,
                      //   vertical: 15,
                      // ),
                    ),
                    child: Text('Log Out',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),),
                  ),
                ],
              ),
            )
          : Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('You are not logged in', style: TextStyle(fontSize: 24)),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                    );
                  },
                  child: Text('Sign In'),
                ),
                SizedBox(height: 20),
              ],
            )),
    );
  }
}
