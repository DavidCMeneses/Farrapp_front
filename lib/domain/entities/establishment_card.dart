import 'package:farrap/domain/entities/current_song.dart';

class EstablishmentCard{
    final String name;
    final String address;
    final String city;
    final String preference;
    final double rating;
    final String imageUrl;
    final CurrentSongCard currentSong;

  EstablishmentCard({
    required this.name, 
    required this.address, 
    required this.city, 
    required this.preference, 
    required this.rating, 
    required this.imageUrl, 
    required this.currentSong
  });
}