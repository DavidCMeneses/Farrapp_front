import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';
import 'package:farrap/presentation/widgets/time_range_selector.dart';
import 'package:time_range_picker/time_range_picker.dart';

class ServiceHoursSelector extends StatelessWidget  {
// REsultados del widget: result (atributo to string returns  TimeOfDay(start) to TimeOfDay(end))
//values: a list with strings of selected list

  final List<DayInWeek> _days =  [
    DayInWeek("Lun", dayKey: "monday"),
    DayInWeek("Mar", dayKey: "tuesday"),
    DayInWeek("Mie", dayKey: "wednesday"),
    DayInWeek("Jue", dayKey: "thursday"),
    DayInWeek("Vie", dayKey: "friday"),
    DayInWeek("Sab", dayKey: "saturday"),
    DayInWeek("Dom", dayKey: "sunday"),
    ];

  @override
  Widget build(BuildContext context) {
    final customWidgetKey = GlobalKey<SelectWeekDaysState>();

    SelectWeekDays selectWeekDays = SelectWeekDays(
      key: customWidgetKey,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      days: _days,
      border: false,
      width: MediaQuery.of(context).size.width / 1.4,
      boxDecoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(30.0),
      ),
      onSelect: (values) {
        print(values);
      },
    );

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SelectWeekDays(
              width: MediaQuery.of(context).size.width / 2,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              days: _days,
              border: false,
              boxDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  // 10% of the width, so there are ten blinds.
                  colors: [
                    Color.fromARGB(255, 234, 2, 79),
                    const Color.fromARGB(255, 62, 10, 87)
                  ], // whitish to gray
                  tileMode:
                      TileMode.repeated, // repeats the gradient over the canvas
                ),
              ),
              onSelect: (values) {
                print(values);
              },
            ),
          ),
          Center(
          child: IconButton(
            icon: Icon(Icons.access_alarm),
            onPressed: () async {
              TimeRange result = await showTimeRangePicker(
                context: context,
                start: TimeOfDay(hour: 17, minute: 00),
                end: TimeOfDay(hour: 6, minute: 00),
                interval: Duration(minutes: 30),
                use24HourFormat: false,
                fromText: "Hora de apertura",
                toText: "Hora de cierre",
                clockRotation: 180
              );
              print("result " + result.toString());
            },
          ),
        ),
        ],
      );
  }

}