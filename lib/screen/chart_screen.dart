import 'package:bibit_clock/model/alarm.dart';
import 'package:charts_flutter/flutter.dart' as chart;
import 'package:flutter/material.dart';

class ChartScreen extends StatefulWidget {
  final List<Alarm> listAlarm;

  const ChartScreen({required this.listAlarm, Key? key}) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  @override
  Widget build(BuildContext context) {
    List<chart.Series<Alarm, String>> series = [
      chart.Series(
        id: "notif",
        data: widget.listAlarm,
        domainFn: (Alarm series, _) => series.notif!,
        measureFn: (Alarm series, _) => series.second,
        colorFn: (Alarm series, _) =>  chart.ColorUtil.fromDartColor(
          const Color(0xFF0E3993),
        ),
      )
    ];

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Container(
          height: 400,
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const Text(
                'Bar Chart Time Open In Second',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: chart.BarChart(
                  series,
                  animate: true,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
