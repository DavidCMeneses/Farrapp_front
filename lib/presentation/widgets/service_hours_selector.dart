import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';
import 'package:farrap/presentation/widgets/time_range_selector.dart';

class ServiceHoursSelector extends StatelessWidget  {
// final String? label;
// final List<DayInWeek> selectedDays;
// final List<String> openingHour;
// final List<String> clossingHour;

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

    return Column(
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
        ],
      );
  }

}