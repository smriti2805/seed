import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:seed/screens/result_screen.dart';
import 'package:seed/theme/theme_provider.dart';

class IdentificationScreen extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  IdentificationScreen({super.key});

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).canvasColor, // Adapt to theme
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Choose an option',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () async {
                    XFile? image =
                    await _picker.pickImage(source: ImageSource.camera);
                    if (image != null) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Result(image: File(image.path)),
                        ),
                      );
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  icon: Icon(Icons.camera_alt, color: Colors.white),
                  label: Text('Open Camera'),
                  style: myButtonStyle,
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () async {
                    XFile? image =
                    await _picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Result(image: File(image.path)),
                        ),
                      );
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  icon: Icon(Icons.photo_library, color: Colors.white),
                  label: Text('Choose from Gallery'),
                  style: myButtonStyle,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  var myButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.green,
    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
    textStyle: TextStyle(fontSize: 18),
  );

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Stack(
        children: <Widget>[
          // Image.asset(
          //   "assets/images/seed_background.jpeg",
          //   height: MediaQuery.of(context).size.height,
          //   width: MediaQuery.of(context).size.width,
          //   fit: BoxFit.cover,
          // ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _showImagePickerOptions(context),

                  child: Column(
                    children: [
                      Icon(Icons.camera_alt, size: 80, color: Colors.green),
                      SizedBox(height: 10),
                      Text(
                        'Touch to identify',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => _showImagePickerOptions(context),
                        style: myButtonStyle,
                        child: Text(
                          'Select Image',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
    );
  }
}


