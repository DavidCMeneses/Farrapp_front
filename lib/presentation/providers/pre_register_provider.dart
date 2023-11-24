import 'package:farrap/presentation/widgets/user_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final preRegisterFormProvider = StateNotifierProvider.autoDispose<
    PreRegisterFormNotifier, PreRegisterFormState>((ref) {

  // preRegisterCallback(UserType userType){
  //   if(userType == UserType.establishment){
  //   return AuthState(authStatus: AuthStatus.onEstablishmentRegister);
  //   }
  //   return AuthState(authStatus: AuthStatus.onClientRegister);

  // }

  // final preRegisterCallback = ref.watch(authProvider.notifier).loginUser;


  return PreRegisterFormNotifier(
    preRegisterCallback: (UserType userType){}
    );
});

class PreRegisterFormNotifier extends StateNotifier<PreRegisterFormState> {
  final Function(UserType) preRegisterCallback;

  PreRegisterFormNotifier({
    required this.preRegisterCallback,
  }) : super(PreRegisterFormState());

  onUserTypeChanged(UserType value) {
    state = state.copyWith(
      userType: value,
    );
  }

  onFormSubmit() async {
    state = state.copyWith(isPosting: true);
    state = state.copyWith(isPosting: false);
  }
}

class PreRegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final UserType userType;

  PreRegisterFormState(
      {this.isPosting = false,
      this.isFormPosted = false,
      this.userType = UserType.client});

  PreRegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    UserType? userType,
  }) =>
      PreRegisterFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        userType: userType ?? this.userType,
      );

  @override
  String toString() {
    return '''
  PreRegisterFormState:
    isPosting: $isPosting
    isFormPosted: $isFormPosted
    userType: $userType
''';
  }
}
