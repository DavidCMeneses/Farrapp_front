import 'package:farrap/presentation/providers/auth_provider.dart';
import 'package:farrap/presentation/shared/inputs/userName.dart';
import 'package:farrap/presentation/shared/inputs/password.dart';
import 'package:farrap/presentation/widgets/user_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';


//! 3 - StateNotifierProvider - consume afuera
final loginFormProvider = StateNotifierProvider.autoDispose<LoginFormNotifier,LoginFormState>((ref) {

  final loginUserCallback = ref.watch(authProvider.notifier).loginUser;


  return LoginFormNotifier(
    loginUserCallback:loginUserCallback
  );
});


//! 2 - Como implementamos un notifier
class LoginFormNotifier extends StateNotifier<LoginFormState> {

  final Function(String, String, UserType) loginUserCallback;

  LoginFormNotifier({
    required this.loginUserCallback,
  }): super( LoginFormState() );
  
  onUsernameChanged( String value ) {
    final newUsername = Username.dirty(value);
    state = state.copyWith(
      userName: newUsername,
      isValid: Formz.validate([ newUsername, state.password ])
    );
  }

  onPasswordChanged( String value ) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([ newPassword, state.userName ])
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

    await loginUserCallback( state.userName.value, state.password.value, state.userType);

    state = state.copyWith(isPosting: false);
  }

  _touchEveryField() {

    final userName    = Username.dirty(state.userName.value);
    final password = Password.dirty(state.password.value);

    state = state.copyWith(
      isFormPosted: true,
      userName: userName,
      password: password,
      isValid: Formz.validate([ userName, password ])
    );

  }

}


//! 1 - State del provider
class LoginFormState {

  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Username userName;
  final Password password;
  final UserType userType;

  LoginFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.userName = const Username.pure(),
    this.password = const Password.pure(),
    this.userType = UserType.client
  });

  LoginFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Username? userName,
    Password? password,
    UserType? userType,
  }) => LoginFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    userName: userName ?? this.userName,
    password: password ?? this.password,
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
