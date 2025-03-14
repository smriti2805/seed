import 'package:flutter/material.dart';
import 'package:seed/screens/species_screen.dart';
import 'package:seed/widgets/app_drawer.dart';
import 'package:seed/screens/identifier_screen.dart';
import 'package:seed/screens/profile_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final Map<int, GlobalKey<NavigatorState>> _navigatorKeys = {
    0: GlobalKey<NavigatorState>(),
    1: GlobalKey<NavigatorState>(),
    2: GlobalKey<NavigatorState>(),
  };

  final List<Widget> _screens = [
    IdentificationScreen(),
    SpeciesScreen(),
    ProfileScreen(),
  ];

  void _selectTab(int index) {
    // if (index == 2) {
    //   // Handle Profile Login Restriction
    //   final authProvider = Provider.of<AuthProvider>(context, listen: false);
    //   if (!authProvider.isLoggedIn) {
    //     // Show login screen if user taps Profile and isn't logged in
    //     Navigator.of(context).push(
    //       MaterialPageRoute(builder: (context) => SignInScreen()),
    //     );
    //     return;
    //   }
    // }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SeedSight')),
      drawer: AppDrawer(onItemTap: _selectTab),
      body: Stack(
        children: _navigatorKeys.entries.map((entry) {
          return Offstage(
            offstage: _currentIndex != entry.key,
            child: Navigator(
              key: entry.value,
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => _screens[entry.key],
              ),
            ),
          );
        }).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _selectTab,
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
