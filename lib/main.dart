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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: ClockScreen(),
      ),
    );
  }
}
