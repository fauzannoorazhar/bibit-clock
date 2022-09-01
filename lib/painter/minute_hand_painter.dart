import 'dart:math';

import 'package:flutter/material.dart';

class MinuteHandPainter extends CustomPainter{
  final Paint minuteHandPaint;
  int minutes;
  int seconds;

  MinuteHandPainter({required this.minutes, required this.seconds}) : minuteHandPaint = Paint() {
    minuteHandPaint.color = const Color(0xFF0E3993);
    minuteHandPaint.style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    canvas.save();
    canvas.translate(radius, radius);
    canvas.rotate(2*pi*((minutes+(seconds/60))/60));

    Path lineMinute = Path();
    lineMinute.moveTo(-1.5, -radius);
    lineMinute.lineTo(-2.0, 10.0);
    lineMinute.lineTo(2.0, 10.0);
    lineMinute.lineTo(1.5, -radius);
    lineMinute.close();

    canvas.drawPath(lineMinute, minuteHandPaint);
    canvas.drawShadow(lineMinute, Colors.black, 4.0, false);
    canvas.restore();

  }

  @override
  bool shouldRepaint(MinuteHandPainter oldDelegate) {
    return true;
  }
}
