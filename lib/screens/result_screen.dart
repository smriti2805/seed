import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class Result extends StatelessWidget {
  final File image;
  const Result({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Prediction Result")),
      body: FutureBuilder<Map<String, dynamic>>(
        future: sendRequest(image), // Call async function
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("No data received"));
          }

          var response = snapshot.data!;
          var imgWidth = MediaQuery.of(context).size.width * 0.8;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.file(image, width: imgWidth, height: imgWidth, fit: BoxFit.cover),
                SizedBox(height: 20),
                Text(
                  "Result: ${response['class']}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Confidence: ${response['confidence']}%",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Future<Map<String, dynamic>> sendRequest(File img) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse('https://predict-seed-487539831414.asia-south2.run.app'),
  );

  // Add the file
  request.files.add(
    await http.MultipartFile.fromPath(
      'file', // Field name expected by the server
      img.path,
      filename: basename(img.path),
    ),
  );

  // Send request and get response
  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);

  // print("Response status: ${response.statusCode}");
  // print("Response body: ${response.body}");
  return json.decode(response.body);
}
