import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigation({super.key, required this.currentIndex});

  void onItemTapped(BuildContext context, int index) {
    // context.go('');
    switch (index) {
      case 0:
        context.go('/');
        break;

      case 1:
        context.go('/search');
        break;

      case 2:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) => onItemTapped(context, value),
        elevation: 0,
        selectedItemColor: colors.primary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_max), 
            label: 'Inicio'),
          BottomNavigationBarItem(
            icon: Icon(Icons.search), 
            label: 'Buscar'),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box), 
            label: 'Cuenta'),
        ]
      );
  }
}
