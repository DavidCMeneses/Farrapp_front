import 'package:flutter/material.dart';
import 'package:time_range_picker/time_range_picker.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: IconButton(
            icon: Icon(Icons.access_alarm),
            onPressed: () async {
              TimeRange result = await showTimeRangePicker(
                use24HourFormat: false,
                clockRotation: 180,
                context: context,
              );
              print("result " + result.toString());
            },
          ),
        ));
    
      }
}

