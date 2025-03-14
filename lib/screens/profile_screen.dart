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
              children: [
                Text('Profile Screen', style: TextStyle(fontSize: 24)),
                ElevatedButton(
                  onPressed: () {
                    authProvider.logout();
                  },
                  child: Text('Log Out'),
                ),
                SizedBox(height: 20),
              ],
            ),
          )
          : Center(child: Column(
            children: [
              Text('You are not logged in', style: TextStyle(fontSize: 24)),
              
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

