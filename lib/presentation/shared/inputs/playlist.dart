import 'package:formz/formz.dart';

// Define input validation errors
enum PlaylistError { empty, format}

// Extend FormzInput and provide the input type and error type.
class Playlist extends FormzInput<String, PlaylistError> {

  static final RegExp playlistRegExp = RegExp(
    r'^https?://open\.spotify\.com/playlist/[a-zA-Z0-9]+'
  );
  // Call super.pure to represent an unmodified form input.
  const Playlist.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Playlist.dirty( super.value ) : super.dirty();


  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == PlaylistError.empty ) return 'El campo es requerido';
    if ( displayError == PlaylistError.format ) return 'Url inválida';
  
    return null;
  }


  // Override validator to handle validating a given input value.
  @override
  PlaylistError? validator(String value) {

    if ( value.isEmpty || value.trim().isEmpty ) return PlaylistError.empty;
    print(playlistRegExp.hasMatch(value));
    if ( !playlistRegExp.hasMatch(value) ) return PlaylistError.format;
    return null;
  }
}