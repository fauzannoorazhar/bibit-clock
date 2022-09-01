import 'dart:async';

import 'package:bibit_clock/screen/widget/clock.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'clock_event.dart';
part 'clock_state.dart';

class ClockBloc extends Bloc<ClockEvent, ClockState> {
  ClockBloc() : super(ClockState(dateTime: DateTime.now())) {
    on<ClockEvent>((event, emit) {
      if (event is ClockEventSetHour) {
        final DateTime dateTime = state.dateTime;
        final DateTime newDateTime = DateTime(dateTime.year, dateTime.month, dateTime.day, event.hour, dateTime.minute);

        emit(state.copyWith(dateTime: newDateTime, clockMove: true));
      }

      if (event is ClockEventSetMinute) {
        final DateTime dateTime = state.dateTime;
        final DateTime newDateTime = DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour, event.minute);

        emit(state.copyWith(dateTime: newDateTime, clockMove: true));
      }
    });
  }
}
