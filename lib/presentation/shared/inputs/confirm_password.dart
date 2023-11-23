import 'package:formz/formz.dart';

enum PasswordError { notEqual }

class ConfirmPassword extends FormzInput<String, PasswordError> {
  final String password;

  const ConfirmPassword.pure(this.password) : super.pure('');
  const ConfirmPassword.dirty(this.password, [String value = '']) : super.dirty(value);

  @override
  PasswordError? validator(String value) {
    // Validar la confirmación de la contraseña
    if (value != password) {
      return PasswordError.notEqual;
    }
    return null;
  }

  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == PasswordError.notEqual ) return 'Las contraseñas no coinciden';
  
    return null;
  }


}