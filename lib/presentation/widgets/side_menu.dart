import 'package:farrap/presentation/providers/profile_form_provider.dart';
import 'package:farrap/presentation/providers/side_menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SideMenu extends ConsumerWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref ) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/Farrap_Logo_Color.png'),
                    ),
                    ),
            child: Text(
              'Cuenta',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.portrait),
            title: const Text('Perfil'),
            onTap: () => {
              ref.read(sideMenuProvider.notifier).onPageChanged(0),
              Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Salir'),
            onTap: () => {
              ref.read(sideMenuProvider.notifier).onPageChanged(1),
              Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}