import 'package:flutter/material.dart';

RichText buildStyledText(String input, double font) {
  final boldRegex = RegExp(r'\*\*(.*?)\*\*');
  final headingRegex = RegExp(r'^##\s?(.*)', multiLine: true);

  final spans = <TextSpan>[];

  // Split into lines to check for headings
  final lines = input.split('\n');

  for (var line in lines) {
    // Check for heading
    final headingMatch = headingRegex.firstMatch(line);
    if (headingMatch != null) {
      spans.add(
        TextSpan(
          text: headingMatch.group(1)! + '\n',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: font + 4,
          ),
        ),
      );
      continue;
    }

    // Handle bold text
    int currentIndex = 0;
    final matches = boldRegex.allMatches(line);

    for (final match in matches) {
      if (match.start > currentIndex) {
        spans.add(TextSpan(
          text: line.substring(currentIndex, match.start),
          style: TextStyle(fontSize: font),
        ));
      }
      spans.add(TextSpan(
        text: match.group(1),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: font,
        ),
      ));
      currentIndex = match.end;
    }

    if (currentIndex < line.length) {
      spans.add(TextSpan(
        text: line.substring(currentIndex),
        style: TextStyle(fontSize: font),
      ));
    }

    // Add a new line after each line
    spans.add(const TextSpan(text: '\n'));
  }

  return RichText(
    text: TextSpan(
      style: TextStyle(color: Colors.black, fontSize: font),
      children: spans,
    ),
  );
}
