import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  UserProfile({
    required this.userName,
    required this.userEmail,
    required this.userLocation,
  });

  final String userName;
  final String userEmail;
  final String userLocation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Welcome, $userName!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text('Email: $userEmail', style: TextStyle(fontSize: 18)),
          Text('Location: $userLocation', style: TextStyle(fontSize: 18, color: Colors.grey)),
        ],
      ),
    );
  }
}
