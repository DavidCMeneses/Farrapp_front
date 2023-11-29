import 'package:farrap/presentation/widgets/user_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final preRegisterFormProvider = StateNotifierProvider.autoDispose<
    PreRegisterFormNotifier, PreRegisterFormState>((ref) {

  return PreRegisterFormNotifier();
});

class PreRegisterFormNotifier extends StateNotifier<PreRegisterFormState> {

  PreRegisterFormNotifier(): super(PreRegisterFormState());

  onUserTypeChanged(UserType value) {
    state = state.copyWith(
      userType: value,
    );
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
