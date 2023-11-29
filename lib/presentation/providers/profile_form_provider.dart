import 'package:farrap/domain/entities/client_user.dart';
import 'package:farrap/infraestructure/models/preference_model.dart';
import 'package:farrap/presentation/providers/auth_provider.dart';
import 'package:farrap/presentation/providers/side_menu_provider.dart';
import 'package:farrap/presentation/shared/inputs/birthDate.dart';
import 'package:farrap/presentation/shared/inputs/confirm_password.dart';
import 'package:farrap/presentation/shared/inputs/email.dart';
import 'package:farrap/presentation/shared/inputs/firstName.dart';
import 'package:farrap/presentation/shared/inputs/lastName.dart';
import 'package:farrap/presentation/shared/inputs/userName.dart';
import 'package:farrap/presentation/shared/inputs/password.dart';
import 'package:farrap/presentation/widgets/gender_type.dart';
import 'package:farrap/presentation/widgets/side_menu.dart';
import 'package:farrap/presentation/widgets/user_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';


//! 3 - StateNotifierProvider - consume afuera
final profileFormProvider = StateNotifierProvider.autoDispose<ProfileFormNotifier,ProfileFormState>((ref) {

  final sideMenuCallback = ref.watch(sideMenuProvider.notifier).getCurrentPage;
  final editUserCallback = ref.watch(authProvider.notifier).editClientUser;
  // final getClientUserCallback = ref.watch(authProvider.notifier).getAuthenticatedClientUser;
  // final authenticatedUserType = ref.watch(authProvider.notifier).getAuthenticatedUserType;
  return ProfileFormNotifier(
    editUserCallback:editUserCallback,
    sideMenuCallback:sideMenuCallback,
    // getClientUserCallback : getClientUserCallback,
  );
});

typedef GetClientUserCallback = Future<ClientUser>Function(String token, String userId);



//! 2 - Como implementamos un notifier
class ProfileFormNotifier extends StateNotifier<ProfileFormState> {

  final Function(String, String, String, String, String, String, List<PreferenceModel>, UserType, GenderType) editUserCallback;
  final Function() sideMenuCallback;
  // final Function() getClientUserCallback;

  ProfileFormNotifier( {
    required this.editUserCallback,
    required this.sideMenuCallback,
  } 
  ): super( ProfileFormState() );

  onFirstNameChanged( String value ) {
    final newFirstName = FirstName.dirty(value);
    state = state.copyWith(
      firstName: newFirstName,
      isValid: Formz.validate([ newFirstName, state.password ])
    );
  }

  onLastNameChanged( String value ) {
    final newLastName = LastName.dirty(value);
    state = state.copyWith(
      lastName: newLastName,
      isValid: Formz.validate([ newLastName, state.password ])
    );
  }
  
  onUsernameChanged( String value ) {
    final newUsername = Username.dirty(value);
    state = state.copyWith(
      userName: newUsername,
      isValid: Formz.validate([ newUsername, state.password, state.userName])
    );
  }

  onPasswordChanged( String value ) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([ newPassword, state.userName ])
    );
  }

  onConfirmPasswordChanged( String value ) {

    final newPassword = ConfirmPassword.dirty(state.password.value, value);
    state = state.copyWith(
      confirmPassword: newPassword,
      isValid: Formz.validate([ newPassword, state.userName, state.password ])
    );

  }

  onEmailChanged( String value ) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([ newEmail, state.userName, state.password ])
    );
  }

  onBirthDateChanged( String value ) {
    final newBirthDate = BirthDate.dirty(value);
    state = state.copyWith(
      birthDate: newBirthDate,
      isValid: Formz.validate([ newBirthDate, state.userName, state.password ])
    );
  }

  onMusicPreferencesChanged( List<String> value ) {
    state = state.copyWith(
      musicPreferences: value,
      isValid: true
    );

  }

  onestablishmentPreferencesChanged(List<String> value) {
    state = state.copyWith(
      establishmentPreferences: value,
      isValid: true
    );
  }

  onUserTypeChanged( UserType value ) {
    state = state.copyWith(
      userType: value,
      isValid: true
    );
  }

  onGenderTypeChanged( GenderType value ) {
    state = state.copyWith(
      genderType: value,
      isValid: true
    );
  }

  onFormSubmit() async {
    _touchEveryField();

    if ( !state.isValid ) return;

    state = state.copyWith(isPosting: true);

    List<PreferenceModel> preferences = [];

    List<PreferenceModel> preferencesMusic = state.musicPreferences.map(
      (pref) => PreferenceModel(type: "M", name: pref))
      .toList();
    List<PreferenceModel> preferencesEstablishment = state.establishmentPreferences.map(
      (pref) => PreferenceModel(type: "E", name: pref))
      .toList();

    preferences.addAll(preferencesMusic);
    preferences.addAll(preferencesEstablishment);

    await editUserCallback( 
      state.firstName.value, 
      state.lastName.value, 
      state.userName.value,
      state.password.value, 
      state.email.value,
      state.birthDate.value,
      preferences,
      state.userType,
      state.genderType);

    state = state.copyWith(isPosting: false);
  }

  _touchEveryField() {
    final firstName    = FirstName.dirty(state.firstName.value);
    final lastName    = LastName.dirty(state.lastName.value);
    final userName = Username.dirty(state.userName.value);
    final password = Password.dirty(state.password.value);
    final confirmPassword = ConfirmPassword.dirty(state.password.value, state.confirmPassword.value);
    final email = Email.dirty(state.email.value);
    final birthDate = BirthDate.dirty(state.birthDate.value);

    state = state.copyWith(
      isFormPosted: true,
      firstName: firstName,
      lastName: lastName,
      userName: userName,
      password: password,
      confirmPassword: confirmPassword,
      email: email,
      birthDate: birthDate,
      isValid: Formz.validate([ firstName, lastName, userName, password, confirmPassword, email, birthDate ])
    );

  }

  onLoad(){

    // final user = await getClientUserCallback

    // state = state.copyWith(
    //   isFormPosted: true,
    //   firstName: firstName,
    //   lastName: lastName,
    //   userName: userName,
    //   password: password,
    //   confirmPassword: confirmPassword,
    //   email: email,
    //   birthDate: birthDate,
    //   isValid: Formz.validate([ firstName, lastName, userName, password, confirmPassword, email, birthDate ])
    // );
  }
}

//! 1 - State del provider
class ProfileFormState {

  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final FirstName firstName;
  final LastName lastName;
  final Username userName;
  final Password password;
  final Email email;
  final BirthDate birthDate;
  final List<String> musicPreferences;
  final List<String> establishmentPreferences;
  final ConfirmPassword confirmPassword;
  final UserType userType;
  final GenderType genderType;

  ProfileFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.firstName = const FirstName.pure(),
    this.lastName = const LastName.pure(),
    this.userName = const Username.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(""),
    this.email = const Email.pure(),
    this.birthDate = const BirthDate.pure(),
    this.musicPreferences =const  [] ,
    this.establishmentPreferences = const []  ,
    this.userType = UserType.client,
    this.genderType = GenderType.man,
  });

  ProfileFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    FirstName? firstName,
    LastName? lastName,
    Username? userName,
    Password? password,
    ConfirmPassword? confirmPassword,
    Email? email,
    BirthDate? birthDate,
    List<String>? musicPreferences,
    List<String>? establishmentPreferences,
    UserType? userType,
    GenderType? genderType,
  }) => ProfileFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    userName: userName ?? this.userName,
    password: password ?? this.password,
    confirmPassword: confirmPassword ?? this.confirmPassword,
    email: email ?? this.email,
    birthDate: birthDate ?? this.birthDate,
    musicPreferences: musicPreferences ?? this.musicPreferences,
    establishmentPreferences: establishmentPreferences ?? this.establishmentPreferences,
    userType: userType ?? this.userType,
    genderType: genderType ?? this.genderType,
  );

  @override
  String toString() {
    return '''
  LoginFormState:
    isPosting: $isPosting
    isFormPosted: $isFormPosted
    isValid: $isValid
    userName: $userName
    password: $password
''';
  }
}
