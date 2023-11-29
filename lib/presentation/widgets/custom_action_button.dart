import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomActionButton extends StatelessWidget {
  const CustomActionButton({super.key});

  @override
  Widget build(BuildContext context) {

    final color = Theme.of(context).colorScheme;

    return Container(
      height: 45,
      child: FloatingActionButton.extended(
          onPressed: () {context.push('/filter');},
          label: const Text('Filtrar', style: TextStyle(color: Colors.white),),
          backgroundColor: color.primary,
          icon: const Icon(Icons.filter_list_rounded, color: Colors.white,),
        ),
    );
  }
}
