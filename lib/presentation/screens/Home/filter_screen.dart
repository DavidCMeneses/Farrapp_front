import 'package:farrap/presentation/widgets/custom_checkbox.dart';
import 'package:farrap/presentation/widgets/custom_switch.dart';
import 'package:farrap/presentation/widgets/custom_text_dropdown_field.dart';
import 'package:farrap/presentation/widgets/custom_wrap_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text('Filtros')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            const CustomSwitch(
              label: 'Filtrar por preferencias',
              value: true,
            ),
            CustomWrapChip(
              label: 'Filtrar por música',
              chipText: const ["rock", "jazz", "clfas", "dsads", "rock"],
              width: size.width - 40,
              height: 120,
              selectedChipList: [],
              onSelectChanged: (l) {},
            ),
            CustomWrapChip(
              label: 'Filtrar por establecimiento',
              chipText: const ["bar", "gastrobar", "club", "dsads", "rock"],
              width: size.width - 40,
              height: 120,
              selectedChipList: [],
              onSelectChanged: (l) {},
            ),
            CustomCheckBox(),
            const SizedBox(height: 50,),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: FilledButton(
                onPressed: () {},
                child: const Text('Confirmar'),
              )),
          ]),
        ),
      ),
    );
  }
}
