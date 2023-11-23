
import 'package:farrap/infraestructure/models/preference_model.dart';
import 'package:farrap/infraestructure/models/schedule_model.dart';
import 'package:farrap/presentation/widgets/user_type.dart';

class EstablishmentUser {
  final String name;
  final String email;
  final String username;
  final String password; 
  final String address; 
  final String city; 
  final String description; 
  final String rut;
  final List<PreferenceModel> preferences;
  final List<ScheduleModel> schedules;
  final String playlist;
  final String imgUrl;
  final UserType userType;

  EstablishmentUser({
    required this.name, 
    required this.email, 
    required this.username, 
    required this.password, 
    required this.address, 
    required this.city, 
    required this.description, 
    required this.rut, 
    required this.preferences, 
    required this.schedules, 
    required this.playlist, 
    required this.imgUrl, 
    required this.userType});

 
}