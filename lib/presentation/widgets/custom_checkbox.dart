import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {

  final Filter selectedFilter;
  final Function(Filter?)? onChange;

  CustomCheckBox({super.key, required this.selectedFilter, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('Ordenar por:'),
      children: [
        RadioListTile(
          title: const Text('Alfabeticamente ascendente'),
          value: Filter.asc,
          groupValue: selectedFilter,
          onChanged: onChange
        ),
        RadioListTile(
          title: const Text('Alfabeticamente descendente'),
          value: Filter.dec,
          groupValue: selectedFilter,
          onChanged: onChange
        ),
        RadioListTile(
          title: const Text('Rating'),
          value: Filter.rating,
          groupValue: selectedFilter,
          onChanged: onChange
        ),
      ],
    );
  }
}

enum Filter { asc, rating, dec}

