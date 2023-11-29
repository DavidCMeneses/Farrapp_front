import 'package:flutter/material.dart';


enum GenderType { man, woman, other }

class GenderRadio extends StatelessWidget {
  final String label;
  final GenderType type;
  final Function(GenderType) onChanged;

  const GenderRadio({super.key, required this.label, required this.type, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
        SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(
              width: 160,
              child: RadioListTile(
                  title: const Text('Hombre'),
                  value: GenderType.man,
                  groupValue: type,
                  onChanged: (value) => onChanged(value ?? type)),
            ),
            SizedBox(
              width: 160,
              child: RadioListTile(
                  title: const Text('Mujer'),
                  value: GenderType.woman,
                  groupValue: type,
                  onChanged: (value) => onChanged(value ?? type)),
            ),
            SizedBox(
              width: 160,
              child: RadioListTile(
                  title: const Text('Otros'),
                  value: GenderType.other,
                  groupValue: type,
                  onChanged: (value) => onChanged(value ?? type)),
            )
          ],
        ),
      ),
      ]
    );
  }
}

