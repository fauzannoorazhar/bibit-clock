import 'dart:async';

import 'package:bibit_clock/screen/widget/widget.dart';
import 'package:flutter/material.dart';
import 'dart:math';

typedef TimeProducer = DateTime Function();

class Clock extends StatefulWidget {
  final Color circleColor;
  final Color legColor;
  final DateTime dateTime;

  Clock({
    this.circleColor = Colors.black,
    this.legColor = const Color(0xFF555555),
    required this.dateTime
  });

  static DateTime getSystemTime() {
    return DateTime.now();
  }

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: buildClockCircle(context),
    );
  }

  Container buildClockCircle(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.circleColor,
        boxShadow: const [
          BoxShadow(
            offset: Offset(0.0, 1.0),
            blurStyle: BlurStyle.normal,
            blurRadius: 3.0,
            spreadRadius: -4
          )
        ],
      ),
      child: ClockFace(dateTime: widget.dateTime),
    );
  }
}

class BellsAndLegsPainter extends CustomPainter {
  final Color bellColor;
  final Color legColor;
  final Paint bellPaint;
  final Paint legPaint;

  BellsAndLegsPainter({
    this.bellColor = const Color(0xFF333333),
    this.legColor = const Color(0xFF555555)
  }) :
    bellPaint = Paint(),
    legPaint = Paint() {
    bellPaint.color = bellColor;
    bellPaint.style = PaintingStyle.fill;
    legPaint.color = legColor;
    legPaint.style = PaintingStyle.stroke;
    legPaint.strokeWidth = 10.0;
    legPaint.strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    canvas.save();

    canvas.translate(radius, radius);

    //draw the handle
    Path path = Path();
    path.moveTo(-60.0, -radius - 10);
    path.lineTo(-50.0, -radius - 50);
    path.lineTo(50.0, -radius - 50);
    path.lineTo(60.0, -radius - 10);

    canvas.drawPath(path, legPaint);

    //draw right bell and left leg
    canvas.rotate(2 * pi / 12);
    drawBellAndLeg(radius, canvas);

    //draw left bell and right leg
    canvas.rotate(-4 * pi / 12);
    drawBellAndLeg(radius, canvas);

    canvas.restore();
  }

  //helps draw the leg and bell
  void drawBellAndLeg(radius, canvas) {
    //bell
    Path path1 = Path();
    path1.moveTo(-55.0, -radius - 5);
    path1.lineTo(55.0, -radius - 5);
    path1.quadraticBezierTo(0.0, -radius - 75, -55.0, -radius - 10);

    //leg
    Path path2 = Path();
    path2.addOval(Rect.fromCircle(center: Offset(0.0, -radius - 50), radius: 3.0));
    path2.moveTo(0.0, -radius - 50);
    path2.lineTo(0.0, radius + 20);

    //draw the bell on top on the leg
    canvas.drawPath(path2, legPaint);
    canvas.drawPath(path1, bellPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
