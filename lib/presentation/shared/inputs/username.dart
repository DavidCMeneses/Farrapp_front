import 'package:formz/formz.dart';

// Define input validation errors
enum UsernameError { empty, length, format }

// Extend FormzInput and provide the input type and error type.
class Username extends FormzInput<String, UsernameError> {


  static final RegExp passwordRegExp = RegExp(
    r'^[a-zA-Z0-9]+$',
  );

  // Call super.pure to represent an unmodified form input.
  const Username.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Username.dirty( String value ) : super.dirty(value);


  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == UsernameError.empty ) return 'El campo es requerido';
    if ( displayError == UsernameError.length ) return 'Mínimo 4 caracteres';
    if ( displayError == UsernameError.format ) return 'Solo se permiten caracteres alfanuméricos';

    return null;
  }


  // Override validator to handle validating a given input value.
  @override
  UsernameError? validator(String value) {

    if ( value.isEmpty || value.trim().isEmpty ) return UsernameError.empty;
    if ( value.length < 4 ) return UsernameError.length;
    if ( !passwordRegExp.hasMatch(value) ) return UsernameError.format;

    return null;
  }
}