import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/Constants.dart';
import 'package:testapp/Controller/GeminiService.dart';
import 'package:testapp/Controller/OpenAIController.dart';
import 'package:testapp/Controller/SpeakToText.dart';
import 'package:testapp/View/Image%20Screen/GenImage.dart';
import 'package:testapp/View/Story%20Screen/Genstory.dart';
import 'package:stability_image_generation/stability_image_generation.dart';
import 'package:translator/translator.dart';

class Imagescreen extends StatefulWidget {
  const Imagescreen({super.key});

  @override
  State<Imagescreen> createState() => _ImagescreenState();
}

class _ImagescreenState extends State<Imagescreen> {
  late ImageAIStyle imageAIStyle;
  List<bool> _numberBoxSelections = List.generate(8, (index) => false);
  String? selectedValue; // This will store the selected radio button value
  String? selectedValue1; // This will store the selected radio button value
  final TextEditingController _controller = TextEditingController();
  SpeechService _speechService = SpeechService();
  bool _isListening = false;
  String Prompit = '';
  String _spokenText = '';
  bool? writing;
  @override
  void initState() {
    super.initState();
    _speechService.initSpeech();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Image.asset(
              "Assets/Image.png",
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
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Flexible(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context)
                    .size
                    .height, // now Column has a fixed height

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 9),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color(0xffe4f8f1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _numberBoxSelections =
                                          List.generate(8, (i) => i == 0);
                                      imageAIStyle = ImageAIStyle.moreDetails;
                                      selectedValue =
                                          'مع مراعاة ان يكون أسلوب الرسم حقيقى لاقصى درجة واكنه متصور بكاميرا فوتوغرافيا اى اقرب للواقع تماما';
                                    });
                                    print(_numberBoxSelections[0]);
                                  },
                                  child: buildOption(
                                      "حقيقية", _numberBoxSelections[0]),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _numberBoxSelections =
                                          List.generate(8, (i) => i == 1);
                                      imageAIStyle = ImageAIStyle.cartoon;

                                      selectedValue =
                                          'مع مراعاة ان يكون أسلوب الرسم كرتونى';
                                    });
                                  },
                                  child: buildOption(
                                      "كرتوني", _numberBoxSelections[1]),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _numberBoxSelections =
                                          List.generate(8, (i) => i == 2);
                                      imageAIStyle = ImageAIStyle.classicism;

                                      selectedValue =
                                          'مع مراعاة ان يكون أسلوب الرسم كرتونى 2D';
                                    });
                                  },
                                  child: buildOption(
                                      "2D", _numberBoxSelections[2]),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _numberBoxSelections =
                                          List.generate(8, (i) => i == 3);
                                      imageAIStyle = ImageAIStyle.render3D;

                                      selectedValue =
                                          'مع مراعاة ان يكون أسلوب الرسم كرتونى 3D';
                                    });
                                  },
                                  child: buildOption(
                                      "3D", _numberBoxSelections[3]),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _numberBoxSelections =
                                          List.generate(8, (i) => i == 4);
                                      imageAIStyle = ImageAIStyle.anime;

                                      selectedValue =
                                          'مع مراعاة ان يكون أسلوب الرسم انمى';
                                    });
                                  },
                                  child: buildOption(
                                      "أنيمي", _numberBoxSelections[4]),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _numberBoxSelections =
                                          List.generate(8, (i) => i == 5);
                                      imageAIStyle =
                                          ImageAIStyle.picassoPainter;

                                      selectedValue =
                                          'مع مراعاة ان يكون أسلوب الرسم شبه واقعي';
                                    });
                                  },
                                  child: buildOption(
                                      "شبه واقعي", _numberBoxSelections[5]),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _numberBoxSelections =
                                          List.generate(8, (i) => i == 6);
                                      imageAIStyle = ImageAIStyle.oilPainting;

                                      selectedValue =
                                          'مع مراعاة ان يكون أسلوب رسم يدوي';
                                    });
                                  },
                                  child: buildOption(
                                      "رسم يدوي", _numberBoxSelections[6]),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _numberBoxSelections =
                                          List.generate(8, (i) => i == 7);
                                      imageAIStyle = ImageAIStyle.pencilDrawing;

                                      selectedValue =
                                          'مع مراعاة ان يكون أسلوب الرسم اوت لاين بحيث يكون الرسمة مناسبة لوضعها في كتب التلوين';
                                    });
                                  },
                                  child: buildOption(
                                      "رسم للتلوين", _numberBoxSelections[7]),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25)),
                        child: Text(
                          "أكتب أو سجل فكرتك",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: MediaQuery.of(context).size.height / 4,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  width: 4, color: Color(0xff006cbe))),
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder
                                  .none, // Removes border when focused
                              enabledBorder: InputBorder
                                  .none, // Removes border when enabled
                              disabledBorder: InputBorder.none,
                            ),
                            maxLines: 5,
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(
                              -MediaQuery.of(context).size.width * 0.68,
                              MediaQuery.of(context).size.height / 14),
                          child: InkWell(
                            onTap: () async {
                              if (!_isListening) {
                                setState(() => _isListening = true);
                                await _speechService.startListening((text) {
                                  setState(() {
                                    print("object");
                                    _numberBoxSelections =
                                        List.generate(6, (index) => false);

                                    _controller.text = text;
                                  });
                                });
                              } else {
                                _speechService.stopListening();
                                setState(() {
                                  _isListening = false;
                                });
                              }
                            },
                            child: Image.asset(
                              "Assets/Mic1.png",
                              width: 100,
                              height: 100,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        int? age = await prefs.getInt('age');
                        Prompit = '';
                        if (_controller != '') {
                          writing = true;
                        }
                        if (writing != null) {
                          print(Prompit);

                          if (writing == true) {
                            Prompit = _controller.text + ' ' + selectedValue!;
                          } else {
                            Prompit = _spokenText + ' ' + selectedValue!;
                          }
                          GeminiTextService _gemin = new GeminiTextService();

                          String? gentext = await _gemin.generateText(Prompit +
                              ' translate this to english without saying anything before or after only say the translation');
                          final translator = GoogleTranslator();

                          var translation = await translator.translate(Prompit,
                              from: 'ar', to: 'en');
                          Prompit = translation.text;
                          print(Prompit);
                          print(gentext);

                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return Genimage(
                              prompt: 'generate an image about: $gentext',
                              imageAIStyle: imageAIStyle,
                            );
                          }));
                        }
                      },
                      child: Text(
                        "ارسال",
                        style: GoogleFonts.amiri(
                            fontSize: 30, color: Colors.white),
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
          ),
        ),
      ),
    );
  }
}

buildOption(String label, bool Isselected) {
  bool? isselcted = false;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        // Radio<String>(
        //   fillColor: WidgetStateProperty.resolveWith<Color>(
        //       (Set<WidgetState> states) {
        //     if (states.contains(WidgetState.disabled)) {
        //       return Colors.white.withOpacity(.32);
        //     }
        //     return Colors.white;
        //   }),

        //   value: value,
        //   groupValue: selectedValue,
        //   onChanged: (val) {
        //     selectedValue = val;
        //   },
        // ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: Isselected ? Color(0xfff53a2ae) : Color(0xffffffff),
                width: 4),
            color: Isselected ? Color(0xff53a2ae) : Colors.white,
          ),
          child: Isselected
              ? const Center(
                  child: Icon(
                    Icons.check,
                    color: Color(0xff53a2ae),
                    size: 20,
                    weight: 700,
                  ),
                )
              : null,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          label,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          maxLines: 1,
        ),
      ],
    ),
  );
}
