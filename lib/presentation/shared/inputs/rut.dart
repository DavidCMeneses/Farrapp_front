import 'package:formz/formz.dart';

// Define input validation errors
enum RUTError { empty, format, lenght }

// Extend FormzInput and provide the input type and error type.
class RUT extends FormzInput<String, RUTError> {

  static final RegExp rutRegExp = RegExp(
    r'^[0-9]+$',
  );


  // Call super.pure to represent an unmodified form input.
  const RUT.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const RUT.dirty( super.value ) : super.dirty();


  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == RUTError.empty ) return 'El campo es requerido';
    if ( displayError == RUTError.lenght ) return 'El RUT debe ser de longitud 9';
    if ( displayError == RUTError.format ) return 'Revisa los caracteres ingresados';

    return null;
  }


  // Override validator to handle validating a given input value.
  @override
  RUTError? validator(String value) {

    if ( value.isEmpty || value.trim().isEmpty ) return RUTError.empty;
    if ( value.length != 9 ) return RUTError.lenght;
    if ( !rutRegExp.hasMatch(value) ) return RUTError.format;

    return null;
  }
}