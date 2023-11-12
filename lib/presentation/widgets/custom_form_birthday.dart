import 'package:flutter/material.dart';

class _BirthdayForm extends StatefulWidget {
  String birthDateInString =
      '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';

  @override
  State<_BirthdayForm> createState() => _BirthdayFormState();
}

class _BirthdayFormState extends State<_BirthdayForm> {
  @override
  Widget build(BuildContext context) {
    DateTime birthDate = DateTime.utc(1989, 11, 9);
    return GestureDetector(
        child: Wrap(
          spacing: 10,
          children: [
            const Icon(Icons.calendar_today),
            TextFormField(
              enabled: false,
              keyboardType: TextInputType.datetime,
              style: const TextStyle(color: Colors.grey),
              decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  hintText: 'Enter a search term',
                  label: Text(widget.birthDateInString)),
            )
          ],
        ),
        onTap: () async {
          final datePick = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now());
          if (datePick != null && datePick != birthDate) {
            birthDate = datePick;

            // put it here
            widget.birthDateInString =
                "${birthDate.day}/${birthDate.month}/${birthDate.year}"; // 08/14/2019
            setState(() {});
          }
        });
  }
}
