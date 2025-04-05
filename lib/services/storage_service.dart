import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart'; // For picking images

class StorageService {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);

    try {
      await storage.ref('upload_images/$fileName').putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  // // Helper function to pick an image
  // Future<String?> pickImage() async {
  //   final ImagePicker _picker = ImagePicker();
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

  //   if (image != null) {
  //     return image.path;
  //   } else {
  //     return null;
  //   }
  // }
  
  Future<String?> getImageUrl(String imageUrl,String imagePath) async {
    try {
      final ref = FirebaseStorage.instance.ref(imagePath);
      imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print("Error getting download URL: $e");
      return null; 
      // Handle the error appropriately
    }
  }
}


