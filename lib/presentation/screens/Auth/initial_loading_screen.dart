import 'package:farrap/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InitialLoadingScreen extends ConsumerWidget {
  const InitialLoadingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.listen(authProvider, (previous, next) {
      if ( next.authStatus ==  AuthStatus.authenticated ) {
        Future.delayed(const Duration(seconds: 3), () {
          context.go('/');
        });
      }
      Future.delayed(const Duration(seconds: 3), () {
      context.go('/');
    });
    }); 

    
    final color = Theme.of(context).colorScheme;

    return  Scaffold(
      backgroundColor: color.background ,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            const SizedBox( height: 80 ),
            Text('FARRAP', style: TextStyle(color: color.primary, fontSize: 40) ),
            Text('SFP 2023', style: TextStyle(color: color.secondary, fontSize: 20)),
        
          ],
        ),
      ),
    );
  }
}