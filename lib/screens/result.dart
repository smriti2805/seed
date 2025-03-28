import 'dart:io';

import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final File image;
  const Result({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.file(image, width: 200, height: 200, fit: BoxFit.cover),
          Text(
            "Result Screen",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
