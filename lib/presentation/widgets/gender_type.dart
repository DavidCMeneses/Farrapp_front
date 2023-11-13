import 'package:flutter/material.dart';

class GenderRadio extends StatefulWidget {
  final GenderType type;
  final Function(GenderType) onChanged;

  const GenderRadio({super.key, required this.type, required this.onChanged});

  @override
  State<GenderRadio> createState() => _GenderRadioState();
}

enum GenderType { man, woman, other }

class _GenderRadioState extends State<GenderRadio> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            width: 160,
            child: RadioListTile(
                title: const Text('Hombre'),
                value: GenderType.man,
                groupValue: widget.type,
                onChanged: (value) => widget.onChanged(value ?? widget.type)),
          ),
          Container(
            width: 160,
            child: RadioListTile(
                title: const Text('Mujer'),
                value: GenderType.woman,
                groupValue: widget.type,
                onChanged: (value) => widget.onChanged(value ?? widget.type)),
          ),
          Container(
            width: 160,
            child: RadioListTile(
                title: const Text('Otros'),
                value: GenderType.other,
                groupValue: widget.type,
                onChanged: (value) => widget.onChanged(value ?? widget.type)),
          )
        ],
      ),
    );
  }
}
