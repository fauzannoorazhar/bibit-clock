import 'package:bibit_clock/bloc/clock_bloc/clock_bloc.dart';
import 'package:bibit_clock/model/alarm.dart';
import 'package:bibit_clock/screen/chart_screen.dart';
import 'package:bibit_clock/util/notification_api_listener.dart';
import 'package:bibit_clock/screen/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charts_flutter/flutter.dart' as chart;
import 'package:shared_preferences/shared_preferences.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({Key? key}) : super(key: key);

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  bool isActived = false, isAm = true, isSelected = false;
  List<bool> isSelectedTime = List.generate(2, (index) => false);

  @override
  void initState() {
    NotificationApiListener.init();
    listenNotification();
    super.initState();
  }

  void listenNotification() => NotificationApiListener.listener.stream.listen(onClickNotification);

  void onClickNotification(String? payload) async {
    final Alarm alarm = Alarm(
      notif: payload,
      second: DateTime.now().difference(DateTime.parse(payload!)).inSeconds, dateTime: DateTime.now().toString()
    );
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: ChartScreen(
            listAlarm: [
              alarm
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClockBloc, ClockState>(
      builder: (context, ClockState clockState) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Clock(
                    circleColor: Colors.white,
                    dateTime: clockState.getInitialDate(),
                  ),
                ),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.center,
                  child: buildSetAlarmWidget(clockState),
                ),
                const SizedBox(height: 15),
                ElevatedButton.icon(
                  icon: const Icon(Icons.alarm_add),
                  label: const Text("Add Alarm", style: TextStyle(color: Colors.white)),
                  onPressed: (isSelected) ? () async {
                    NotificationApiListener.showNotificationSchedule(
                        title: 'Wake Up',
                        body: 'Your alarm is active',
                        payload: clockState.dateTime.toString(),//clockState.dateTime.toString(),
                        scheduleDate: clockState.dateTime,//clockState.dateTime,
                    );

                    final snackBar = SnackBar(
                      content: Text('Alarm has been set on ${clockState.getDateTimeFormat()}'),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  } : null,
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF0E3993),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildSetAlarmWidget(ClockState clockState) {
    return Column(
      children: [
        Text(clockState.getTimeFormat(),
            style: const TextStyle(fontSize: 50, fontWeight: FontWeight.w500)
        ),
        const SizedBox(height: 10),
        ToggleButtons(
          constraints: const BoxConstraints(
              minHeight: 30,
              minWidth: 100
          ),
          selectedColor: const Color(0xFF0E3993),
          children: const [
            Text(
              'AM',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15
              ),
            ),
            Text(
              'PM',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15
              ),
            )
          ],
          onPressed: (int index) {
            setState(() {
              isSelected = true;
              for (int buttonIndex = 0; buttonIndex < isSelectedTime.length; buttonIndex++) {
                if (buttonIndex == index) {
                  isAm = index == 0 ? true : false;
                  isActived = false;
                  isSelectedTime[buttonIndex] = true;
                  //NotificationApi.cancel();
                } else {
                  isSelectedTime[buttonIndex] = false;
                }
              }
            });
          },
          isSelected: isSelectedTime,
        ),
      ],
    );
  }
}
