import 'package:charts_flutter/flutter.dart';

class Alarm {
  Alarm({
    this.notif,
    required this.second,
    required this.dateTime,
  });

  late Color color;
  late final String? notif;
  late final int second;
  late final String dateTime;

  Alarm.fromJson(Map<String, dynamic> json){
    notif = json['notif'];
    second = json['second'];
    dateTime = json['date_time'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['notif'] = notif;
    _data['second'] = second;
    _data['date_time'] = dateTime;
    return _data;
  }
}