import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seed/screens/seeds_screen.dart';
import 'package:seed/services/storage_service.dart';
import 'package:seed/widgets/app_drawer.dart';
import 'package:seed/screens/identifier_screen.dart';
import 'package:seed/screens/profile_screen.dart';
import 'package:seed/theme/theme_provider.dart';

class HomePage extends StatefulWidget {
  final int initialIndex;
  const HomePage({super.key, this.initialIndex = 0});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _currentIndex;

  final Map<int, GlobalKey<NavigatorState>> _navigatorKeys = {
    0: GlobalKey<NavigatorState>(),
    1: GlobalKey<NavigatorState>(),
    2: GlobalKey<NavigatorState>(),
  };

  final List<Widget> _screens = [
    IdentificationScreen(),
    SeedScreen(),
    ProfileScreen(),
  ];

  void _selectTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('SeedSight'),
        backgroundColor: Colors.green,
        actions: [
          // if (_currentIndex == 1 ) {
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              await clearSeedDataCache();
              // await getSeedData();
              setState(() {}); 
            },
          ),
          IconButton(
            icon: Icon(themeProvider.themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
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
            label: 'Seeds',
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
