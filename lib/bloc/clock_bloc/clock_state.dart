part of 'clock_bloc.dart';

class ClockState {
  final bool clockMove;
  final DateTime dateTime;

  ClockState({
    required this.dateTime,
    this.clockMove = false
  });

  ClockState copyWith({
    DateTime? dateTime,
    bool? clockMove,
  }) {
    return ClockState(
      dateTime: dateTime ?? this.dateTime,
      clockMove: clockMove ?? this.clockMove
    );
  }

  String getTimeFormat() {
    String hour = DateFormat('hh:mm').format(dateTime);

    return (clockMove) ? hour : '00:00';
  }

  DateTime getInitialDate() {
    return DateTime(dateTime.year, dateTime.month, dateTime.day, 12, 00);
  }

  String getDateTimeFormat(bool isAm) {
    return DateFormat('yyyy-MM-dd hh:mm a').format(getDateTime(isAm));
  }

  DateTime getDateTime(bool isAm) {
    DateTime now = dateTime;
    return DateTime(
      now.year,
      now.month,
      now.hour > (isAm ? now.hour : now.hour + 12) ? now.day + 1 : now.hour == (isAm ? now.hour : now.hour + 12) && now.minute >= now.minute && now.second > 0 ? now.day + 1 : now.day, isAm ? now.hour : now.hour + 12,
      now.minute
    );
  }
}