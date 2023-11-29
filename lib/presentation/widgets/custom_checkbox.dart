import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({super.key});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

enum Filter { asc, rating, dec}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool wantsBreakfast = true;
  Filter selectedFilter = Filter.asc;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('Ordenar por:'),
      children: [
        RadioListTile(
          title: const Text('Alfabeticamente ascendente'),
          value: Filter.asc,
          groupValue: selectedFilter,
          onChanged: (value) => setState(() {
            selectedFilter = Filter.asc;
          }),
        ),
        RadioListTile(
          title: const Text('Alfabeticamente descendente'),
          value: Filter.dec,
          groupValue: selectedFilter,
          onChanged: (value) => setState(() {
            selectedFilter = Filter.dec;
          }),
        ),
        RadioListTile(
          title: const Text('Rating'),
          value: Filter.rating,
          groupValue: selectedFilter,
          onChanged: (value) => setState(() {
            selectedFilter = Filter.rating;
          }),
        ),
      ],
    );
  }
}
