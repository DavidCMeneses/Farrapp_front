import 'package:farrap/presentation/providers/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomSwitch extends ConsumerWidget {
  final String label;

  const CustomSwitch({
    super.key, 
    required this.label
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      child: Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.2,
                      //fontWeight: FontWeight.bold
                      ),
              ),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
            
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: Switch(
                  value: ref.watch(filterProvider).flag,
                  activeColor: Colors.blue,
                  onChanged: ref.read(filterProvider.notifier).onFlagChange,
                ),
              ),
            )
          ],
        ),
    );
  }
}
