
import 'package:farrap/presentation/providers/auth_provider.dart';
import 'package:farrap/presentation/providers/register_form_provider.dart';
import 'package:farrap/presentation/widgets/custom_form_birthday.dart';
import 'package:farrap/presentation/widgets/custom_text_form_field.dart';
import 'package:farrap/presentation/widgets/gender_type.dart';
import 'package:farrap/presentation/widgets/horizontal_chip_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RegisterClientScreen extends StatelessWidget {
  const RegisterClientScreen({super.key});

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
                  SizedBox( height: 50 ),
                  // Icon Banner
                  Text('Registrate', 
                    style: TextStyle(
                      fontSize: 30)),
                  
                  SizedBox( height: 15 ),
                  
                  Text('Rápido y facil', 
                    style: TextStyle(
                      fontSize: 15)),
                  
                  SizedBox( height: 15 ),
                  
                  _RegisterForm()

                ],
              ),
            ),
          )
      ),
    );
  }
}

class _RegisterForm extends ConsumerWidget {

  const _RegisterForm();

  void showSnackbar( BuildContext context, String message ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final registerForm = ref.watch(registerFormProvider);

    ref.listen(authProvider, (previous, next) {
      if ( next.errorMessage.isEmpty ) return;
      showSnackbar( context, next.errorMessage );
    }); 

    return Column(
        children: [
          
          const SizedBox( height: 15 ),

          CustomTextFormField(
            label: 'Nombres',
            keyboardType: TextInputType.text,
            onChanged: ref.read(registerFormProvider.notifier).onFirstNameChanged,
            errorMessage: registerForm.isFormPosted ?
               registerForm.firstName.errorMessage 
               : null,
            
          ),
          const SizedBox( height: 15 ),

          CustomTextFormField(
            label: 'Apellidos',
            keyboardType: TextInputType.text,
            onChanged: ref.read(registerFormProvider.notifier).onLastNameChanged,
            errorMessage: registerForm.isFormPosted ?
               registerForm.lastName.errorMessage 
               : null,
            
          ),
          const SizedBox( height: 15 ),

          CustomTextFormField(
            label: 'Email',
            keyboardType: TextInputType.emailAddress,
            onChanged: ref.read(registerFormProvider.notifier).onEmailChanged,
            errorMessage: registerForm.isFormPosted ?
               registerForm.email.errorMessage 
               : null,
            
          ),
          const SizedBox( height: 15 ),
          CustomTextFormField(
            label: 'Usuario',
            keyboardType: TextInputType.text,
            onChanged: ref.read(registerFormProvider.notifier).onUsernameChanged,
            errorMessage: registerForm.isFormPosted ?
               registerForm.userName.errorMessage 
               : null,
            
          ),
          const SizedBox( height: 30 ),

          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            onChanged: ref.read(registerFormProvider.notifier).onPasswordChanged,
            errorMessage: registerForm.isFormPosted ?
               registerForm.password.errorMessage 
               : null,
            maxLines: 1,
            
          ),

          const SizedBox( height: 30 ),

          CustomTextFormField(
            label: 'Confirmar contraseña',
            obscureText: true,
            onChanged: ref.read(registerFormProvider.notifier).onConfirmPasswordChanged,
            errorMessage: registerForm.isFormPosted ?
               registerForm.confirmPassword.errorMessage 
               : null,
            maxLines: 1,
            
          ),


          const SizedBox( height: 15 ),
          BirthdayForm(
            birthDateInString: registerForm.birthDate.value, 
            keyboardType: TextInputType.datetime,
            errorMessage: registerForm.isFormPosted ?
               registerForm.birthDate.errorMessage 
               : null,
            onChanged: ref.read(registerFormProvider.notifier).onBirthDateChanged
            ),
          const SizedBox( height: 15 ),
          GenderRadio(
            label: "Sexo",
            type: registerForm.genderType, 
            onChanged: ref.read(registerFormProvider.notifier).onGenderTypeChanged),

          const SizedBox( height: 30 ),
          
          ChipList(
            label: 'Preferencias musicales', 
            chipText: ["rock","jazz", "clfas","dsads"], 
            width: size.width -40,
            selectedChipList: registerForm.musicPreferences,
            onSelectChanged: ref.read(registerFormProvider.notifier).onMusicPreferencesChanged,
            ),
          const SizedBox( height: 30 ),
          ChipList(
            label: 'Lugares de tu preferencia', 
            chipText: ["gastro bar","disco", "bar","dsads","fdsafasfd"], 
            width: size.width -40,
            selectedChipList: registerForm.establishmentPreferences,
            onSelectChanged: ref.read(registerFormProvider.notifier).onestablishmentPreferencesChanged,
            ),
          const SizedBox( height: 30 ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('¿ya tienes una cuenta?'),
              TextButton(
                onPressed: ()=> context.push('/login'), 
                child: const Text('Ingresa aquí')
              ) 
            ],
          ),

          const SizedBox( height: 10 ),
          SizedBox(
            height: 60,
            width: double.infinity,
            child: FilledButton(
              onPressed: registerForm.isPosting
                ? null 
                : ref.read(registerFormProvider.notifier).onFormSubmit
,
              child: const Text('Registrarse'),
            )
              
          ),

          const SizedBox( height: 10 ),

          


        ],
      );
  }
}