import 'package:farrap/presentation/providers/pre_register_provider.dart';
import 'package:farrap/presentation/widgets/user_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PreRegisterScreen extends StatelessWidget {
  const PreRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: color.background,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            const SizedBox(height: 70),
            Text('Bienvenidx',
                style: TextStyle(color: color.secondary, fontSize: 40)),
            Text('a', style: TextStyle(color: color.secondary, fontSize: 30)),
            Text('Farrap',
                style: TextStyle(color: color.secondary, fontSize: 40)),
            const SizedBox(height: 70),
            Text('Yo soy',
                style: TextStyle(color: color.tertiary, fontSize: 20)),
            const _PreRegisterForm()
          ],
        ),
      ),
    );
  }
}

class _PreRegisterForm extends ConsumerWidget {

  const _PreRegisterForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final preRegisterForm = ref.watch(preRegisterFormProvider);

    return Column(children: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
          child: UserRadio(
            type: preRegisterForm.userType,
            onChanged:
                ref.read(preRegisterFormProvider.notifier).onUserTypeChanged,
          )),
      SizedBox(
          height: 60,
          width: double.infinity,
          child: FilledButton(
            onPressed: () {
              if (!preRegisterForm.isPosting) {
                switch(preRegisterForm.userType){
                  case UserType.establishment:
                    context.push('/establishmentRegister');
                    break;
                  case UserType.client:
                    context.push('/clientRegister');

                }               
              }
            },
            child: const Text('Siguiente'),
          )),
    ]);
  }
}
