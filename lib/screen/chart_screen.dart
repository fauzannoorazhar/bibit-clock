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
        fillColorFn: (Alarm series, _) => chart.ColorUtil.fromDartColor(
          const Color(0xFFBFBDBD),
        ),
        patternColorFn: (Alarm series, _) => chart.ColorUtil.fromDartColor(
          const Color(0xFFFFFFFF),
        ),
        areaColorFn: (Alarm series, _) => chart.ColorUtil.fromDartColor(
          const Color(0xFFFFFFFF),
        ),
        seriesColor: chart.Color.fromHex(code: 'FFFFFFF'),
        domainFn: (Alarm series, _) => series.notif!,
        measureFn: (Alarm series, _) => series.second,
        colorFn: (Alarm series, _) => chart.ColorUtil.fromDartColor(
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    child: const Icon(Icons.close),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Expanded(
                    child: Text(
                      'Bar Chart',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
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
