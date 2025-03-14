import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seed/providers/auth_provider.dart';
import 'package:seed/screens/signin_screen.dart';
import 'package:seed/screens/signup_screen.dart';

class AppDrawer extends StatelessWidget {
  final Function(int) onItemTap;
  const AppDrawer({super.key, required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Text(
              'SeedSight Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          if (!authProvider.isLoggedIn) ...[
            ListTile(
              leading: Icon(Icons.login),
              title: Text('Log In'),
              onTap: () {
                Navigator.pop(context); // Close drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.person_add),
              title: Text('Sign Up'),
              onTap: () {
                Navigator.pop(context); // Close drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
            ),
          ],
          if (authProvider.isLoggedIn) ...[
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {
                authProvider.logout(); // Perform logout
                onItemTap(0); // Redirect to IdentificationScreen
                Navigator.pop(context); // Close drawer
              },
            ),
          ],
          Divider(),
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('Help'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.support_agent),
            title: Text('Support'),
            onTap: () {
              // Show support info or navigate to support screen
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
