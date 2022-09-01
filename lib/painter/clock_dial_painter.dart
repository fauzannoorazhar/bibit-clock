import 'dart:math';

import 'package:flutter/material.dart';

class ClockDialPainter extends CustomPainter {
  final hourTickMarkLength = 10.0;
  final minuteTickMarkLength = 5.0;

  final hourTickMarkWidth = 3.0;
  final minuteTickMarkWidth = 1.5;

  final Paint tickPaint;
  final TextPainter textPainter;
  final TextStyle textStyle;

  final romanNumeralList = [
    'XII',
    'I',
    'II',
    'III',
    'IV',
    'V',
    'VI',
    'VII',
    'VIII',
    'IX',
    'X',
    'XI'
  ];

  ClockDialPainter()
      : tickPaint = Paint(),
        textPainter = TextPainter(
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
        ),
        textStyle = const TextStyle(
          color: Colors.black,
          fontSize: 15.0,
        ) {
    tickPaint.color = Colors.black;
  }

  @override
  void paint(Canvas canvas, Size size) {
    late double tickMarkLength;
    late double angle = 2 * pi / 60;
    final radius = size.width / 2;
    canvas.save();

    canvas.translate(radius, radius);
    // TODO : Change text to [3, 6, 9, 12]
    for (var i = 0; i < 60; i++) {
      tickMarkLength = (i % 5 == 0) ? hourTickMarkLength : minuteTickMarkLength;
      tickPaint.strokeWidth = (i % 5 == 0) ? hourTickMarkWidth : minuteTickMarkWidth;
      canvas.drawLine(Offset(0.0, -radius), Offset(0.0, -radius + tickMarkLength), tickPaint);

      //draw the text
      if (i % 5 == 0) {
          canvas.save();
          canvas.translate(0.0, -radius + 20.0);
          textPainter.text = TextSpan(
            text: "${i == 0 ? 12 : i ~/ 5}",
            style: textStyle,
          );
          //helps make the text painted vertically
          canvas.rotate(-angle * i);

          textPainter.layout();
          //textPainter.paint(canvas, Offset(-(textPainter.width / 2), -(textPainter.height / 2)));

          canvas.restore();
        //}
      }

      canvas.rotate(angle);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
