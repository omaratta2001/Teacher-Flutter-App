import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/Constants.dart';
import 'package:testapp/View/HomePage.dart';
import 'package:testapp/View/button.dart';

final introKey = GlobalKey<IntroductionScreenState>();

enum Level { first, second }

class chosseleve {
  final int age;
  bool isactive = false;

  chosseleve({required this.age});
}

class Onboradingscreen extends StatefulWidget {
  @override
  State<Onboradingscreen> createState() => _OnboradingscreenState();
}

void _onIntroEnd(context) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (_) => const Homepage()),
  );
}

Widget _buildImage(String assetName, [double width = 350]) {
  return Image.asset('Assets/$assetName', width: width);
}

class _OnboradingscreenState extends State<Onboradingscreen> {
  Level? _selectedLevel;
  int ages = 0;

  List<chosseleve> age = [
    chosseleve(age: 4),
    chosseleve(age: 5),
  ];

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(
        fontSize: 19.0, color: Colors.black, fontWeight: FontWeight.bold);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 30.0, fontWeight: FontWeight.w700, color: Colors.black),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,

      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: _buildImage('flutter.png', 100),
          ),
        ),
      ),
      // globalFooter: SizedBox(
      //   width: double.infinity,
      //   height: 60,
      //   child: ElevatedButton(
      //     child: const Text(
      //       'Let\'s go right away!',
      //       style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      //     ),
      //     onPressed: () => _onIntroEnd(context),
      //   ),
      // ),
      pages: [
        PageViewModel(
          title: "أ.م.د/ محمد محمود عطا",
          body:
              "أثر التفاعل بين واجهات التفاعل في بيئة التعلم النقال القائمة على الوكيل الذكي (موجه - غير موجه) والأسلوب المعرفي (تقبل الغموض - عدم تقبل الغموض) لدى معلمات رياض الأطفال على إنتاج المحتوى الرقمي لطفل الروضة",
          image: _buildImage('1.png'),
          decoration: pageDecoration,
        ),
        // PageViewModel(
        //   title: "أ.م.د/ محمد محمود عطا",
        //   bodyWidget: Center(
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         InkWell(
        //           onTap: () {
        //             setState(() {
        //               _selectedLevel = Level.first;
        //               ages = 4;
        //             });
        //           },
        //           child: InkWell(
        //             onTap: () {
        //               setState(() {
        //                 _selectedLevel = Level.first;
        //                 ages = 4;
        //               });
        //             },
        //             child: Container(
        //               width: 250,
        //               child: Card(
        //                 color: darkred,
        //                 elevation: 5,
        //                 shadowColor: Colors.orange,
        //                 shape: RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.circular(25),
        //                 ),
        //                 child: Row(
        //                   children: [
        //                     Container(
        //                       height: 150,
        //                       width: 160,
        //                       padding: EdgeInsets.all(50),
        //                       decoration: BoxDecoration(
        //                         borderRadius: BorderRadius.only(
        //                           topLeft: Radius.circular(25),
        //                           topRight: Radius.circular(25),
        //                           bottomLeft: Radius.circular(25),
        //                         ),
        //                         image: DecorationImage(
        //                           image: AssetImage("Assets/23.png"),
        //                           fit: BoxFit.fill,
        //                         ),
        //                       ),
        //                     ),
        //                     Padding(
        //                       padding:
        //                           const EdgeInsets.only(left: 20.0, right: 10),
        //                       child: Radio<Level>(
        //                         fillColor:
        //                             MaterialStateProperty.all(Colors.white),
        //                         focusColor: Colors.white,
        //                         activeColor: Colors.white,
        //                         value: Level.first,
        //                         groupValue: _selectedLevel,
        //                         onChanged: (Level? value) {
        //                           setState(() {
        //                             _selectedLevel = value;
        //                             ages = 4;
        //                           });
        //                         },
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //         InkWell(
        //           onTap: () {
        //             setState(() {
        //               _selectedLevel = Level.second;
        //               ages = 5;
        //               print(ages);
        //             });
        //           },
        //           child: InkWell(
        //             onTap: () {
        //               setState(() {
        //                 _selectedLevel = Level.second;
        //                 ages = 5;
        //               });
        //             },
        //             child: Container(
        //               width: 250,
        //               child: Card(
        //                 color: lightblue,
        //                 elevation: 5,
        //                 shadowColor: Colors.orange,
        //                 shape: RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.circular(25),
        //                 ),
        //                 child: Row(
        //                   children: [
        //                     Expanded(
        //                       child: Container(
        //                         height: 150,
        //                         width: 150,
        //                         decoration: BoxDecoration(
        //                           borderRadius: BorderRadius.only(
        //                             topLeft: Radius.circular(25),
        //                             topRight: Radius.circular(25),
        //                             bottomLeft: Radius.circular(25),
        //                           ),
        //                           image: DecorationImage(
        //                             image: AssetImage("Assets/24.png"),
        //                             fit: BoxFit.fill,
        //                           ),
        //                         ),
        //                       ),
        //                     ),
        //                     Padding(
        //                       padding:
        //                           const EdgeInsets.only(left: 20.0, right: 20),
        //                       child: Radio<Level>(
        //                         fillColor:
        //                             MaterialStateProperty.all(Colors.white),
        //                         focusColor: Colors.white,
        //                         activeColor: Colors.white,
        //                         value: Level.second,
        //                         groupValue: _selectedLevel,
        //                         onChanged: (Level? value) {
        //                           setState(() {
        //                             _selectedLevel = value!;
        //                             ages = 5;
        //                           });
        //                         },
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //         ElevatedButton(
        //           onPressed: () async {
        //             if (ages != 0) {
        //               print("okkkkkkkkkkkkkk");
        //               final SharedPreferences prefs =
        //                   await SharedPreferences.getInstance();
        //               await prefs.setInt('age', ages);

        //               Navigator.of(context).push(MaterialPageRoute(
        //                 builder: (context) => Buttons(),
        //               ));
        //             }
        //           },
        //           child: Text(
        //             "التالي",
        //             style: TextStyle(
        //               fontSize: 25,
        //               fontWeight: FontWeight.bold,
        //               color: Colors.white,
        //             ),
        //           ),
        //           style: ElevatedButton.styleFrom(
        //             backgroundColor: Colors.blue,
        //             padding: EdgeInsets.only(
        //               left: 25,
        //               right: 25,
        //               top: 10,
        //               bottom: 10,
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        // PageViewModel(
        //   title: "Kids and teens",
        //   body:
        //       "Kids and teens can track their stocks 24/7 and place trades that you approve.",
        //   image: _buildImage('img3.jpg'),
        //   decoration: pageDecoration,
        // ),
        // PageViewModel(
        //   title: "Another title page",
        //   body: "Another beautiful body text for this example onboarding",
        //   image: _buildImage('img2.jpg'),
        //   footer: ElevatedButton(
        //     onPressed: () {
        //       introKey.currentState?.animateScroll(0);
        //     },
        //     style: ElevatedButton.styleFrom(
        //       backgroundColor: Colors.lightBlue,
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(8.0),
        //       ),
        //     ),
        //     child: const Text(
        //       'FooButton',
        //       style: TextStyle(color: Colors.white),
        //     ),
        //   ),
        //   decoration: pageDecoration.copyWith(
        //     bodyFlex: 6,
        //     imageFlex: 6,
        //     safeArea: 80,
        //   ),
        // ),
        // PageViewModel(
        //   title: "Title of last page - reversed",
        //   bodyWidget: const Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Text("Click on ", style: bodyStyle),
        //       Icon(
        //         Icons.edit,
        //         color: Colors.black,
        //       ),
        //       Text(" to edit a post", style: bodyStyle),
        //     ],
        //   ),
        //   decoration: pageDecoration.copyWith(
        //     bodyFlex: 2,
        //     imageFlex: 4,
        //     bodyAlignment: Alignment.bottomCenter,
        //     imageAlignment: Alignment.topCenter,
        //   ),
        //   image: _buildImage('img1.jpg'),
        //   reverse: true,
        // ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: DotsDecorator(
        activeColor: darkred,
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
