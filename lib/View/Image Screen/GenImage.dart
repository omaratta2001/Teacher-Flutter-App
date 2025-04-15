// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stability_image_generation/stability_image_generation.dart';

import 'package:testapp/Constants.dart';
import 'package:testapp/Controller/GeminiImage.dart';
import 'package:testapp/Controller/GeneratingImage.dart';

class Genimage extends StatefulWidget {
  final String? prompt;
  final ImageAIStyle imageAIStyle;

  const Genimage({
    Key? key,
    required this.prompt,
    required this.imageAIStyle,
  }) : super(key: key);

  @override
  State<Genimage> createState() => _GenimageState();
}

class _GenimageState extends State<Genimage> {
  late Uint8List _image;
  Uint8List? _imageBytes;

  late Future<Uint8List> _imageFuture;
  late Future<Uint8List?> _imageFuture1;

  bool _isGenerating = true;
  bool _isLoading = true;
  bool _isGeneratingtext = true;
  Uint8List? imageBytes;
  bool loading = true;
  String? gentext = '';
  @override
  void initState() {
    super.initState();
    // Start generating image immediately when screen loads
    _generateImage();
  }

  Future<void> _generateImage() async {
    setState(() {
      loading = true;
    });
    GeminiImageService _imageGenerator = new GeminiImageService();

    print('heloo--' + widget.prompt!);
    final result = await _imageGenerator.generateImage1(widget.prompt!, "1:1");

    setState(() {
      imageBytes = result;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 75,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        title: Center(
            child: Text(
          "انشاء صورة",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        )),
        actions: [
          Image.asset(
            "Assets/Image.png",
            width: 65,
            height: 65,
            fit: BoxFit.cover,
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("Assets/background1.jpg"), fit: BoxFit.fill)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(width: 6, color: Color(0xff2a569a))),
                child: loading
                    ? Center(child: CircularProgressIndicator())
                    : imageBytes != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.memory(
                              imageBytes!,
                              fit: BoxFit.fill,
                            ),
                          )
                        : Center(child: Text("Failed to load image")),
              ),
              ElevatedButton(
                onPressed: () async {
                  final imageService = ImageGenerationService(
                    apiKey:
                        'sk-8O39BNVMc5JJf9ppRs2456ieucZtT3wzBgbGQ67zYj5ZfhPJ',
                    imageAIStyle: widget.imageAIStyle, // optional style
                  );

                  await imageService.saveImageWithPopupPicker(context, _image);
                },
                child: Text(
                  "تحميل",
                  style: GoogleFonts.amiri(fontSize: 30, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff2a569a),
                  elevation: 10,
                  padding:
                      EdgeInsets.only(left: 70, right: 70, top: 10, bottom: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
