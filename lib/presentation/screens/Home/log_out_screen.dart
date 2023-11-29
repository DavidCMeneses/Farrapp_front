import 'package:farrap/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogOutScreen extends ConsumerWidget {
  const LogOutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal:size.width / 4, vertical: size.height/4),
          child: SizedBox(
              height: 60,
              width: double.infinity,
              child: FilledButton(
                onPressed: ref.read(authProvider.notifier).logout,
                child: const Text('Cerrar Sesion'),
              )),
        ),
      ],
    );
  }
}
