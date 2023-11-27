
import 'package:farrap/domain/entities/Playlist.dart';
import 'package:farrap/infraestructure/models/establishment_model.dart';


class Establishment{
  final String name;
  final String address;
  final String city;
  final String description;
  final double rating;
  final List<Preference> preferences;
  final String imageUrl;
  final Playlist playlist;
  final List<Schedule> schedule;
  final int userRating;

  Establishment({
    required this.name, 
    required this.address, 
    required this.city, 
    required this.description, 
    required this.rating,
    required this.preferences, 
    required this.imageUrl, 
    required this.playlist, 
    required this.schedule, 
    required this.userRating});

}