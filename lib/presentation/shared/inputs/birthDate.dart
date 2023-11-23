import 'package:formz/formz.dart';

// Define input validation errors
enum BirthDateError { age }

// Extend FormzInput and provide the input type and error type.
class BirthDate extends FormzInput<String, BirthDateError> {

  // Call super.pure to represent an unmodified form input.
  const BirthDate.pure() : super.pure('2000-01-01');

  // Call super.dirty to represent a modified form input.
  const BirthDate.dirty( super.value ) : super.dirty();



  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == BirthDateError.age ) return 'Debes ser mayor de edad';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  BirthDateError? validator(String value) {
  
    // Convertir el string a DateTime
    DateTime birthDay = DateTime.parse(value);
    DateTime now = DateTime.now();

    int daysDifference = now.difference(birthDay).inDays;
    int yearDifference = (daysDifference / 365).floor();

    if ( yearDifference < 18 ) return BirthDateError.age;

    return null;
  }
}