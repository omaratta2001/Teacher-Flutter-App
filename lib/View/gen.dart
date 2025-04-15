import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stability_image_generation/stability_image_generation.dart';

class AiTextToImageGenerator extends StatefulWidget {
  const AiTextToImageGenerator({super.key});

  @override
  State<AiTextToImageGenerator> createState() => _AiTextToImageGeneratorState();
}

class _AiTextToImageGeneratorState extends State<AiTextToImageGenerator> {
  // Controller for the input field
  final TextEditingController _queryController = TextEditingController();
  // Instance of StabilityAI for image generation
  final StabilityAI _ai = StabilityAI();
  // API key for the AI service
  final String apiKey = 'sk-8O39BNVMc5JJf9ppRs2456ieucZtT3wzBgbGQ67zYj5ZfhPJ';
  // Set the style for the generated image
  final ImageAIStyle imageAIStyle = ImageAIStyle.digitalPainting;
  // Flag to check if images have been generated
  bool isItems = false;
  // Variable to store the generated image
  Uint8List? _generatedImage;

  // Function to generate an image based on the input query
  Future<Uint8List> _generate(String query) async {
    Uint8List image = await _ai.generateImage(
      apiKey: apiKey, // API key
      imageAIStyle: imageAIStyle, // Style for the image
      prompt: query, // The text prompt input by the user
    );
    return image; // Return the generated image as bytes
  }

  // Dispose method to clean up the controller when the widget is removed from the tree
  @override
  void dispose() {
    _queryController.dispose(); // Dispose of the controller
    super.dispose(); // Call the super class dispose method
  }

  // Function to save the generated image to the gallery
  Future<void> _saveImage(Uint8List imageBytes) async {
    // Request storage permission
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    // Save the image to the gallery
    final result = await ImageGallerySaverPlus.saveImage(imageBytes);

    if (result['isSuccess']) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image saved to gallery!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save image!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Text to Image",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: isItems // Check if images have been generated
                  ? FutureBuilder<Uint8List>(
                      future: _generate(
                          _queryController.text), // Call the generate function
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // Show loading indicator while waiting for the image
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasData) {
                          // If data is received, display the generated image
                          _generatedImage = snapshot.data!; // Store the image
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.memory(snapshot.data!),
                          );
                        } else {
                          return Container(); // Return an empty container if no data
                        }
                      },
                    )
                  : const Center(
                      child: Text(
                        'No any image generated yet', // Message if no images generated
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    String query = _queryController.text; // Get the input text
                    if (query.isNotEmpty) {
                      setState(() {
                        isItems =
                            true; // Set the flag to indicate images are being generated
                      });
                    } else {
                      // Log a message if the query is empty
                      if (kDebugMode) {
                        print('Query is empty !!');
                      }
                    }
                  },
                  child: const Text(
                    "إنشاء الصورة",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: _generatedImage != null
                      ? () => _saveImage(_generatedImage!)
                      : null, // Only enable if an image is generated
                  child: const Text('Save Image'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
