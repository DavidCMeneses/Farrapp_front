import 'package:farrap/presentation/widgets/custom_bottom_home.dart';
import 'package:flutter/material.dart';

class EstablishmentProfileScreen extends StatelessWidget {
  const EstablishmentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Placeholder(),
      bottomNavigationBar: CustomBottomHome(currentIndex: 1),
    );
  }
}