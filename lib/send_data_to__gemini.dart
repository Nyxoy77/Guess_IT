import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_gemini/flutter_gemini.dart';

final Gemini geminiInstance = Gemini.instance;
// String ans = "";

Future<List<String>> sendTo1Gemini(Uint8List bytes) async {
  List<String> ans = [];
  String question =
      "Identify the object in the image using only the object's name or description, without extra words.";

  await for (var data
      in geminiInstance.streamGenerateContent(question, images: [bytes])) {
    String response = data.content?.parts
            ?.fold("", (prev, current) => "$prev ${current.text}") ??
        "";
    ans.add(response);
  }
  return ans;
}

