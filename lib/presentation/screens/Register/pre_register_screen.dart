import 'package:farrap/presentation/providers/login_form_provider.dart';
import 'package:farrap/presentation/widgets/user_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PreRegisterScreen extends ConsumerWidget {
  const PreRegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
     final preRegister = ref.watch(loginFormProvider);

    
    final color = Theme.of(context).colorScheme;

    return  Scaffold(
      backgroundColor: color.background ,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            const SizedBox( height: 70 ),
            Text('Bienvenidx', style: TextStyle(color: color.secondary, fontSize: 30) ),
            Text('a', style: TextStyle(color: color.secondary, fontSize: 20)),
            Text('Farrap', style: TextStyle(color: color.secondary, fontSize: 30) ),
            const SizedBox( height: 70 ),
            Text('Yo soy', style: TextStyle(color: color.tertiary, fontSize: 20)),
            const SizedBox( height: 20 ),
            UserRadio(
              type: preRegister.userType,
              onChanged: ref.read(loginFormProvider.notifier).onUserTypeChanged,
            ),
            const SizedBox( height: 20 ),
            SizedBox(
            height: 60,
            width: double.infinity,
            child: FilledButton(
              onPressed:  ref.read(loginFormProvider.notifier).state.userType == UserType.client
                ? context.go('/userRegister')
                : context.go('/esaRegister')
,
              child: const Text('Siguiente'),
            )
              
          )
          ],
        ),
      ),
    );
  }
}