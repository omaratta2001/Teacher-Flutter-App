import 'package:flutter/material.dart';
import 'package:testapp/View/choosebutton.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("Assets/background1.jpg"),
                  fit: BoxFit.fill)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xff2a569a),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      "أثر التفاعل بين واجهات التفاعل في بيئة التعلم النقال القائمة على الوكيل الذكي (موجه - غير موجه) والأسلوب المعرفي (تقبل الغموض - عدم تقبل الغموض) لدى معلمات رياض الأطفال على إنتاج المحتوى الرقمي لطفل الروضة",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)),
                    child: Text(
                      "أ.م.د/ محمد محمود عطا",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                // Text(
                //   "أ.م.د/ محمد محمود عطا",
                //   style: TextStyle(
                //     color: Color(0xff2a569a),
                //     fontSize: 25,
                //     fontWeight: FontWeight.bold,
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                Image.asset("Assets/1.png"),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Choosebutton(),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff2a569a),
                      padding: EdgeInsets.only(
                          left: 80, right: 80, top: 10, bottom: 10)),
                  child: Text(
                    "تخطى",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
