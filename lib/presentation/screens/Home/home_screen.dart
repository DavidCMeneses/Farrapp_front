import 'package:farrap/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Text'),
        ),
        body: TextButton(
          onPressed: ref.read(authProvider.notifier).logout,
          child: const Text('Logout'),
        ));
  }
}
