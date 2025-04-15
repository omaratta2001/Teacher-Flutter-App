import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'package:testapp/Constants.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class OpenAIScreen extends StatefulWidget {
  @override
  _OpenAIScreenState createState() => _OpenAIScreenState();
}

class _OpenAIScreenState extends State<OpenAIScreen> {
  TextEditingController _controller = TextEditingController();
  String _responseText = "";
  bool _isLoading = false;
  Key _textKey = UniqueKey();
  FlutterTts flutterTts = FlutterTts();
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  Timer? _silenceTimer;

  bool _isAnimationComplete = false; // Track animation completion

  @override
  void initState() {
    super.initState();
    _initializeSpeech();
  }

  // Initialize speech-to-text
  void _initializeSpeech() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() {});
    } else {
      print("Speech-to-text not available");
    }
  }

  void _startListening() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        print("Speech-to-text initialized successfully");
        setState(() => _isListening = true);

        await flutterTts.stop();
        // Start listening
        _speech.listen(
          onResult: (result) {
            setState(() {
              _controller.text = result.recognizedWords;
            });

            // Reset the silence timer whenever speech is detected
            _resetSilenceTimer();
          },
          localeId: "ar", // Set the language to Arabic
          onSoundLevelChange: (level) {
            // If sound level is below a threshold, consider it as silence
            if (level < 0.1) {
              _resetSilenceTimer();
            } else {
              // If sound is detected, reset the timer
              _resetSilenceTimer();
            }
          },
        );

        // Start a timer to detect silence
        _resetSilenceTimer();
      } else {
        print("Speech-to-text not available");
      }
    }
  }

  // Function to reset the silence timer
  void _resetSilenceTimer() {
    _silenceTimer?.cancel(); // Cancel the existing timer
    _silenceTimer =
        Timer(const Duration(seconds: 2), _stopListening); // Set a new timer
  }

  // Function to stop listening
  Future<void> _stopListening() async {
    if (_isListening) {
      _speech.stop();
      await sendRequest();
      setState(() => _isListening = false);
      _silenceTimer?.cancel(); // Cancel the timer when stopping
    }
  }

  @override
  void dispose() {
    _silenceTimer?.cancel();
    flutterTts.stop(); // Stop TTS when the widget is disposed

    super.dispose();
  }

  // Function to copy text to clipboard
  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copied to clipboard')),
    );
  }

  bool _isArabic(String text) {
    final arabicRegex =
        RegExp(r'[\u0600-\u06FF]'); // Range for Arabic characters
    return arabicRegex.hasMatch(text);
  }

  // Function to speak text
  void _speakText(String text) async {
    try {
      if (_isArabic(text)) {
        await flutterTts.setLanguage("ar-SA"); // Set language to Arabic
        print("TTS: Language set to Arabic"); // Debug log
      } else {
        await flutterTts.setLanguage("en-US"); // Set language to English
        print("TTS: Language set to English"); // Debug log
      }

      await flutterTts.setPitch(1.0); // Set pitch (1.0 is normal)
      await flutterTts
          .setSpeechRate(0.5); // Set speech rate (0.5 is half speed)
      await flutterTts.speak(text); // Speak the text
      print("TTS: Speaking text: $text"); // Debug log
    } catch (e) {
      print("TTS Error: $e"); // Debug log
    }
  }

  // Function to replace specific words
  String _replaceText(String text) {
    text = text.replaceAll("**", "");
    text = text.replaceAll("#", "");
    return text;
  }

  Future<void> sendRequest() async {
    final String apiKey =
        "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"; // Replace with your OpenAI API key
    final String baseUrl = "https://openrouter.ai/api/v1/chat/completions";
    if (_controller.text.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse("$baseUrl"),
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json; charset=utf-8",
        },
        body: utf8.encode(
          jsonEncode({
            "model":
                "google/gemini-2.0-flash-lite-preview-02-05:free", // Change to "gpt-4" if needed
            "messages": [
              {"role": "user", "content": _controller.text}
            ]
          }),
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        setState(() {
          _responseText = data["choices"][0]["message"]["content"];
          _textKey = UniqueKey();
          _speakText(
            _replaceText(_responseText),
          );
        });
      } else {
        setState(() {
          _responseText = "Error: ${utf8.decode(response.bodyBytes)}";
        });
      }
    } catch (e) {
      setState(() {
        _responseText = "Failed to connect: $e";
      });
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 75,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          title: Center(
              child: Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: Text("OpenAI Chat"),
          ))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  _speakText(
                    _replaceText(_responseText),
                  );
                },
                onLongPress: () {
                  _copyToClipboard(_responseText);
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: lightGreen,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimatedTextKit(
                        key: _textKey,
                        animatedTexts: [
                          TypewriterAnimatedText(
                            _replaceText(_responseText),
                            textStyle: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            // Set text direction dynamically
                            textAlign: _isArabic(_controller.text)
                                ? TextAlign.right
                                : TextAlign.left,
                          ),
                        ],
                        isRepeatingAnimation: false,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    textDirection: _isArabic(_controller.text)
                        ? TextDirection.rtl
                        : TextDirection.ltr, // Set text direction dynamically
                    textAlign: _isArabic(_controller.text)
                        ? TextAlign.right
                        : TextAlign.left,
                    controller: _controller,
                    textInputAction: TextInputAction.send,
                    style: TextStyle(color: Colors.black),
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                      counterStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      labelText: "Enter your message",
                      hoverColor: lightGreen,
                      focusColor: lightGreen,
                      fillColor: Colors.black,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 4),
                          borderRadius: BorderRadius.circular(40)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      focusedBorder: OutlineInputBorder(
                        gapPadding: 0.0,
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: lightGreen, width: 1.5),
                      ),
                    ),
                    onChanged: (value) {
                      // Update text direction and alignment dynamically as the user types
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : sendRequest,
                  child: _isLoading
                      ? CircularProgressIndicator(
                          color: Colors.black,
                        )
                      : Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                ),
              ],
            ),
            SizedBox(height: 10),
            // Add a microphone button for speech-to-text
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                onPressed: _isListening ? _stopListening : _startListening,
                child: Icon(
                  _isListening ? Icons.mic_off : Icons.mic,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
