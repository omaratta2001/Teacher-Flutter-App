import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/Constants.dart';
import 'package:testapp/Controller/SpeakToText.dart';
import 'package:testapp/View/Activity%20Screen/gentextactivityScreen.dart';
import 'package:testapp/View/Story%20Screen/Genstory.dart';

class Activityscreen extends StatefulWidget {
  const Activityscreen({super.key});

  @override
  State<Activityscreen> createState() => _ActivityscreenState();
}

class _ActivityscreenState extends State<Activityscreen> {
  List<bool> _numberBoxSelections = List.generate(6, (index) => false);
  List<bool> _numberBoxSelections1 = List.generate(2, (index) => false);

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
          "اعداد نشاط",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0, bottom: 2),
            child: Image.asset(
              "Assets/activity.png",
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

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  //                 selectedValue = 'المهارات اللغوية ';
                  //               });
                  //             },
                  //             child: Row(
                  //               children: [
                  //                 Radio<String>(
                  //                   value: 'المهارات اللغوية ',
                  //                   groupValue: selectedValue,
                  //                   onChanged: (value) {
                  //                     setState(() {
                  //                       selectedValue = value;
                  //                     });
                  //                   },
                  //                 ),
                  //                 Text(
                  //                   "نشاط لغوي",
                  //                   style: TextStyle(
                  //                       fontSize: 20, fontWeight: FontWeight.bold),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //           InkWell(
                  //             onTap: () {
                  //               setState(() {
                  //                 selectedValue = 'مهارات الرياضيات ';
                  //               });
                  //             },
                  //             child: Row(
                  //               children: [
                  //                 Radio<String>(
                  //                   value: 'مهارات الرياضيات ',
                  //                   groupValue: selectedValue,
                  //                   onChanged: (value) {
                  //                     setState(() {
                  //                       selectedValue = value;
                  //                     });
                  //                   },
                  //                 ),
                  //                 Text(
                  //                   "نشاط رياضي",
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
                  //                   value: 'المفاهيم العلمية  ',
                  //                   groupValue: selectedValue,
                  //                   onChanged: (value) {
                  //                     setState(() {
                  //                       selectedValue = value;
                  //                     });
                  //                   },
                  //                 ),
                  //                 Text(
                  //                   "نشاط علمي",
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
                  //                 selectedValue = 'الأنشطة الفنية ';
                  //               });
                  //             },
                  //             child: Row(
                  //               children: [
                  //                 Radio<String>(
                  //                   value: 'الأنشطة الفنية ',
                  //                   groupValue: selectedValue,
                  //                   onChanged: (value) {
                  //                     setState(() {
                  //                       selectedValue = value;
                  //                     });
                  //                   },
                  //                 ),
                  //                 Text(
                  //                   "نشاط فني",
                  //                   style: TextStyle(
                  //                       fontSize: 20, fontWeight: FontWeight.bold),
                  //                 )
                  //               ],
                  //             ),
                  //           ),
                  //           InkWell(
                  //             onTap: () {
                  //               setState(() {
                  //                 selectedValue = 'الأنشطة الحركية ';
                  //               });
                  //             },
                  //             child: Row(
                  //               children: [
                  //                 Radio<String>(
                  //                   value: 'الأنشطة الحركية ',
                  //                   groupValue: selectedValue,
                  //                   onChanged: (value) {
                  //                     setState(() {
                  //                       selectedValue = value;
                  //                     });
                  //                   },
                  //                 ),
                  //                 Text(
                  //                   "نشاط حركي",
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
                  //                     'الأنشطة التكنولوجية او الوعى بالأجهزة والتطبيقات والمستحدثات التكنولوجية ';
                  //               });
                  //             },
                  //             child: Row(
                  //               children: [
                  //                 Radio<String>(
                  //                   value:
                  //                       'الأنشطة التكنولوجية او الوعى بالأجهزة والتطبيقات والمستحدثات التكنولوجية ',
                  //                   groupValue: selectedValue,
                  //                   onChanged: (value) {
                  //                     setState(() {
                  //                       selectedValue = value;
                  //                     });
                  //                   },
                  //                 ),
                  //                 Text(
                  //                   "نشاط تقني",
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
                                    selectedValue = 'المهارات اللغوية ';
                                    _controller.text = '';
                                  });
                                  print(_numberBoxSelections[0]);
                                },
                                child: buildOption(
                                    "نشاط لغوي", _numberBoxSelections[0]),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _numberBoxSelections =
                                        List.generate(6, (i) => i == 1);
                                    selectedValue = 'مهارات الرياضيات ';
                                    _controller.text = '';
                                  });
                                },
                                child: buildOption(
                                    "نشاط رياضي", _numberBoxSelections[1]),
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
                                    "نشاط علمي", _numberBoxSelections[2]),
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
                                    selectedValue = 'الأنشطة الفنية ';
                                    _controller.text = '';
                                  });
                                },
                                child: buildOption(
                                    "نشاط فني", _numberBoxSelections[3]),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _numberBoxSelections =
                                        List.generate(6, (i) => i == 4);
                                    selectedValue = 'الأنشطة الحركية ';
                                    _controller.text = '';
                                  });
                                },
                                child: buildOption(
                                    "نشاط حركي", _numberBoxSelections[4]),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _numberBoxSelections =
                                        List.generate(6, (i) => i == 5);
                                    selectedValue =
                                        'الأنشطة التكنولوجية او الوعى بالأجهزة والتطبيقات والمستحدثات التكنولوجية ';
                                    _controller.text = '';
                                  });
                                },
                                child: buildOption(
                                    "نشاط تقني", _numberBoxSelections[5]),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

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
                                    'مع مراعاة ان الصياغة تكون المتعارف عليها للمعلمات عند كتابة الانشطة';
                                _numberBoxSelections1 =
                                    List.generate(2, (i) => i == 0);
                                _controller.text = '';
                              });
                            },
                            child:
                                buildOption("أدوات", _numberBoxSelections1[0]),
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
                                "بدون ادوات", _numberBoxSelections1[1]),
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

                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     Center(
                  //       child: Text(
                  //         "أكتب\nفكرتك",
                  //         style: TextStyle(
                  //             fontSize: 25, fontWeight: FontWeight.bold),
                  //       ),
                  //     ),
                  //     Stack(
                  //       children: [
                  //         Container(
                  //           width: MediaQuery.of(context).size.width / 1.5,
                  //           height: 100,
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(15),
                  //               border: Border.all(
                  //                   width: 4, color: Color(0xff006cbe))),
                  //           child: Padding(
                  //             padding: const EdgeInsets.all(8.0),
                  //             child: TextField(
                  //               controller: _controller,
                  //               decoration: InputDecoration(
                  //                 border: InputBorder.none,
                  //                 focusedBorder: InputBorder
                  //                     .none, // Removes border when focused
                  //                 enabledBorder: InputBorder
                  //                     .none, // Removes border when enabled
                  //                 disabledBorder: InputBorder.none,
                  //               ),
                  //               maxLines: 5,
                  //             ),
                  //           ),
                  //         ),
                  //         Transform.translate(
                  //             offset: Offset(20, -20),
                  //             child: Image.asset("Assets/Pin.png"))
                  //       ],
                  //     )
                  //   ],
                  // ),
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
                  //           height: 60,
                  //           padding: EdgeInsets.all(11),
                  //           decoration: BoxDecoration(
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
                  //               -MediaQuery.of(context).size.width * 0.53, -20),
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
                  //     ),
                  //   ],
                  // ),

                  ElevatedButton(
                    onPressed: () async {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      int? age = await prefs.getInt('age');
                      Prompit =
                          'اعتبر نفسك كاتب متخصص في تأليف الأنشطة لأطفال الروضة وقم بكتابة نشاط لتنمية أحد ' +
                              selectedValue! +
                              'لأطفال الروضة لسن ' +
                              age.toString() +
                              'بحيث يتوافر في النشاط عنوان النشاط – زمن النشاط – اهداف النشاط بطريقة إجرائية قابلة للقياس – الأدوات المستخدمة في النشاط - محتوى النشاط – التقويم النهائي للأهداف ' +
                              selectedValue1! +
                              "أبدا بالعنوان مباشرا";

                      if (_controller.text == "") {
                        Prompit =
                            'اعتبر نفسك كاتب متخصص في تأليف الأنشطة لأطفال الروضة وقم بكتابة نشاط لتنمية أحد ' +
                                _controller.text +
                                'لأطفال الروضة لسن ' +
                                age.toString() +
                                'بحيث يتوافر في النشاط عنوان النشاط – زمن النشاط – اهداف النشاط بطريقة إجرائية قابلة للقياس – الأدوات المستخدمة في النشاط - محتوى النشاط – التقويم النهائي للأهداف ' +
                                "أبدا بالعنوان مباشرا";
                      }
                      print(Prompit);

                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return Gentextactivityscreen(
                          Prompit: Prompit,
                          titlename: 'اعداد نشاط',
                          image: 'activity',
                        );
                      }));
                    },
                    child: Text(
                      "ارسال",
                      style:
                          GoogleFonts.amiri(fontSize: 30, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: lightGreen,
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
