import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:seed/screens/result_screen.dart';
import 'package:seed/services/storage_service.dart';
import 'package:seed/style/button_style.dart';

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
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                    XFile? image = await _picker.pickImage(source: ImageSource.camera);
                    if (image != null) {
                      final StorageService storageService = StorageService();
                      print("starting upload.............................................................................................................");
                      storageService.uploadFile(
                        image.path,
                        basename(image.path),
                      );
                      if (!context.mounted) return;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Result(image: File(image.path)),
                        ),
                      );
                    } else {
                      if (!context.mounted) return;
                      Navigator.pop(context);
                    }
                  },
                  icon: Icon(Icons.camera_alt, color: Colors.white),
                  label: Text('Open Camera',style: elevatedButtonTextStyle,),
                  style: elevatedButtonStyle,
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () async {
                    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      final StorageService storageService = StorageService();
                      print("starting upload.............................................................................................................");
                      storageService.uploadFile(
                        image.path,
                        basename(image.path),
                      );
                      if (!context.mounted) return;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Result(image: File(image.path)),
                        ),
                      );
                    } else {
                      if (!context.mounted) return;
                      Navigator.pop(context);
                    }
                  },
                  icon: Icon(Icons.photo_library, color: Colors.white),
                  label: Text('Choose from Gallery', style: elevatedButtonTextStyle,),
                  style: elevatedButtonStyle,
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
    // final themeProvider = Provider.of<ThemeProvider>(context);

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
                    Icon(Icons.camera_alt, size: 150, color: Colors.green),
                    SizedBox(height: 10),
                    Text(
                      'Touch to identify',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _showImagePickerOptions(context),
                      style: elevatedButtonStyle,
                      child: Text(
                        'Select Image',
                        style: elevatedButtonTextStyle.copyWith(color: Colors.black),
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
