import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/Constants.dart';
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
      final textss = await OpenAIService.sendRequest(widget.Prompit);
      print(textss);
      genais = textss;
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
          Image.asset(
            "Assets/${widget.image}.png",
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
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.5,
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 14,
                        right: MediaQuery.of(context).size.width / 18,
                        bottom: MediaQuery.of(context).size.height / 15,
                        left: 10),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("Assets/Layer7.png"),
                          fit: BoxFit.fill),
                    ),
                    child: _isGenerating
                        ? Center(child: CircularProgressIndicator())
                        : SingleChildScrollView(
                            child: buildStyledText(genais),
                          )),
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
