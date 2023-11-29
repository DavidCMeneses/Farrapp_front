import 'package:farrap/presentation/providers/establishment_view_provider.dart';
import 'package:farrap/presentation/providers/filter_provider.dart';
import 'package:farrap/presentation/widgets/custom_checkbox.dart';
import 'package:farrap/presentation/widgets/custom_switch.dart';
import 'package:farrap/presentation/widgets/custom_wrap_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final filterForm = ref.watch(filterProvider);

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
              ),
            CustomWrapChip(
              label: 'Filtrar por música',
              chipText: const ["rock", "jazz", "clfas", "dsads", "rock"],
              width: size.width - 40,
              height: 120,
              selectedChipList: filterForm.filterMusic,
              onSelectChanged: ref.read(filterProvider.notifier).onFilterMusicChange,
            ),
            CustomWrapChip(
              label: 'Filtrar por establecimiento',
              chipText: const ["bar", "gastrobar", "club", "dsads", "rock"],
              width: size.width - 40,
              height: 120,
              selectedChipList: filterForm.filterEstablishment,
              onSelectChanged: ref.read(filterProvider.notifier).onFilterEstablishmentChange,
            ),
            CustomCheckBox(
              selectedFilter: filterForm.sortType, 
              onChange: ref.read(filterProvider.notifier).onSortedChange),
            const SizedBox(height: 50,),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: FilledButton(
                onPressed: () async {
                  final filters = ref.read(filterProvider.notifier).onFormSubmit();
                  await ref.read(homeProvider.notifier)
                  .applyFilters(filters).then((value) => context.go("/" ));
                  
                },
                child: const Text('Confirmar'),
              )),
          ]),
        ),
      ),
    );
  }
}
