import 'package:flutter/material.dart';
import 'package:time_range/time_range.dart';

class TimeRangeSelector extends StatefulWidget {
  const TimeRangeSelector({Key? key}) : super(key: key);

  @override
  State<TimeRangeSelector> createState() => _TimeRangeSelectorState();
}

class _TimeRangeSelectorState extends State<TimeRangeSelector> {
  static const orange = Color(0xFFFE9A75);
  static const dark = Color(0xFF333A47);
  static const double leftPadding = 50;

  final _defaultTimeRange = TimeRangeResult(
    const TimeOfDay(hour: 17, minute: 00),
    const TimeOfDay(hour: 5, minute: 00),
  );
  TimeRangeResult? _timeRange;

  @override
  void initState() {
    super.initState();
    _timeRange = _defaultTimeRange;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16, left: leftPadding),
              child: Text(
                'Horas de servicio',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold, color: dark),
              ),
            ),
            TimeRange(
              fromTitle: const Text(
                'Hora de Apertura',
                style: TextStyle(
                  fontSize: 14,
                  color: dark,
                  fontWeight: FontWeight.w600,
                ),
              ),
              toTitle: const Text(
                'Hora de Cierre',
                style: TextStyle(
                  fontSize: 14,
                  color: dark,
                  fontWeight: FontWeight.w600,
                ),
              ),
              titlePadding: leftPadding,
              textStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                color: dark,
              ),
              activeTextStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: orange,
              ),
              borderColor: dark,
              activeBorderColor: dark,
              backgroundColor: Colors.transparent,
              activeBackgroundColor: dark,
              firstTime: const TimeOfDay(hour: 8, minute: 00),
              lastTime: const TimeOfDay(hour: 20, minute: 00),
              initialRange: _timeRange,
              timeStep: 30,
              timeBlock: 30,
              onRangeCompleted: (range) => setState(() => _timeRange = range),
              onFirstTimeSelected: (startHour) {},
            ),
            if (_timeRange != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: leftPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Rango Seleccionado: ${_timeRange!.start.format(context)} - ${_timeRange!.end.format(context)}',
                      style: const TextStyle(fontSize: 20, color: dark),
                    ),
                    MaterialButton(
                      onPressed: () =>
                          setState(() => _timeRange = _defaultTimeRange),
                      color: orange,
                      child: const Text('Default'),
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}