import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/Constants.dart';
import 'package:testapp/Controller/OpenAIController.dart';
import 'package:testapp/Controller/SpeakToText.dart';
import 'package:testapp/View/Activity%20Screen/gentextactivityScreen.dart';
import 'package:testapp/View/Story%20Screen/GenImageStory.dart';
import 'package:testapp/View/Story%20Screen/Genstory.dart';
import 'package:translator/translator.dart';

class Poemscreen extends StatefulWidget {
  const Poemscreen({super.key});

  @override
  State<Poemscreen> createState() => _PoemscreenState();
}

class _PoemscreenState extends State<Poemscreen> {
  List<bool> _numberBoxSelections = List.generate(8, (index) => false);

  String? selectedValue; // This will store the selected radio button value
  String? selectedValue1; // This will store the selected radio button value
  final TextEditingController _controller = TextEditingController();
  SpeechService _speechService = SpeechService();
  bool _isListening = false;
  String Prompit = '';
  String _spokenText = '';
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
          "تأليف نشيد",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Image.asset(
              "Assets/poem.png",
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
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context)
                  .size
                  .height, // now Column has a fixed height

              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 11),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: lightblue,
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
                                    selectedValue =
                                        ' سنوات يتناول موضوع عن الحيوانات ';
                                    _controller.text = "";
                                  });
                                  print(_numberBoxSelections[0]);
                                },
                                child: buildOption(
                                    "الحيوانات", _numberBoxSelections[0]),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _numberBoxSelections =
                                        List.generate(8, (i) => i == 1);

                                    selectedValue =
                                        ' سنوات يتناول موضوع عن الطيور ';
                                    _controller.text = "";
                                  });
                                },
                                child: buildOption(
                                    "الطيور", _numberBoxSelections[1]),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _numberBoxSelections =
                                        List.generate(8, (i) => i == 2);

                                    selectedValue =
                                        ' سنوات يتناول موضوع عن الأسماك ';
                                    _controller.text = "";
                                  });
                                },
                                child: buildOption(
                                    "الأسماك", _numberBoxSelections[2]),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _numberBoxSelections =
                                        List.generate(8, (i) => i == 3);

                                    selectedValue =
                                        ' سنوات يتناول موضوع عن النباتات يعنى نباتات او أشجار او خضروات او فواكه ';
                                    _controller.text = "";
                                  });
                                },
                                child: buildOption(
                                    "الناتات", _numberBoxSelections[3]),
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

                                    selectedValue =
                                        ' سنوات يتناول موضوع عن الحروف الهجائية ';
                                    _controller.text = "";
                                  });
                                },
                                child: buildOption(
                                    "الحروف", _numberBoxSelections[4]),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _numberBoxSelections =
                                        List.generate(8, (i) => i == 5);

                                    selectedValue =
                                        ' سنوات يتناول موضوع عن الأرقام ';
                                    _controller.text = "";
                                  });
                                },
                                child: buildOption(
                                    "الأرقام", _numberBoxSelections[5]),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _numberBoxSelections =
                                        List.generate(8, (i) => i == 6);

                                    selectedValue =
                                        ' سنوات يتناول موضوع عن الألوان ';
                                    _controller.text = "";
                                  });
                                },
                                child: buildOption(
                                    "الألوان", _numberBoxSelections[6]),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _numberBoxSelections =
                                        List.generate(8, (i) => i == 7);

                                    selectedValue =
                                        ' سنوات يتناول موضوع عن الفراشات ';
                                    _controller.text = "";
                                  });
                                },
                                child: buildOption(
                                    "الفراشات", _numberBoxSelections[7]),
                              )
                            ],
                          ),
                        ],
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
                            onTap: () {
                              _numberBoxSelections =
                                  List.generate(8, (index) => false);
                            },
                            maxLines: 5,
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(
                              -MediaQuery.of(context).size.width * 0.68,
                              MediaQuery.of(context).size.height / 14),
                          child: InkWell(
                            onTap: () async {
                              setState(() {
                                _controller.text = "";
                              });
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
                        Prompit =
                            'اعتبر نفسك متخصص في تأليف أناشيد الأطفال ولديك المهارة في تأليف أناشيد مناسبة لأطفال الروضة، قم بتأليف نشيد لأطفال الروضة من سن ' +
                                age.toString() +
                                selectedValue! +
                                'بحيث يتوافر في النشيد الكلمات البسيطة المناسبة للسن وان يتوافر في النشيد القافية والسجع في نهاية الابيات مع مراعاة ان تكون الكلمات بالعامية المصرية وان يكون عدد الكلمات المكونة لكل بيت ما بين 3 الى 4 كلمات فقط' +
                                "أبدا بعنوان النشيد مباشرا  بدون أي مقدمات";

                        if (_controller.text != "") {
                          Prompit =
                              'اعتبر نفسك متخصص في تأليف أناشيد الأطفال ولديك المهارة في تأليف أناشيد مناسبة لأطفال الروضة، قم بتأليف نشيد لأطفال الروضة من سن ' +
                                  age.toString() +
                                  _controller.text +
                                  'بحيث يتوافر في النشيد الكلمات البسيطة المناسبة للسن وان يتوافر في النشيد القافية والسجع في نهاية الابيات مع مراعاة ان تكون الكلمات بالعامية المصرية وان يكون عدد الكلمات المكونة لكل بيت ما بين 3 الى 4 كلمات فقط' +
                                  " أبدا بعنوان النشيد مباشرا بدون أي مقدمات";
                        }
                        print(Prompit);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return Gentextactivityscreen(
                            Prompit: Prompit,
                            titlename: 'تأليف نشيد',
                            image: 'poem',
                          );
                        }));
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
