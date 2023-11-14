
import 'package:farrap/infraestructure/models/preference_model.dart';
import 'package:farrap/presentation/widgets/gender_type.dart';
import 'package:farrap/presentation/widgets/user_type.dart';

class ClientUser {
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String birthDate;
  final String password;
  final List<PreferenceModel> preferences;
  final UserType userType;
  final GenderType genderType;

  ClientUser({
    required this.firstName,
    required this.lastName, 
    required this.username, 
    required this.email, 
    required this.password,
    required this.birthDate, 
    required this.preferences, 
    required this.userType, 
    required this.genderType});

}