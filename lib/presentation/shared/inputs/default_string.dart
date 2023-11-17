import 'package:formz/formz.dart';

// Define input validation errors
enum DefaultStringError { empty}

// Extend FormzInput and provide the input type and error type.
class DefaultString extends FormzInput<String, DefaultStringError> {

  // Call super.pure to represent an unmodified form input.
  const DefaultString.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const DefaultString.dirty( super.value ) : super.dirty();


  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == DefaultStringError.empty ) return 'El campo es requerido';
  
    return null;
  }


  // Override validator to handle validating a given input value.
  @override
  DefaultStringError? validator(String value) {

    if ( value.isEmpty || value.trim().isEmpty ) return DefaultStringError.empty;
    return null;
  }
}