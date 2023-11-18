import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';
import 'package:time_range_picker/time_range_picker.dart';

final List<DayInWeek> _days =  [
    DayInWeek("Lun", dayKey: "monday"),
    DayInWeek("Mar", dayKey: "tuesday"),
    DayInWeek("Mie", dayKey: "wednesday"),
    DayInWeek("Jue", dayKey: "thursday"),
    DayInWeek("Vie", dayKey: "friday"),
    DayInWeek("Sab", dayKey: "saturday"),
    DayInWeek("Dom", dayKey: "sunday"),
    ];

class ServiceHoursSelector extends StatelessWidget  {
// REsultados del widget: result (atributo to string returns  TimeOfDay(start) to TimeOfDay(end))
//values: a list with strings of selected list

  final String openDate;
  final String closeDate;
  final List<String> weekDays;
  final Function(List<String>) onWeekDaysChanged; 
  final Function(List<String>) onScheduleChanged; 

  const ServiceHoursSelector({
    super.key, 
    required this.openDate, 
    required this.closeDate, 
    required this.weekDays, 
    required this.onWeekDaysChanged, 
    required this.onScheduleChanged});

  @override
  Widget build(BuildContext context) {

    final color = Theme.of(context);
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);

    return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SelectWeekDays(
                padding: 5,
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
                      color.primaryColor,
                      color.colorScheme.secondary,
                    ], // whitish to gray
                    tileMode:
                        TileMode.repeated, // repeats the gradient over the canvas
                  ),
                ),
                onSelect: onWeekDaysChanged,
              ),
            ),
            Center(
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.access_alarm),
                  onPressed: () => executeShowTimeRangePicker(context, localizations)
                ),
                ElevatedButton(
                  onPressed: () async {
                    executeShowTimeRangePicker(context, localizations);  
                  },
                   child: Text(convertStringToAMFormat(openDate, localizations))),
                const Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10),
                  child: Text(":"),
                ),
                ElevatedButton(onPressed: () {executeShowTimeRangePicker(context, localizations);}
                  , child: Text(convertStringToAMFormat(closeDate, localizations))),
              ],)
          ),
          ],
        );
  }

  executeShowTimeRangePicker(BuildContext context, MaterialLocalizations localizations) async {
    
    TimeRange? result = await showTimeRangePicker(
                context: context,
                start: convertStringToTimeOfDay(openDate),
                end: convertStringToTimeOfDay(closeDate),
                interval: const Duration(minutes: 10),
                use24HourFormat: false,
                fromText: "Hora de apertura",
                toText: "Hora de cierre",
                clockRotation: 180
              );

    if(result == null) return;         

    List<String> schedule = [
      getFormatTime(localizations, result.startTime, true),
      getFormatTime(localizations, result.endTime, true)
      ]; 
    onScheduleChanged(schedule);

  }

  String getFormatTime(MaterialLocalizations localizations, TimeOfDay time, bool use24HourFormat) {
    return localizations.formatTimeOfDay(
      time,
      alwaysUse24HourFormat: use24HourFormat
    );
  }

  String convertStringToAMFormat(String timeString, MaterialLocalizations localizations) {
  TimeOfDay timeOfDay =  convertStringToTimeOfDay(timeString);
  return getFormatTime(localizations, timeOfDay, false);
  }

  TimeOfDay convertStringToTimeOfDay(String timeString){
    List<String> parts = timeString.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);

    return TimeOfDay(hour: hours, minute: minutes);
  }

}