import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ImageDisplay extends StatefulWidget {
  final String imagePath; // e.g., 'images/my-image.jpg'

  const ImageDisplay({super.key, required this.imagePath});

  @override
  ImageDisplayState createState() => ImageDisplayState();
}

class ImageDisplayState extends State<ImageDisplay> {
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    getImageUrl();
  }

  Future<void> getImageUrl() async {
    try {
      final ref = FirebaseStorage.instance.ref(widget.imagePath);
      imageUrl = await ref.getDownloadURL();
      setState(() {}); // Trigger a rebuild to display the image
    } catch (e) {
      print("Error getting download URL: $e");
      // Handle the error appropriately
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image from Firebase Storage'),
      ),
      body: Center(
        child: imageUrl != null
            ? Image.network(imageUrl!)
            : CircularProgressIndicator(), // Show a loading indicator while fetching
      ),
    );
  }
}
