import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seed/profile.dart';
import 'package:seed/species.dart';

import 'login.dart';

void main() {
  runApp(SeedSightApp());
}

class SeedSightApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    IdentificationScreen(),
    SpeciesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SeedSight'),
        actions: [
        ],
      ),
      drawer: Drawer(
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
            ListTile(
              leading: Icon(Icons.login),
              title: Text('Log In'),
              onTap: () {
                setState(() => _currentIndex = 2); // Switch to Login screen
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person_add),
              title: Text('Sign Up'),
              onTap: () {
                // Add sign-up navigation or logic here
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {
                // Add logout logic here
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.help_outline),
              title: Text('Help'),
              onTap: () {
                // Show help dialog or navigate to help screen
                Navigator.pop(context);
              },
            ),
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
      ),

      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Identification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Species',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class IdentificationScreen extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Wrap(
              children: [
                Text(
                  'Choose an option',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () async {
                    Navigator.pop(context);
                    await _picker.pickImage(source: ImageSource.camera);
                  },
                  icon: Icon(Icons.camera_alt, color: Colors.purple),
                  label: Text('Open Camera'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    Navigator.pop(context);
                    await _picker.pickImage(source: ImageSource.gallery);
                  },
                  icon: Icon(Icons.photo_library, color: Colors.blue),
                  label: Text('Choose from Gallery'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => _showImagePickerOptions(context),
            child: Column(
              children: [
                Icon(Icons.camera_alt, size: 80, color: Colors.green),
                Text('Touch to identify', style: TextStyle(fontSize: 18)),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _showImagePickerOptions(context),
                  child: Text('Select Image'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SpeciesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpeciesList(speciesData: demoSpeciesData,),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoggedIn = false;
  bool isSigningIn = false;
  String userName = '';
  String userEmail = '';
  String userLocation = '';

  void signIn(String name, String email, String location) {
    setState(() {
      isLoggedIn = true;
      isSigningIn = false;
      userName = name;
      userEmail = email;
      userLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn) {
      return UserProfile(
        userName: userName,
        userEmail: userEmail,
        userLocation: userLocation,
      );
    } else if (isSigningIn) {
      return LoginScreen(onSignIn: signIn);
    } else {
      return UnverifiedProfileScreen(
        onSignInPressed: () {
          setState(() {
            isSigningIn = true;
          });
        },
      );
    }
  }
}

class UnverifiedProfileScreen extends StatelessWidget {
  final VoidCallback onSignInPressed;

  UnverifiedProfileScreen({required this.onSignInPressed});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.account_circle, size: 100, color: Colors.blue),
          SizedBox(height: 20),
          Text('Sign In to view Profile', style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: onSignInPressed,
            child: Text('Sign In'),
          ),
        ],
      ),
    );
  }
}




// Let me know if you want me to add more features or refine the UI further! 🚀

