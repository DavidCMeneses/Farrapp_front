import 'package:farrap/infraestructure/models/preference_model.dart';
import 'package:farrap/infraestructure/models/schedule_model.dart';
import 'package:farrap/infraestructure/services/cloudinary_service.dart';
import 'package:farrap/infraestructure/services/cloudinary_service_impl.dart';
import 'package:farrap/presentation/providers/auth_provider.dart';
import 'package:farrap/presentation/shared/inputs/confirm_password.dart';
import 'package:farrap/presentation/shared/inputs/default_string.dart';
import 'package:farrap/presentation/shared/inputs/email.dart';
import 'package:farrap/presentation/shared/inputs/firstName.dart';
import 'package:farrap/presentation/shared/inputs/rut.dart';
import 'package:farrap/presentation/shared/inputs/userName.dart';
import 'package:farrap/presentation/shared/inputs/password.dart';
import 'package:farrap/presentation/widgets/user_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';


//! 3 - StateNotifierProvider - consume afuera
final establishmentRegisterFormProvider = StateNotifierProvider.autoDispose<EstablishmentRegisterFormNotifier,EstablishmentRegisterFormState>((ref) {

  final establishmentRegisterUserCallback = ref.watch(authProvider.notifier).establishmentRegisterUser;
  final cloudinaryService = CloudinaryServiceImpl();


  return EstablishmentRegisterFormNotifier(
    registerUserCallback:establishmentRegisterUserCallback,
    cloudinaryService: cloudinaryService
    
  );
});


//! 2 - Como implementamos un notifier
class EstablishmentRegisterFormNotifier extends StateNotifier<EstablishmentRegisterFormState> {

  final Function(String, String, String, String, String, String, String, String, String, String, List<PreferenceModel>, List<ScheduleModel>, UserType) registerUserCallback;
  final CloudinaryService cloudinaryService;

  EstablishmentRegisterFormNotifier({
    required this.registerUserCallback,
    required this.cloudinaryService
  }): super( EstablishmentRegisterFormState() );

  onNameChanged( String value ) {
    final newName = FirstName.dirty(value);
    state = state.copyWith(
      name: newName,
      isValid: Formz.validate([ newName, state.password ])
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

  onAddressChanged( String value ) {
    final newAddress = DefaultString.dirty(value);
    state = state.copyWith(
      address: newAddress,
      isValid: Formz.validate([ newAddress, state.password ])
    );
  }

  void onCityChanged( String? value ) {
    if (value == null) return ;
    final newCity = DefaultString.dirty(value);
    state = state.copyWith(
      city: newCity,
      isValid: Formz.validate([ newCity, state.password ])
    );
  }

  onDescriptionChanged( String value ) {
    final newDescription = DefaultString.dirty(value);
    state = state.copyWith(
      description: newDescription,
      isValid: Formz.validate([ newDescription, state.password ])
    );
  }

  onPlayistChanged( String value ) {
    final newPlaylist = DefaultString.dirty(value);
    state = state.copyWith(
      playlist: newPlaylist,
      isValid: Formz.validate([ newPlaylist, state.password ])
    );
  }

  onImgUrlChanged( String value ) {
    final newImgUrl = DefaultString.dirty(value);
    state = state.copyWith(
      imgUrl: newImgUrl,
      isValid: Formz.validate([ newImgUrl, state.password ])
    );
  }

  onRutChanged( String value ) {
    final newRut = RUT.dirty(value);
    state = state.copyWith(
      rut: newRut,
      isValid: Formz.validate([ newRut, state.password ])
    );
  }

  onEmailChanged( String value ) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([ newEmail, state.userName, state.password ])
    );
  }

  onMusicPreferencesChanged( List<String> value ) {
    state = state.copyWith(
      musicPreferences: value,
      isValid: true
    );

  }

  onEstablishmentPreferencesChanged(List<String> value) {
    state = state.copyWith(
      establishmentPreferences: value,
      isValid: true
    );
  }

  onWeekDaysChanged(List<String> value) {
    state = state.copyWith(
      weekDays: value,
      isValid: true
    );
  }

  onScheduleChanged(List<String> value) {
    state = state.copyWith(
      schedule: value,
      isValid: true
    );
  }

  onUserTypeChanged( UserType value ) {
    state = state.copyWith(
      userType: value,
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

    List<ScheduleModel> schedules = state.weekDays.map(
      (e) => ScheduleModel(
          day: e, 
          open: state.schedule[0], 
          close: state.schedule[1])).toList();

    preferences.addAll(preferencesMusic);
    preferences.addAll(preferencesEstablishment);

    final imgURL = await cloudinaryService.uploadPhoto(state.imgUrl.value, null);
    if (imgURL == null) return ; 

    await registerUserCallback( 
      state.name.value, 
      state.email.value,
      state.userName.value,
      state.password.value, 
      state.address.value,
      state.city.value,
      state.description.value,
      state.playlist.value,
      imgURL,
      state.rut.value,
      preferences,
      schedules,
      state.userType);

    state = state.copyWith(isPosting: false);
  }

  _touchEveryField() {
    final name    = FirstName.dirty(state.name.value);
    final userName = Username.dirty(state.userName.value);
    final password = Password.dirty(state.password.value);
    final confirmPassword = ConfirmPassword.dirty(state.password.value, state.confirmPassword.value);
    final email = Email.dirty(state.email.value);
    final address = DefaultString.dirty(state.address.value);
    final description = DefaultString.dirty(state.description.value);
    final rut = RUT.dirty(state.rut.value);
    final city = DefaultString.dirty(state.city.value);

    state = state.copyWith(
      isFormPosted: true,
      name: name,
      userName: userName,
      password: password,
      confirmPassword: confirmPassword,
      email: email,
      address: address,
      description: description,
      rut: rut,
      city: city,
      isValid: Formz.validate([ name, userName, password, confirmPassword, email, address, description, rut, city ])
    );

  }

}


//! 1 - State del provider
class EstablishmentRegisterFormState {

  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final FirstName name;
  final Username userName;
  final Password password;
  final Email email;
  final DefaultString address;
  final DefaultString city;
  final DefaultString description;
  final DefaultString playlist;
  final DefaultString imgUrl;
  final RUT rut;
  final List<String> musicPreferences;
  final List<String> establishmentPreferences;
  final List<String> weekDays;
  final List<String> schedule;
  final ConfirmPassword confirmPassword;
  final UserType userType;

  EstablishmentRegisterFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.name = const FirstName.pure(),
    this.userName = const Username.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(""),
    this.email = const Email.pure(),
    this.address = const DefaultString.pure(),
    this.city = const DefaultString.pure(),
    this.description = const DefaultString.pure(),
    this.playlist = const DefaultString.pure(),
    this.imgUrl = const DefaultString.pure(),
    this.rut = const RUT.pure(),
    this.musicPreferences =const  [] ,
    this.establishmentPreferences = const [] ,
    this.weekDays = const [] ,
    this.schedule = const ["17:00","6:00"] ,
    this.userType = UserType.establishment,
  });

  EstablishmentRegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    FirstName? name,
    Username? userName,
    Password? password,
    ConfirmPassword? confirmPassword,
    Email? email,
    DefaultString? address,
    DefaultString? city,
    DefaultString? description,
    DefaultString? playlist,
    DefaultString? imgUrl,
    RUT? rut,
    List<String>? musicPreferences,
    List<String>? establishmentPreferences,
    List<String>? weekDays,
    List<String>? schedule,
    UserType? userType,
  }) => EstablishmentRegisterFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    name: name ?? this.name,
    userName: userName ?? this.userName,
    password: password ?? this.password,
    confirmPassword: confirmPassword ?? this.confirmPassword,
    email: email ?? this.email,
    address: address ?? this.address,
    city: city ?? this.city,
    description: description ?? this.description,
    playlist: playlist ?? this.playlist,
    imgUrl: imgUrl ?? this.imgUrl,
    rut: rut ?? this.rut,
    musicPreferences: musicPreferences ?? this.musicPreferences,
    establishmentPreferences: establishmentPreferences ?? this.establishmentPreferences,
    weekDays: weekDays ?? this.weekDays,
    schedule: schedule ?? this.schedule,
    userType: userType ?? this.userType,
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
