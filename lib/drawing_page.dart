import 'dart:async';

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import 'package:what_is_it/send_data_to__gemini.dart';

bool isDrawing = true;

class DrawingPage extends StatefulWidget {
  const DrawingPage({super.key});

  @override
  State<DrawingPage> createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  List<Offset> points = [];
  GlobalKey globalKey = GlobalKey();
  Timer? _debounceTimer;
  String resp1 = "What is it ?";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  points = [];
                  isDrawing = true;
                  resp1 = "What is it ?";
                });
              },
              icon: const Icon(Icons.refresh))
        ],
        centerTitle: true,
        title: Text.rich(
          TextSpan(children: [
            TextSpan(text: !isDrawing ? "Guessing......  " : ""),
            TextSpan(text: resp1)
          ]),
        ),
      ),
      body: RepaintBoundary(
        key: globalKey,
        child: DrawingBoard(
          points: points,
          func: captureDrawingWithDebounce,
        ),
      ),
    );
  }

  void captureDrawingWithDebounce() {
    // Cancel any existing timer
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }

    // Set up a new timer
    _debounceTimer = Timer(const Duration(milliseconds: 100), () {
      captureImage();
    });
  }

  


  Future<void> captureImage() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      Future<List<String>> st = sendTo1Gemini(pngBytes);
      // setState(() {
      //   resp1 = "";
      // });
      setState(() {
        isDrawing = false;
        resp1 = "";
      });
      List<String> resp = await st;
      String s1 = resp.join(" ");

      setState(() {
        resp1 = s1;
        isDrawing = true;
      });
      // Now you can print the response
      // print(response);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Widget texth() {
    return Text(resp1);
  }
}

class DrawingBoard extends StatefulWidget {
  final List<Offset> points;
  final VoidCallback func;

  const DrawingBoard({super.key, required this.points, required this.func});

  @override
  State<DrawingBoard> createState() => DdrawingBoardState();
}

class DdrawingBoardState extends State<DrawingBoard> {
  // List<Offset> points ;

  // DrawingBoard(rhis.po)
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: CustomPaint(
          painter: DrawingPainter(widget.points),
          size: Size.infinite,
        ),
        onPanUpdate: (details) {
          setState(() {
            // isDrawing = false;
            RenderBox renderBox = context.findRenderObject() as RenderBox;
            widget.points.add(
              renderBox.globalToLocal(details.globalPosition),
            );
          });
          widget.func();
        },
        onPanEnd: (details) {
          setState(() {
            widget.points.add(Offset.zero); //adding a seprator
          });
          widget.func();
        });
  }
}

class DrawingPainter extends CustomPainter {
  final List<Offset> points;
  DrawingPainter(this.points);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color.fromARGB(255, 89, 15, 15)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      // Check if the next point is within range before accessing it
      if (i < points.length - 1) {
        if (points[i] != Offset.zero && points[i + 1] != Offset.zero) {
          canvas.drawLine(points[i], points[i + 1], paint);
        } else if (points[i] != Offset.zero && points[i + 1] == Offset.zero) {
          canvas.drawPoints(PointMode.points, [points[i]], paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
