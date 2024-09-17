import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:what_is_it/drawing_page.dart';
import 'package:what_is_it/secrets.dart';

void main() {
  runApp(const MyApp());
  Gemini.init(apiKey: api_key);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DrawingPage(),
    );
  }
}
