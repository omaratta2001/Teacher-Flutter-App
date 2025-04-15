import 'dart:async';

import 'package:speech_to_text/speech_to_text.dart';

class SpeechService {
  final SpeechToText _speech = SpeechToText();
  bool _isAvailable = false;
  Timer? _silenceTimer;

  Future<void> initSpeech() async {
    _isAvailable = await _speech.initialize();
  }

  void _resetSilenceTimer() {
    _silenceTimer?.cancel(); // Cancel the existing timer
    _silenceTimer =
        Timer(const Duration(seconds: 2), stopListening); // Set a new timer
  }

  Future<void> startListening(Function(String) onResult) async {
    if (_isAvailable) {
      _speech.listen(
        onResult: (result) => onResult(result.recognizedWords),
        localeId: 'ar-EG',
      );
    }
  }

  void stopListening() {
    _speech.stop();
  }

  bool get isListening => _speech.isListening;
}
