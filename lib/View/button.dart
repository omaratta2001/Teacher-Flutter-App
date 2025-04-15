import 'package:flutter/material.dart';
import 'package:testapp/View/Activity%20Screen/ActivityScreen.dart';
import 'package:testapp/View/GenText.dart';
import 'package:testapp/View/Image%20Screen/ImageScreen.dart';
import 'package:testapp/View/Poem%20Screen/PoemScreen.dart';
import 'package:testapp/View/Story%20Screen/StoryChooseScreen.dart';
import 'package:testapp/View/gen.dart';

class Buttons extends StatefulWidget {
  const Buttons({super.key});

  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 75,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        title: Center(
            child: Padding(
          padding: const EdgeInsets.only(right: 50),
          child: Text("إختار ماذا تريد ؟"),
        )),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("Assets/background1.jpg"), fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Changed to center
          children: [
            SizedBox(
              height: 100,
            ),
            // Removed Expanded widget
            GridView.count(
              shrinkWrap: true, // Added shrinkWrap back
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              childAspectRatio: 0.8, // Changed aspect ratio back to 0.8
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Imagescreen(),
                    ));
                  },
                  // Removed Expanded widget here
                  child: Column(
                    children: [
                      Flexible(
                        flex: 3, // Assign flex to Image
                        // Wrap Image with Flexible
                        child: Image.asset(
                          "Assets/Image.png",
                          // Removed fixed height
                        ),
                      ),
                      Flexible(
                        flex: 1, // Assign flex to Text
                        // Wrap Text with Flexible
                        // Removed FittedBox
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "صورة",
                            overflow:
                                TextOverflow.ellipsis, // Add ellipsis overflow
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25, // Reduced font size
                                color: Colors.black),
                          ),
                        ), // Added missing parenthesis
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Storychoosescreen(),
                    ));
                  },
                  child: Column(
                    children: [
                      Flexible(
                        flex: 3, // Assign flex to Image
                        // Wrap Image with Flexible
                        child: Image.asset(
                          "Assets/story.png",
                        ),
                      ),
                      Flexible(
                        flex: 1, // Assign flex to Text
                        // Wrap Text with Flexible
                        // Removed FittedBox
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "قصص",
                            overflow:
                                TextOverflow.ellipsis, // Add ellipsis overflow
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25, // Reduced font size
                                color: Colors.black),
                          ),
                        ), // Added missing parenthesis
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return Poemscreen();
                  })),
                  child: Column(
                    children: [
                      Flexible(
                        flex: 3, // Assign flex to Image
                        // Wrap Image with Flexible
                        child: Image.asset(
                          "Assets/poem.png",
                          // Removed fixed height
                          fit: BoxFit.fill,
                        ),
                      ),
                      Flexible(
                        flex: 1, // Assign flex to Text
                        // Wrap Text with Flexible
                        // Removed FittedBox
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "نشيد",
                            overflow:
                                TextOverflow.ellipsis, // Add ellipsis overflow
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25, // Reduced font size
                                color: Colors.black),
                          ),
                        ), // Added missing parenthesis
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return Activityscreen();
                  })),
                  child: Column(
                    children: [
                      Flexible(
                        flex: 3, // Assign flex to Image
                        // Wrap Image with Flexible
                        child: Image.asset(
                          "Assets/activity.png",
                          // Removed fixed height
                          fit: BoxFit.contain,
                        ),
                      ),
                      Flexible(
                        flex: 1, // Assign flex to Text
                        // Wrap Text with Flexible
                        // Removed FittedBox
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            "نشاط",
                            overflow:
                                TextOverflow.ellipsis, // Add ellipsis overflow
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25, // Reduced font size
                                color: Colors.black),
                          ),
                        ), // Added missing parenthesis
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
