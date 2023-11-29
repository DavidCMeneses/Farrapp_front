
import 'package:farrap/presentation/providers/auth_provider.dart';
import 'package:farrap/presentation/providers/login_form_provider.dart';
import 'package:farrap/presentation/widgets/custom_text_form_field.dart';
import 'package:farrap/presentation/widgets/user_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';



class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    //final size = MediaQuery.of(context).size;
    //final color = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child:  const Scaffold(
        body: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox( height: 200 ),
                  // Icon Banner
                  Text('Ingresar', 
                    style: TextStyle(
                      fontSize: 30)),
                  
                  SizedBox( height: 15 ),
                  
                  Text('Hola ¿Listo para pasarla genial?', 
                    style: TextStyle(
                      fontSize: 20)),
                  
                  SizedBox( height: 15 ),
                  
                  _LoginForm()
                  
                ],
              ),
            ),
          )
      ),
    );
  }
}

class _LoginForm extends ConsumerWidget {

  const _LoginForm();

  void showSnackbar( BuildContext context, String message ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final loginForm = ref.watch(loginFormProvider);

    ref.listen(authProvider, (previous, next) {
      if ( next.errorMessage.isEmpty ) return;
      showSnackbar( context, next.errorMessage );
    }); 

    return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: UserRadio(
              type: loginForm.userType,
              onChanged: ref.read(loginFormProvider.notifier).onUserTypeChanged,
            )//const _LoginForm(),
          ),
          const SizedBox( height: 15 ),

          CustomTextFormField(
            label: 'Usuario',
            keyboardType: TextInputType.emailAddress,
            onChanged: ref.read(loginFormProvider.notifier).onUsernameChanged,
            errorMessage: loginForm.isFormPosted ?
               loginForm.userName.errorMessage 
               : null,
            
          ),
          const SizedBox( height: 30 ),

          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            onChanged: ref.read(loginFormProvider.notifier).onPasswordChanged,
            errorMessage: loginForm.isFormPosted ?
               loginForm.password.errorMessage 
               : null,
            maxLines: 1,
            
          ),
    
          const SizedBox( height: 30 ),

          SizedBox(
            height: 60,
            width: double.infinity,
            child: FilledButton(
              onPressed: loginForm.isPosting
                ? null 
                : ref.read(loginFormProvider.notifier).onFormSubmit
,
              child: const Text('Ingresar'),
            )
              
          ),

          const SizedBox( height: 30 ),


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('¿No tienes cuenta?'),
              TextButton(
                onPressed: ()=> context.push('/pre_register'), 
                child: const Text('Crea una aquí')
              ) 
            ],
          ),


        ],
      );
  }
}