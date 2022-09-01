part of 'clock_bloc.dart';

@immutable
abstract class ClockEvent {}

class ClockEventSetHour extends ClockEvent {
  final int hour;

  ClockEventSetHour(this.hour);
}

class ClockEventSetMinute extends ClockEvent {
  final int minute;

  ClockEventSetMinute(this.minute);
}
