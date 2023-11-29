


import 'package:farrap/presentation/providers/auth_provider.dart';
import 'package:farrap/presentation/providers/profile_form_provider.dart';
import 'package:farrap/presentation/widgets/custom_form_birthday.dart';
import 'package:farrap/presentation/widgets/custom_text_form_field.dart';
import 'package:farrap/presentation/widgets/gender_type.dart';
import 'package:farrap/presentation/widgets/horizontal_chip_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen();

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final profileForm = ref.watch(profileFormProvider);

    ref.listen(authProvider, (previous, next) {
      if (next.errorMessage.isEmpty) return;
      showSnackbar(context, next.errorMessage);
    });

    return Column(
      children: [
        const SizedBox(height: 15),
        CustomTextFormField(
          label: 'Nombres',
          keyboardType: TextInputType.text,
          onChanged: ref.read(profileFormProvider.notifier).onFirstNameChanged,
          errorMessage: profileForm.isFormPosted
              ? profileForm.firstName.errorMessage
              : null,
        ),
        const SizedBox(height: 15),
        CustomTextFormField(
          label: 'Apellidos',
          keyboardType: TextInputType.text,
          onChanged: ref.read(profileFormProvider.notifier).onLastNameChanged,
          errorMessage: profileForm.isFormPosted
              ? profileForm.lastName.errorMessage
              : null,
        ),
        const SizedBox(height: 15),
        CustomTextFormField(
          label: 'Email',
          keyboardType: TextInputType.emailAddress,
          onChanged: ref.read(profileFormProvider.notifier).onEmailChanged,
          errorMessage:
              profileForm.isFormPosted ? profileForm.email.errorMessage : null,
        ),
        const SizedBox(height: 15),
        CustomTextFormField(
          label: 'Usuario',
          keyboardType: TextInputType.text,
          onChanged: ref.read(profileFormProvider.notifier).onUsernameChanged,
          errorMessage: profileForm.isFormPosted
              ? profileForm.userName.errorMessage
              : null,
        ),
        const SizedBox(height: 30),
        CustomTextFormField(
          label: 'Contraseña',
          obscureText: true,
          onChanged: ref.read(profileFormProvider.notifier).onPasswordChanged,
          errorMessage: profileForm.isFormPosted
              ? profileForm.password.errorMessage
              : null,
          maxLines: 1,
        ),
        const SizedBox(height: 30),
        CustomTextFormField(
          label: 'Confirmar contraseña',
          obscureText: true,
          onChanged:
              ref.read(profileFormProvider.notifier).onConfirmPasswordChanged,
          errorMessage: profileForm.isFormPosted
              ? profileForm.confirmPassword.errorMessage
              : null,
          maxLines: 1,
        ),
        const SizedBox(height: 15),
        BirthdayForm(
            birthDateInString: profileForm.birthDate.value,
            keyboardType: TextInputType.datetime,
            errorMessage: profileForm.isFormPosted
                ? profileForm.birthDate.errorMessage
                : null,
            onChanged:
                ref.read(profileFormProvider.notifier).onBirthDateChanged),
        const SizedBox(height: 15),
        GenderRadio(
            label: "Sexo",
            type: profileForm.genderType,
            onChanged:
                ref.read(profileFormProvider.notifier).onGenderTypeChanged),
        const SizedBox(height: 30),
        ChipList(
          label: 'Preferencias musicales',
          chipText: const ["rock", "jazz", "clfas", "dsads"],
          width: size.width - 40,
          selectedChipList: profileForm.musicPreferences,
          onSelectChanged:
              ref.read(profileFormProvider.notifier).onMusicPreferencesChanged,
        ),
        const SizedBox(height: 30),
        ChipList(
          label: 'Lugares de tu preferencia',
          chipText: const ["gastro bar", "disco", "bar", "dsads", "fdsafasfd"],
          width: size.width - 40,
          selectedChipList: profileForm.establishmentPreferences,
          onSelectChanged: ref
              .read(profileFormProvider.notifier)
              .onestablishmentPreferencesChanged,
        ),
        const SizedBox(height: 30),
        SizedBox(
            height: 60,
            width: size.width / 2,
            child: FilledButton(
              onPressed: profileForm.isPosting
                  ? null
                  : ref.read(profileFormProvider.notifier).onFormSubmit,
              child: const Text('Editar'),
            )),
        const SizedBox(height: 10),
      ],
    );
  }
}

