import 'package:farrap/presentation/providers/pre_register_provider.dart';
import 'package:farrap/presentation/providers/profile_form_provider.dart';
import 'package:farrap/presentation/providers/side_menu_provider.dart';
import 'package:farrap/presentation/screens/Home/edit_profile_screen.dart';
import 'package:farrap/presentation/screens/Home/log_out_screen.dart';
import 'package:farrap/presentation/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:farrap/presentation/widgets/custom_bottom_navigationbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  static const List<Widget> _widgetOptions = <Widget>[
    EditProfileScreen(),
    LogOutScreen()
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final currentPage = ref.watch(sideMenuProvider); 

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Perfil', style: TextStyle(fontSize: 30)),
        ),
      drawer: const SideMenu(),
        body: const SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center( child:EditProfileScreen(),),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavigation(currentIndex: 2),
      ),
    );
  }
}


