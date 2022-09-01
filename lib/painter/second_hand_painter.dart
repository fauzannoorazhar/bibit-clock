import 'dart:math';

import 'package:flutter/material.dart';

class SecondHandPainter extends CustomPainter{
  final Paint secondHandPaint;
  final Paint secondHandPointsPaint;

  int seconds;

  SecondHandPainter({required this.seconds}):
    secondHandPaint = Paint(),
    secondHandPointsPaint = Paint() {
    secondHandPaint.color = const Color(0xFF8193AC);
    secondHandPaint.style = PaintingStyle.stroke;
    secondHandPaint.strokeWidth = 2.0;

    secondHandPointsPaint.color = const Color(0xFF8193AC);
    secondHandPointsPaint.style = PaintingStyle.fill;

  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius= size.width / 2;
    canvas.save();
    canvas.translate(radius, radius);

    canvas.rotate(2*pi*seconds/60);

    Path lineSecond = Path();
    Path roundedSecond = Path();
    lineSecond.moveTo(0.0, -radius / 1.2);
    lineSecond.lineTo(0.0, radius/5);

    roundedSecond.addOval(Rect.fromCircle(radius: 5.0, center: const Offset(0.0, 0.0)));

    canvas.drawPath(lineSecond, secondHandPaint);
    canvas.drawPath(roundedSecond, secondHandPointsPaint);
    // canvas.drawShadow(roundedSecond, Colors.black, 4.0, false);

    canvas.restore();
  }

  @override
  bool shouldRepaint(SecondHandPainter oldDelegate) {
    return seconds != oldDelegate.seconds;
  }
}