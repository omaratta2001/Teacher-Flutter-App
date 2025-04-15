import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/Constants.dart';
import 'package:testapp/Controller/GeminiService.dart';
import 'package:testapp/Controller/OpenAIController.dart';
import 'package:testapp/Controller/spans.dart';
import 'package:testapp/View/Story%20Screen/GenImageStory.dart';
import 'package:translator/translator.dart';

class Gentextactivityscreen extends StatefulWidget {
  final String Prompit;
  final String titlename;
  final String image;

  const Gentextactivityscreen(
      {super.key,
      required this.Prompit,
      required this.titlename,
      required this.image});

  @override
  State<Gentextactivityscreen> createState() => _GentextactivityscreenState();
}

class _GentextactivityscreenState extends State<Gentextactivityscreen> {
  OpenAIService ai = OpenAIService();
  late Future<void> genai;
  bool _isGenerating = true;
  String title = "";

  String genais = '';
  @override
  void initState() {
    super.initState();
    genai = _generatetext();
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copied to clipboard')),
    );
  }

  Future<void> _generatetext() async {
    try {
      GeminiTextService gen = GeminiTextService();
      var textss = await gen.generateText(widget.Prompit);

      print(textss);
      genais = textss!;
      textss = await gen
          .generateText(genais + " أريد من العنوان بدون أي مقدمات العنوان فقط");
      title = textss!;
      setState(() => _isGenerating = false);
      return genai;
    } catch (e) {
      setState(() => _isGenerating = false);
      throw e; // Re-throw to be caught by FutureBuilder
    }
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
          widget.titlename,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Image.asset(
              "Assets/${widget.image}.png",
              width: 65,
              height: 65,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("Assets/background1.jpg"), fit: BoxFit.fill)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 80,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Stack(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 1.5,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(width: 7, color: Color(0xff2a569a)),
                            borderRadius: BorderRadius.circular(45)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 22,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Color(0xff2a569a),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(35))),
                              child: Center(
                                  child: Text(
                                title,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                            ),
                            _isGenerating
                                ? Expanded(
                                    child: Center(
                                        child: CircularProgressIndicator()))
                                : Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: SingleChildScrollView(
                                        child: buildStyledText(genais, 18),
                                      ),
                                    ),
                                  ),
                          ],
                        )),
                    Transform.translate(
                      offset:
                          Offset(-MediaQuery.of(context).size.width / 1.3, -25),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            title = "";
                            _isGenerating = true;
                            genai = _generatetext();
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: lightGreen, shape: BoxShape.circle),
                          child: Icon(
                            Icons.refresh,
                            color: Color(0xff2a569a),
                            size: 60,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  _copyToClipboard(genais);
                },
                child: Text(
                  "نسخ",
                  style: GoogleFonts.amiri(fontSize: 30, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff2a569a),
                  elevation: 10,
                  padding: EdgeInsets.only(
                      left: 100, right: 100, top: 10, bottom: 10),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
