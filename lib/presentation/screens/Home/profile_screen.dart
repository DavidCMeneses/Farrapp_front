import 'package:flutter/material.dart';
import 'package:farrap/presentation/widgets/custom_bottom_navigationbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Placeholder(),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: 2),
    );
  }
}
