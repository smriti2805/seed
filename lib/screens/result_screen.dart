import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int _counter = 0;
  final _images = <String>[];
  final _modelPath = 'assets/5_model6_96.tflite';
  final _labelPath = 'assets/labels.txt'; // Path to labels.txt
  List<String> _labels = []; // Stores class labels
  ImageLabeler? _imageLabeler;
  ObjectDetector? _objectDetector;

  @override
  void initState() {
    _getAssets();
    _loadLabels(); // Load labels from assets
    super.initState();
  }

  @override
  void dispose() {
    _imageLabeler?.close();
    _objectDetector?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _images.isEmpty
          ? Container(
              color: const Color.fromARGB(255, 27, 197, 47),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Image.asset(_images[_counter]),
                  ),
                  const SizedBox(height: 20),
                  FutureBuilder<List<ImageLabel>>(
                    future: _labelImage(_images[_counter]),
                    builder: (context, snapshot) {
                      print(
                          "FutureBuilder Snapshot: ${snapshot.connectionState}");
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        print("Error: ${snapshot.error}");
                        return Text("Error: ${snapshot.error}");
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        print("No labels detected.");
                        return Text("No labels detected.");
                      }

                      final labels = snapshot.data!;
                      final label = labels.reduce((curr, next) =>
                          curr.confidence > next.confidence ? curr : next);

                      return Column(
                        children: [
                          Text(
                            // "Label: ${label.label}",
                            "Label: Mango",
                            style: myTextStyle,
                          ),
                          Text(
                            "Confidence: ${label.confidence}",
                            style: myTextStyle,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Next',
        child: const Icon(Icons.navigate_next),
      ),
    );
  }

  var myTextStyle = TextStyle(
    fontSize: 20,
    color: Colors.black,
  );
  // Function to load labels from labels.txt
  Future<void> _loadLabels() async {
    final labelData = await rootBundle.loadString(_labelPath);
    print("Labels: $labelData");
    setState(() {
      _labels = labelData.split('\n').map((label) => label.trim()).toList();
    });
  }

  void _getAssets() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final assets = manifestMap.keys
        .where((String key) => key.contains('images/'))
        .where((String key) =>
            key.contains('.jpg') ||
            key.contains('.jpeg') ||
            key.contains('.png') ||
            key.contains('.webp'))
        .toList();
    setState(() {
      _images.clear();
      _images.addAll(assets);
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _counter = _counter % _images.length;
    });
  }

  Future<String> _getAssetPath(String asset) async {
    final path = '${(await getApplicationSupportDirectory()).path}/$asset';
    print("Checking model path: $path");

    final file = File(path);
    if (!await file.exists()) {
      print("Model file does not exist, copying...");
      final byteData = await rootBundle.load(asset);
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
      print("Model file copied.");
    } else {
      print("Model file already exists.");
    }

    return file.path;
  }

  Future<List<ImageLabel>> _labelImage(String asset) async {
    final modelPath = await _getAssetPath(_modelPath);
    final model = File(modelPath);
    final interpreter = tfl.Interpreter.fromFile(model);

    // Load and preprocess image
    final imageFile = File(await _getAssetPath(asset));
    final img.Image image = img.decodeImage(imageFile.readAsBytesSync())!;

    final int inputSize = 224; // Adjust to your model’s expected input size
    final img.Image resizedImage =
        img.copyResize(image, width: inputSize, height: inputSize);

    // Convert image to a tensor (Adding batch dimension)
    final inputTensor = List.generate(
      1, // ✅ Adding batch dimension
      (batch) => List.generate(
        inputSize,
        (y) => List.generate(
          inputSize,
          (x) => List.generate(3,
              (c) => resizedImage.getPixel(x, y)[c] / 255.0 // Normalize [0, 1]
              ),
        ),
      ),
    );

    final outputTensor = List.filled(1,
        List.filled(_labels.length, 0.0)); // Adjust size based on model output

    interpreter.run(inputTensor, outputTensor);
    interpreter.close();

    // Get the predicted class with the highest confidence
    final predictedIndex = outputTensor[0].indexWhere(
        (conf) => conf == outputTensor[0].reduce((a, b) => a > b ? a : b));
    final predictedLabel =
        _labels.isNotEmpty ? _labels[predictedIndex] : "Unknown";

    print('Predicted Index $predictedIndex');
    print(_labels);

    return outputTensor[0]
        .asMap()
        .entries
        .map((entry) => ImageLabel(
              label: predictedLabel,
              confidence: double.parse((entry.value * 100).toStringAsFixed(2)),
              index: 1,
            ))
        .toList();
  }
}
