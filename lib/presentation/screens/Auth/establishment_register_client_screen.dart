
import 'package:farrap/config/constants/types.dart';
import 'package:farrap/presentation/providers/auth_provider.dart';
import 'package:farrap/presentation/providers/establishment_register_form_provider.dart';
import 'package:farrap/presentation/widgets/custom_text_dropdown_field.dart';
import 'package:farrap/presentation/widgets/custom_text_form_field.dart';
import 'package:farrap/presentation/widgets/horizontal_chip_selection.dart';
import 'package:farrap/presentation/widgets/service_hours_selector.dart';
import 'package:farrap/presentation/widgets/take_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EstablishmentRegisterScreen extends StatelessWidget {
  const EstablishmentRegisterScreen({super.key});

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
    final registerForm = ref.watch(establishmentRegisterFormProvider);

    ref.listen(authProvider, (previous, next) {
      if ( next.errorMessage.isEmpty ) return;
      showSnackbar( context, next.errorMessage );
    }); 

    return Column(
        children: [
          
          const SizedBox( height: 15 ),

          CustomTextFormField(
            label: 'Nombre del establecimiento',
            keyboardType: TextInputType.text,
            onChanged: ref.read(establishmentRegisterFormProvider.notifier).onNameChanged,
            errorMessage: registerForm.isFormPosted ?
               registerForm.name.errorMessage 
               : null,
            
          ),
          const SizedBox( height: 15 ),

          CustomTextFormField(
            label: 'Email',
            keyboardType: TextInputType.emailAddress,
            onChanged: ref.read(establishmentRegisterFormProvider.notifier).onEmailChanged,
            errorMessage: registerForm.isFormPosted ?
               registerForm.email.errorMessage 
               : null,
            
          ),
          const SizedBox( height: 15 ),
          CustomTextFormField(
            label: 'Usuario',
            keyboardType: TextInputType.text,
            onChanged: ref.read(establishmentRegisterFormProvider.notifier).onUsernameChanged,
            errorMessage: registerForm.isFormPosted ?
               registerForm.userName.errorMessage 
               : null,
            
          ),
          const SizedBox( height: 30 ),

          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            onChanged: ref.read(establishmentRegisterFormProvider.notifier).onPasswordChanged,
            errorMessage: registerForm.isFormPosted ?
               registerForm.password.errorMessage 
               : null,
            maxLines: 1,
            
          ),

          const SizedBox( height: 30 ),

          CustomTextFormField(
            label: 'Confirmar contraseña',
            obscureText: true,
            onChanged: ref.read(establishmentRegisterFormProvider.notifier).onConfirmPasswordChanged,
            errorMessage: registerForm.isFormPosted ?
               registerForm.confirmPassword.errorMessage 
               : null,
            maxLines: 1,
            
          ),

          const SizedBox( height: 15 ),
          DropdownInfo(
            label: 'Ciudad',
            width: size.width -40,
            dropList: cityList,
            onChange: ref.read(establishmentRegisterFormProvider.notifier).onCityChanged,
            errorMessage: registerForm.isFormPosted ?
               registerForm.city.errorMessage 
               : null,
            
          ),

          const SizedBox( height: 15 ),
          CustomTextFormField(
            label: 'Dirección',
            keyboardType: TextInputType.streetAddress,
            onChanged: ref.read(establishmentRegisterFormProvider.notifier).onAddressChanged,
            errorMessage: registerForm.isFormPosted ?
               registerForm.address.errorMessage 
               : null,
            
          ),

          const SizedBox( height: 15 ),
          CustomTextFormField(
            label: 'Descripción',
            keyboardType: TextInputType.multiline,
            onChanged: ref.read(establishmentRegisterFormProvider.notifier).onDescriptionChanged,
            errorMessage: registerForm.isFormPosted ?
               registerForm.description.errorMessage 
               : null,
            obscureText: false,
            maxLines: 3,
            
          ),

          const SizedBox( height: 15 ),
          CustomTextFormField(
            label: 'RUT',
            keyboardType: TextInputType.number,
            onChanged: ref.read(establishmentRegisterFormProvider.notifier).onRutChanged,
            errorMessage: registerForm.isFormPosted ?
               registerForm.rut.errorMessage 
               : null,
            
          ),

          ServiceHoursSelector(
            openDate: registerForm.schedule[0], 
            closeDate: registerForm.schedule[1], 
            weekDays: registerForm.weekDays, 
            onWeekDaysChanged: ref.read(establishmentRegisterFormProvider.notifier).onWeekDaysChanged, 
            onScheduleChanged: ref.read(establishmentRegisterFormProvider.notifier).onScheduleChanged),

          const SizedBox( height: 30 ),
          ChipList(
            label: 'Tipo de establecimiento', 
            chipText: const ["gastro bar","disco", "bar","dsads","fdsafasfd"], 
            width: size.width -40,
            selectedChipList: registerForm.establishmentPreferences,
            onSelectChanged: ref.read(establishmentRegisterFormProvider.notifier).onEstablishmentPreferencesChanged,
            ),
          const SizedBox( height: 30 ),
          
          ChipList(
            label: 'Música más sonada', 
            chipText: const ["rock","jazz", "clfas","dsads"], 
            width: size.width -40,
            selectedChipList: registerForm.musicPreferences,
            onSelectChanged: ref.read(establishmentRegisterFormProvider.notifier).onMusicPreferencesChanged,
            ),
          const SizedBox( height: 15 ),
          CustomTextFormField(
            label: 'Url playlist',
            keyboardType: TextInputType.url,
            onChanged: ref.read(establishmentRegisterFormProvider.notifier).onPlayistChanged,
            errorMessage: registerForm.isFormPosted ?
               registerForm.playlist.errorMessage 
               : null,
            maxLines: 1,
            
          ),

          const SizedBox( height: 30 ),

          TakePhoto(
            image: registerForm.imgUrl.value,
            onChangedImage: ref.read(establishmentRegisterFormProvider.notifier).onImgUrlChanged,
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
                : ref.read(establishmentRegisterFormProvider.notifier).onFormSubmit
,
              child: const Text('Registrarse'),
            )
              
          ),

          const SizedBox( height: 10 ),

          


        ],
      );
  }
}