import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/Constants.dart';
import 'package:testapp/View/button.dart';

enum Level { first, second }

class chosseleve {
  final int age;
  bool isactive = false;

  chosseleve({required this.age});
}

class Choosebutton extends StatefulWidget {
  const Choosebutton({super.key});

  @override
  State<Choosebutton> createState() => _ChoosebuttonState();
}

class _ChoosebuttonState extends State<Choosebutton> {
  Level? _selectedLevel;
  int ages = 0;
  bool? Isselected = false;

  List<chosseleve> age = [
    chosseleve(age: 4),
    chosseleve(age: 5),
  ];
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
            child: Padding(
          padding: const EdgeInsets.only(right: 50),
          child: Text("إختار المستوي المناسب لك"),
        )),
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
                height: 60,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    Isselected = false;
                    _selectedLevel = Level.first;
                    ages = 4;
                  });
                },
                child: InkWell(
                  onTap: () {
                    setState(() {
                      Isselected = false;

                      _selectedLevel = Level.first;
                      ages = 4;
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: MediaQuery.of(context).size.height / 3.5,
                    child: Card(
                      color: Color(0xffffe3e2),
                      elevation: 5,
                      shadowColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                  bottomLeft: Radius.circular(25),
                                ),
                                image: DecorationImage(
                                    image: AssetImage("Assets/Untitled-2.png"),
                                    fit: BoxFit.fill),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 10,
                                right: 10),
                            // child: Radio<Level>(
                            //   fillColor: MaterialStateProperty.all(Colors.white),
                            //   focusColor: Colors.white,
                            //   activeColor: Colors.white,
                            //   value: Level.first,
                            //   groupValue: _selectedLevel,
                            //   onChanged: (Level? value) {
                            //     setState(() {
                            //       Isselected = false;

                            //       _selectedLevel = value;
                            //       ages = 4;
                            //     });
                            //   },
                            // ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  Isselected = false;
                                });
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: !Isselected!
                                          ? Color(0xfff7f5ee)
                                          : Color(0xfff7f5ee),
                                      width: 4),
                                  color: !Isselected!
                                      ? Color(0xfff7f5ee)
                                      : Colors.transparent,
                                ),
                                child: !Isselected!
                                    ? const Center(
                                        child: Icon(
                                          Icons.check,
                                          color: Color(0xffc34d5b),
                                          size: 20,
                                          weight: 700,
                                        ),
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    Isselected = true;

                    _selectedLevel = Level.second;
                    ages = 5;
                    print(ages);
                  });
                },
                child: InkWell(
                  onTap: () {
                    setState(() {
                      Isselected = true;

                      _selectedLevel = Level.second;
                      ages = 5;
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: MediaQuery.of(context).size.height / 3.5,
                    child: Card(
                      color: Color(0xff86c9d1),
                      elevation: 5,
                      shadowColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              padding: EdgeInsets.all(50),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                  bottomLeft: Radius.circular(25),
                                ),
                                image: DecorationImage(
                                    image: AssetImage("Assets/Untitled-21.png"),
                                    fit: BoxFit.fill),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 9.2,
                                right: 10),
                            // child: Radio<Level>(
                            //   fillColor: MaterialStateProperty.all(Colors.white),
                            //   focusColor: Colors.white,
                            //   activeColor: Colors.white,
                            //   value: Level.second,
                            //   groupValue: _selectedLevel,
                            //   onChanged: (Level? value) {
                            //     setState(() {
                            //       _selectedLevel = value!;
                            //       ages = 5;
                            //     });
                            //   },
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  Isselected = true;
                                });
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Isselected!
                                          ? Color(0xfff7f5ee)
                                          : Color(0xfff7f5ee),
                                      width: 4),
                                  color: Isselected!
                                      ? Color(0xfff7f5ee)
                                      : Colors.transparent,
                                ),
                                child: Isselected!
                                    ? const Center(
                                        child: Icon(
                                          Icons.check,
                                          color: Color(0xff479ea8),
                                          size: 20,
                                          weight: 700,
                                        ),
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (ages != 0) {
                    print("okkkkkkkkkkkkkk");
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setInt('age', ages);

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Buttons(),
                    ));
                  }
                },
                child: Text(
                  "التالي",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff2a569a),
                  elevation: 10,
                  padding: EdgeInsets.only(
                      left: 100, right: 100, top: 10, bottom: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
