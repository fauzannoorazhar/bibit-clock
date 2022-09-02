import 'dart:async';

import 'package:bibit_clock/bloc/clock_bloc/clock_bloc.dart';
import 'package:bibit_clock/screen/clock_screen.dart';
import 'package:bibit_clock/screen/history_screen.dart';
import 'package:bibit_clock/screen/widget/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:timezone/data/latest.dart' as timeZone;

void main() {
  timeZone.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    BlocProvider(
      create: (context) => ClockBloc(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: RemoveScrollGlowBehavior(),
          child: child!,
        );
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: ClockScreen(),
      ),
    );
  }
}

class RemoveScrollGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}