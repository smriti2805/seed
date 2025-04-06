// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:path/path.dart';
// // import 'package:image_picker/image_picker.dart'; // For picking images

// class StorageService {

//   final FirebaseStorage storage = FirebaseStorage.instance;

//   Future<void> uploadFile(String filePath, String fileName) async {
//     File file = File(filePath);
//     try {
//       await storage.ref('upload_images/$fileName').putFile(file);
//     } on FirebaseException catch (e) {
//       print(e);
//     }
//   }

//   // // Helper function to pick an image
//   // Future<String?> pickImage() async {
//   //   final ImagePicker _picker = ImagePicker();
//   //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

//   //   if (image != null) {
//   //     return image.path;
//   //   } else {
//   //     return null;
//   //   }
//   // }

//   Future<String> getImageUrl(String imagePath) async {
//     try {
//       final ref = FirebaseStorage.instance.ref(imagePath);
//       final imageUrl = await ref.getDownloadURL();
//       return imageUrl;
//     } catch (e) {
//       print("Error getting download URL: $e");
//       return "";
//       // Handle the error appropriately
//     }
//   }

//   Future<Map<String, String>> mapAllSeeds(String relativePath) async {
//     ListResult result = await storage.ref(relativePath).listAll();
//     Map<String, String> imageMap = {};
//     for (var item in result.items) {
//       final imageNameWithExtension = item.name;
//       final imageNameWithoutExtension = basenameWithoutExtension(imageNameWithExtension);
//       imageMap[imageNameWithoutExtension] = imageNameWithExtension;
//     }
//     return imageMap;
//   }
// }

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For encoding and decoding JSON

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

  Future<String> getImageUrl(String imagePath) async {
    try {
      final ref = FirebaseStorage.instance.ref(imagePath);
      final imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print("Error getting download URL: $e");
      return "";
    }
  }

  Future<Map<String, String>> mapAllSeeds(String relativePath) async {
    ListResult result = await storage.ref(relativePath).listAll();
    Map<String, String> imageMap = {};
    for (var item in result.items) {
      final imageNameWithExtension = item.name;
      final imageNameWithoutExtension = basenameWithoutExtension(imageNameWithExtension);
      imageMap[imageNameWithoutExtension] = imageNameWithExtension;
    }
    return imageMap;
  }
}

Future<List<Map<String, dynamic>>> getSeedData() async {
  final storageService = StorageService();
  final prefs = await SharedPreferences.getInstance();
  final cachedData = prefs.getString('seedData');

  if (cachedData != null) {
    // Data exists in cache, decode and return it.
    List<dynamic> decodedData = json.decode(cachedData);
    return decodedData.cast<Map<String, dynamic>>();
  } else {
    // Data not in cache, fetch from Firebase.
    final seedData = await storageService.mapAllSeeds('seeds/');
    List<Map<String, dynamic>> data = [];
    for (var entry in seedData.entries) {
      String imageName = entry.key;
      String imagePath = 'seeds/${entry.value}';
      String imageUrl = await storageService.getImageUrl(imagePath);

      // Download and save image locally.
      String localImagePath = await downloadAndSaveImage(imageUrl, imageName);

      var temp = {
        'imageUrl': localImagePath, // Use local path
        'imageName': imageName,
        'scientificName': 'Scientific Name of $imageName',
        'commonName': 'Common Name of $imageName',
        'family': 'Family of $imageName',
      };
      data.add(temp);
    }
    // Cache the data.
    prefs.setString('seedData', json.encode(data));
    return data;
  }
}

Future<String> downloadAndSaveImage(String imageUrl, String imageName) async {
  final httpClient = HttpClient();
  try {
    final request = await httpClient.getUrl(Uri.parse(imageUrl));
    final response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      final bytes = await response.fold<List<int>>([], (bytes, chunk) => bytes..addAll(chunk));
      final appDir = await getApplicationDocumentsDirectory();
      final file = File('${appDir.path}/$imageName.jpg');
      await file.writeAsBytes(bytes);
      return file.path;
    } else {
      return imageUrl; // Fallback to network URL
    }
  } catch (e) {
    print("Error downloading image: $e");
    return imageUrl; // Fallback to network URL
  } finally {
    httpClient.close();
  }
}

Future<List<Map<String, dynamic>>?> getCachedSeedData() async {
  final prefs = await SharedPreferences.getInstance();
  final cachedData = prefs.getString('seedData');

  if (cachedData != null) {
    List<dynamic> decodedData = json.decode(cachedData);
    return decodedData.cast<Map<String, dynamic>>();
  } else {
    return null; // Return null if no data is cached
  }
}

Future<void> clearSeedDataCache() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('seedData');
  await getSeedData();
}
