import 'package:farrap/presentation/providers/login_form_provider.dart';
import 'package:farrap/presentation/widgets/custom_text_form_field.dart';
import 'package:farrap/presentation/widgets/pending_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';



class EstablishmentRegisterScreen extends StatelessWidget {
  const EstablishmentRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child:  Scaffold(
        body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                        Text(
                            'Registrate',
                            style: TextStyle(
                              color: Color(0xFF303030),
                              fontSize: 36,
                              fontFamily: 'Reem Kufi',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        const Text(
                          'Rapido y Facil!',
                          style: TextStyle(
                            color: Color(0xFFA0A0A0),
                            fontSize: 14,
                            fontFamily: 'Reem Kufi',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),

                  const SizedBox( height: 100 ),
                  Container(
                    child: const _ERegisterForm(),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}

class _ERegisterForm extends ConsumerWidget {

  const _ERegisterForm();

  void showSnackbar( BuildContext context, String message ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final loginForm = ref.watch(loginFormProvider);

    return Column(
        children: [
          CustomTextFormField(
            label: 'Nombre del establecimiento',           
          ),
          const SizedBox( height: 30 ),

          CustomTextFormField(
            label: 'Correo',
            keyboardType: TextInputType.emailAddress,
            onChanged: ref.read(loginFormProvider.notifier).onEmailChange,
            errorMessage: loginForm.isFormPosted ?
               loginForm.email.errorMessage 
               : null,
            
          ),
          const SizedBox( height: 30 ),

          CustomTextFormField(
            label: 'Usuario',           
          ),
          const SizedBox( height: 30 ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: PendingWidget()//tipo de establecimiento(),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: PendingWidget()//Ciudad(),
          ),

          CustomTextFormField(
            label: 'Dirección',           
          ),
          const SizedBox( height: 30 ),

          CustomTextFormField(
            label: 'Rut',           
          ),
          const SizedBox( height: 30 ),

          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            onChanged: null,
            errorMessage: null,
            
          ),
          const SizedBox( height: 30 ),

          CustomTextFormField(
            label: 'Confirmar Contraseña',
            obscureText: true,
            onChanged: null,
            errorMessage: null,
            
          ),
    
          const SizedBox( height: 30 ),

          SizedBox(
            height: 60,
            width: double.infinity,
            child: FilledButton(
              onPressed: (){},
              child: const Text('Registrarse'),
            )
              
          ),

          const SizedBox( height: 100 ),


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('¿Tienes una cuenta?'),
              TextButton(
                onPressed: ()=> context.push('/login'), 
                child: const Text('Ingresar')
              ) 
            ],
          ),


        ],
      );
  }
}