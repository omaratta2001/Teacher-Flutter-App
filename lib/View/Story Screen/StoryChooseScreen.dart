import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/Constants.dart';
import 'package:testapp/Controller/SpeakToText.dart';
import 'package:testapp/View/Story%20Screen/Genstory.dart';

class Storychoosescreen extends StatefulWidget {
  @override
  State<Storychoosescreen> createState() => _StorychoosescreenState();
}

class _StorychoosescreenState extends State<Storychoosescreen> {
  List<bool> _numberBoxSelections = List.generate(6, (index) => false);
  List<bool> _numberBoxSelections1 = List.generate(2, (index) => false);

  bool Isslected1 = false;
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
          "تأليف قصة",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        )),
        actions: [
          Image.asset(
            "Assets/story.png",
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
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Remove this
              children: [
                SizedBox(
                  height: 110,
                ),
                // Container(
                //   padding: EdgeInsets.all(15),
                //   decoration: BoxDecoration(
                //     color: Color(0xff5bf7e1),
                //   ),
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //         children: [
                //           InkWell(
                //             onTap: () {
                //               setState(() {
                //                 selectedValue =
                //                     'المهارات اللغوية او أحد القواعد اللغوية';
                //               });
                //             },
                //             child: Row(
                //               children: [
                //                 Radio<String>(
                //                   value: 'المهارات اللغوية او أحد القواعد اللغوية',
                //                   groupValue: selectedValue,
                //                   onChanged: (value) {
                //                     setState(() {
                //                       selectedValue = value;
                //                     });
                //                   },
                //                 ),
                //                 Text(
                //                   "قصة لغوية",
                //                   overflow: TextOverflow.ellipsis,
                //                   style: TextStyle(
                //                       fontSize: 20, fontWeight: FontWeight.bold),
                //                 ),
                //               ],
                //             ),
                //           ),
                //           InkWell(
                //             onTap: () {
                //               setState(() {
                //                 selectedValue = 'المفاهيم والقيم الاجتماعية ';
                //               });
                //             },
                //             child: Row(
                //               children: [
                //                 Radio<String>(
                //                   value: 'المفاهيم والقيم الاجتماعية ',
                //                   groupValue: selectedValue,
                //                   onChanged: (value) {
                //                     setState(() {
                //                       selectedValue = value;
                //                     });
                //                   },
                //                 ),
                //                 Text(
                //                   "قصة إجتماعية",
                //                   overflow: TextOverflow.ellipsis,
                //                   style: TextStyle(
                //                       fontSize: 20, fontWeight: FontWeight.bold),
                //                 )
                //               ],
                //             ),
                //           ),
                //           InkWell(
                //             onTap: () {
                //               setState(() {
                //                 selectedValue = 'المفاهيم العلمية ';
                //               });
                //             },
                //             child: Row(
                //               children: [
                //                 Radio<String>(
                //                   value: 'المفاهيم العلمية ',
                //                   groupValue: selectedValue,
                //                   onChanged: (value) {
                //                     setState(() {
                //                       selectedValue = value;
                //                     });
                //                   },
                //                 ),
                //                 Text(
                //                   "قصة علمية",
                //                   style: TextStyle(
                //                       fontSize: 20, fontWeight: FontWeight.bold),
                //                 )
                //               ],
                //             ),
                //           ),
                //         ],
                //       ),
                //       Column(
                //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           InkWell(
                //             onTap: () {
                //               setState(() {
                //                 selectedValue = 'المفاهيم الصحية والوعي الصحي ';
                //               });
                //             },
                //             child: Row(
                //               children: [
                //                 Radio<String>(
                //                   value: 'المفاهيم الصحية والوعي الصحي ',
                //                   groupValue: selectedValue,
                //                   onChanged: (value) {
                //                     setState(() {
                //                       selectedValue = value;
                //                     });
                //                   },
                //                 ),
                //                 Text(
                //                   "قصة صحية",
                //                   style: TextStyle(
                //                       fontSize: 20, fontWeight: FontWeight.bold),
                //                 )
                //               ],
                //             ),
                //           ),
                //           InkWell(
                //             onTap: () {
                //               setState(() {
                //                 selectedValue =
                //                     'مهارات الرياضيات او العمليات الرياضية ';
                //               });
                //             },
                //             child: Row(
                //               children: [
                //                 Radio<String>(
                //                   value: 'مهارات الرياضيات او العمليات الرياضية ',
                //                   groupValue: selectedValue,
                //                   onChanged: (value) {
                //                     setState(() {
                //                       selectedValue = value;
                //                     });
                //                   },
                //                 ),
                //                 Text(
                //                   "قصة رياضية",
                //                   style: TextStyle(
                //                       fontSize: 20, fontWeight: FontWeight.bold),
                //                 )
                //               ],
                //             ),
                //           ),
                //           InkWell(
                //             onTap: () {
                //               setState(() {
                //                 selectedValue =
                //                     'المفاهيم البيئية والوعى البيئة والمحافظة على البيئة ';
                //               });
                //             },
                //             child: Row(
                //               children: [
                //                 Radio<String>(
                //                   value:
                //                       'المفاهيم البيئية والوعى البيئة والمحافظة على البيئة ',
                //                   groupValue: selectedValue,
                //                   onChanged: (value) {
                //                     setState(() {
                //                       selectedValue = value;
                //                     });
                //                   },
                //                 ),
                //                 Text(
                //                   "قصة بيئية",
                //                   style: TextStyle(
                //                       fontSize: 20, fontWeight: FontWeight.bold),
                //                 )
                //               ],
                //             ),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),

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
                                      List.generate(6, (i) => i == 0);
                                  selectedValue =
                                      'المهارات اللغوية او أحد القواعد اللغوية';
                                  _controller.text = '';
                                });
                                print(_numberBoxSelections[0]);
                              },
                              child: buildOption(
                                  "قصة لغوية", _numberBoxSelections[0]),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _numberBoxSelections =
                                      List.generate(6, (i) => i == 1);
                                  selectedValue = 'المفاهيم والقيم الاجتماعية ';
                                  _controller.text = '';
                                });
                              },
                              child: buildOption(
                                  "قصة إجتماعية", _numberBoxSelections[1]),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _numberBoxSelections =
                                      List.generate(6, (i) => i == 2);
                                  selectedValue = 'المفاهيم العلمية ';
                                  _controller.text = '';
                                });
                              },
                              child: buildOption(
                                  "قصة علمية", _numberBoxSelections[2]),
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
                                      List.generate(6, (i) => i == 3);
                                  selectedValue =
                                      'المفاهيم الصحية والوعي الصحي ';
                                  _controller.text = '';
                                });
                              },
                              child: buildOption(
                                  "قصة صحية", _numberBoxSelections[3]),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _numberBoxSelections =
                                      List.generate(6, (i) => i == 4);
                                  selectedValue =
                                      'مهارات الرياضيات او العمليات الرياضية ';
                                  _controller.text = '';
                                });
                              },
                              child: buildOption(
                                  "قصة رياضية", _numberBoxSelections[4]),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _numberBoxSelections =
                                      List.generate(6, (i) => i == 5);
                                  selectedValue =
                                      'المفاهيم البيئية والوعى البيئة والمحافظة على البيئة ';
                                  _controller.text = '';
                                });
                              },
                              child: buildOption(
                                  "قصة بيئية", _numberBoxSelections[5]),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20), // Add space
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color(0xfffbf8da),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedValue1 =
                                  ' مع مراعاة شخصيات القصة تكون شخصيات بشرية';
                              _numberBoxSelections1 =
                                  List.generate(2, (i) => i == 0);
                              _controller.text = '';
                            });
                          },
                          child: buildOption("بشرية", _numberBoxSelections1[0]),
                          // child: Row(
                          //   children: [
                          //     // Radio<String>(
                          //     //   value:
                          //     //       ' مع مراعاة شخصيات القصة تكون شخصيات بشرية',
                          //     //   groupValue: selectedValue1,
                          //     //   onChanged: (value) {
                          //     //     setState(() {
                          //     //       selectedValue1 = value;
                          //     //     });
                          //     //   },
                          //     // ),
                          //     buildOption("بشرية", _numberBoxSelections1[0]),
                          //     Text(
                          //       "بشرية",
                          //       style: TextStyle(
                          //           fontSize: 20,
                          //           fontWeight: FontWeight.bold),
                          //     ),
                          //   ],
                          // ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedValue1 = ' ';
                              _numberBoxSelections1 =
                                  List.generate(2, (i) => i == 1);
                              _controller.text = '';
                            });
                          },
                          child: buildOption(
                              "غير بشرية", _numberBoxSelections1[1]),
                          //       child: Row(
                          //         children: [
                          //           Radio<String>(
                          //             value: ' ',
                          //             groupValue: selectedValue1,
                          //             onChanged: (value) {
                          //               setState(() {
                          //                 selectedValue1 = value;
                          //               });
                          //             },
                          //           ),
                          //           Text(
                          //             "غير بشرية",
                          //             style: TextStyle(
                          //                 fontSize: 20,
                          //                 fontWeight: FontWeight.bold),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 30),
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)),
                    child: Text(
                      "أكتب أو سجل فكرتك",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 20), // Add space
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: MediaQuery.of(context).size.height / 4,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border:
                              Border.all(width: 4, color: Color(0xff006cbe))),
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder:
                              InputBorder.none, // Removes border when focused
                          enabledBorder:
                              InputBorder.none, // Removes border when enabled
                          disabledBorder: InputBorder.none,
                        ),
                        maxLines: 5,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(-MediaQuery.of(context).size.width * 0.68,
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
                                _numberBoxSelections1 =
                                    List.generate(2, (index) => false);
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
                // SizedBox(height: 30), // Add space
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     Center(
                //       child: Text(
                //         "سجل\nفكرتك",
                //         style: TextStyle(
                //             fontSize: 25, fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //     Stack(
                //       children: [
                //         Container(
                //           width: MediaQuery.of(context).size.width / 1.5,
                //           height: MediaQuery.of(context).size.height / 8,
                //           padding: EdgeInsets.all(11),
                //           decoration: BoxDecoration(
                //               color: Colors.white,
                //               borderRadius: BorderRadius.circular(15),
                //               border: Border.all(
                //                   width: 4, color: Color(0xff006cbe))),
                //           child: Text(
                //             _spokenText!,
                //             style: TextStyle(fontSize: 20),
                //           ),
                //         ),
                //         Transform.translate(
                //           offset: Offset(
                //               -MediaQuery.of(context).size.width * 0.57,
                //               MediaQuery.of(context).size.height / 100),
                //           child: InkWell(
                //             onTap: () async {
                //               if (!_isListening) {
                //                 setState(() => _isListening = true);
                //                 await _speechService.startListening((text) {
                //                   setState(() {
                //                     print("object");
                //                     _spokenText = text;
                //                   });
                //                 });
                //               } else {
                //                 _speechService.stopListening();
                //                 setState(() {
                //                   _isListening = false;
                //                 });
                //               }
                //             },
                //             child: Image.asset(
                //               "Assets/Mic.png",
                //               width: 100,
                //               height: 100,
                //             ),
                //           ),
                //         ),
                //       ],
                //     ), // Closes Stack
                //   ],
                // ),
                SizedBox(height: 10), // Add space before button
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      int? age = await prefs.getInt('age');
                      Prompit =
                          'اعتبر نفسك متخصص في تأليف قصص الأطفال ولديك المهارة في كتابة القصة بحرفية مع توافر حبكه درامية بكل قصة، قم بتأليف قصة لأطفال الروضة من سن ' +
                              age.toString() +
                              'سنوات لتنمية أحد ' +
                              selectedValue! +
                              'المناسبة لأطفال الروضة بحيث يتوافر في القصة عنوان جذاب ومعبر عن القصة وعدد كلمات ما بين 150 الى 200 كلمة ويتوافر بالقصة الحبكة الدرامية والنهاية المناسبة ' +
                              selectedValue1! +
                              "إبدا بالعنوان مباشرا";
                      if (_controller.text != "") {
                        Prompit =
                            'اعتبر نفسك متخصص في تأليف قصص الأطفال ولديك المهارة في كتابة القصة بحرفية مع توافر حبكه درامية بكل قصة، قم بتأليف قصة لأطفال الروضة من سن ' +
                                age.toString() +
                                'سنوات لتنمية أحد ' +
                                _controller.text +
                                'المناسبة لأطفال الروضة بحيث يتوافر في القصة عنوان جذاب ومعبر عن القصة وعدد كلمات ما بين 150 الى 200 كلمة ويتوافر بالقصة الحبكة الدرامية والنهاية المناسبة ' +
                                "إبدا بالعنوان مباشرا";
                      }
                      print(Prompit);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return Genstory(
                          Prompit: Prompit,
                        );
                      }));
                    },
                    child: Text(
                      "ارسال",
                      style:
                          GoogleFonts.amiri(fontSize: 30, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff2a569a),
                      elevation: 10,
                      padding: EdgeInsets.only(
                          left: 100, right: 100, top: 10, bottom: 10),
                    ),
                  ),
                ),
                // SizedBox(height: 20), // Removed the SizedBox here, padding handled by Padding widget
              ],
            ),
          ),
        ),
      ),
    );
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
}
