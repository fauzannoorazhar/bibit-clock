import 'dart:math';

import 'package:bibit_clock/bloc/clock_bloc/clock_bloc.dart';
import 'package:bibit_clock/painter/painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HourHand extends StatefulWidget {
  final int minute;
  final int hour;

  HourHand({required this.minute, required this.hour});

  @override
  State<HourHand> createState() => _HourHandState();
}

class _HourHandState extends State<HourHand> with SingleTickerProviderStateMixin {
  late double wheelSize;
  double degree = 0;
  int _valueChoose = 0;
  late double radius;
  late AnimationController ctrl;

  @override
  void initState() {
    wheelSize = 300;
    radius = wheelSize / 2;
    ctrl = AnimationController.unbounded(vsync: this);
    degree = 0;
    ctrl.value = degree;

    super.initState();
  }

  double degreeToRadians(double degrees) => degrees * (pi / 180);

  double roundToBase(double number, int base) {
    double reminder = number % base;
    double result = number;
    if (reminder < (base / 2)) {
      result = number - reminder;
    } else {
      result = number + (base - reminder);
    }
    return result;
  }

  _panUpdateHandler(DragUpdateDetails d) {
    bool onTop = d.localPosition.dy <= radius;
    bool onLeftSide = d.localPosition.dx <= radius;
    bool onRightSide = !onLeftSide;
    bool onBottom = !onTop;

    bool panUp = d.delta.dy <= 0.0;
    bool panLeft = d.delta.dx <= 0.0;
    bool panRight = !panLeft;
    bool panDown = !panUp;

    double yChange = d.delta.dy.abs();
    double xChange = d.delta.dx.abs();

    double verticalRotation = (onRightSide && panDown) || (onLeftSide && panUp) ? yChange : yChange * -1;
    double horizontalRotation = (onTop && panRight) || (onBottom && panLeft) ? xChange : xChange * -1;
    double rotationalChange = verticalRotation + horizontalRotation;
    double _value = degree + (rotationalChange / 5);

    setState(() {
      degree = _value > 0 ? _value : 0;
      ctrl.value = degree;
      var a = degree < 360 ? degree.roundToDouble() : degree - 360;
      var degrees = roundToBase(a.roundToDouble(), 10);
      _valueChoose = degrees ~/ 30 == 12 ? 0 : degrees ~/ 30;
      BlocProvider.of<ClockBloc>(context).add(ClockEventSetHour(_valueChoose));
    });
  }

  _panEndHandler(DragEndDetails d) {
    var a = degree < 360 ? degree.roundToDouble() : degree - 360;
    ctrl.animateTo(roundToBase(a.roundToDouble(), 10),
        duration: const Duration(milliseconds: 551), curve: Curves.easeOutBack)
        .whenComplete(() { setState(() {
        degree = roundToBase(a.roundToDouble(), 10);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    GestureDetector draggableHour = GestureDetector(
      onPanUpdate: _panUpdateHandler,
      onPanEnd: _panEndHandler,
      child: Container(
        height: radius * 2,
        width: radius * 2,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        child: Align(
          child: AnimatedBuilder(
            animation: ctrl,
            builder: (ctx, w) {
              return Transform.rotate(
                angle: degreeToRadians(ctrl.value),
                child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20.0),
                      child: CustomPaint(painter: HourHandPainter(hours: widget.hour, minutes: widget.minute)),
                    )
                ),
              );
            },
          ),
        ),
      ),
    );

    return draggableHour;
  }
}
