import 'package:farrap/presentation/providers/establishment_id_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomBottomHome extends ConsumerWidget {
  final int currentIndex;

  const CustomBottomHome({super.key, required this.currentIndex});

  void onItemTapped(BuildContext context, int index, WidgetRef ref) {
    
    switch (index) {
      case 0:
        final establishmentId = ref.read( establishmentIdProvider ).getValue<int>('id')
        .then((value) => context.go('/establishment/home/${value}'));
                                  
        break;
      case 1:
        context.go('/establishment_profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) => onItemTapped(context, value, ref),
        elevation: 0,
        selectedItemColor: colors.primary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_max), 
            label: 'Inicio'),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box), 
            label: 'Cuenta'),
        ]
      );
  }
}
