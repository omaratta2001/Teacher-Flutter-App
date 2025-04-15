import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testapp/Constants.dart';
import 'package:testapp/Controller/GeminiService.dart';
import 'package:testapp/Controller/OpenAIController.dart';
import 'package:testapp/Controller/spans.dart';
import 'package:testapp/View/Story%20Screen/GenImageStory.dart';
import 'package:translator/translator.dart';

class Genstory extends StatefulWidget {
  final String Prompit;
  const Genstory({super.key, required this.Prompit});

  @override
  State<Genstory> createState() => _GenstoryState();
}

class _GenstoryState extends State<Genstory> {
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
      GeminiTextService _gemin = new GeminiTextService();

      var textss = await _gemin.generateText(widget.Prompit);
      print(textss);
      genais = textss!;
      textss = await _gemin
          .generateText(genais + " أريد من العنوان بدون أي مقدمات العنوان فقط");
      title = textss!;
      print(title);
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
          "تأليف قصة",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Image.asset(
              "Assets/story.png",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      GeminiTextService _gemin = new GeminiTextService();

                      final translator = GoogleTranslator();

                      var translation = await translator
                          .translate(widget.Prompit, from: 'ar', to: 'en');
                      print('generate image ' + translation.text);
                      var gentext = await _gemin.generateText(genais +
                          '\n make this story as imagegen3 short prompt  generation write it in english without saying anything or after only prompit ');
                      print(gentext);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return Genimagestory(
                          prompt: gentext!,
                        );
                      }));
                    },
                    child: Text(
                      "صورة معبرة",
                      style:
                          GoogleFonts.amiri(fontSize: 30, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff2a569a),
                      elevation: 10,
                      fixedSize: Size(150, 60),
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _copyToClipboard(genais);
                    },
                    child: Text(
                      "نسخ",
                      style:
                          GoogleFonts.amiri(fontSize: 30, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff2a569a),
                      elevation: 10,
                      fixedSize: Size(150, 60),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
