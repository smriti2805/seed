import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class IdentificationScreen extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  IdentificationScreen({super.key});

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    // backgroundColor: Colors.green,
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: Text('Select Image'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

