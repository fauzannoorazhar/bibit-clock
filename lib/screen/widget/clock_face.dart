import 'package:bibit_clock/screen/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:bibit_clock/painter/painter.dart';

class ClockFace extends StatelessWidget {
  final DateTime dateTime;

  ClockFace({required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.all(10.0),
                child: CustomPaint(
                  painter: ClockDialPainter(),
                ),
              ),
              Center(
                child: Container(
                  width: 10.0,
                  height: 10.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20.0),
                  child: Stack(
                    children: [
                      MinuteHand(minute: dateTime.minute, second: dateTime.second),
                      HourHand(minute: dateTime.minute, hour: dateTime.hour),
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
