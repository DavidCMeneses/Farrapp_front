import 'package:farrap/domain/entities/Playlist.dart';
import 'package:farrap/domain/entities/current_song.dart';
import 'package:farrap/domain/entities/establishment.dart';
import 'package:farrap/infraestructure/models/establishment_model.dart';

class EstablishmentMapper {


  static Establishment establishmentToEntity( EstablishmentModel establishment) => Establishment(
    name: establishment.name, 
    address: establishment.address, 
    city: establishment.city, 
    description: establishment.description, 
    rating: establishment.rating,
    userRating: establishment.userRating > 0 ? establishment.userRating : 3,
    preferences: establishment.preferences.map(
      (e) => Preference(type: e.type, name: e.name)
      ).toList(), 
    imageUrl: establishment.imageUrl, 
    playlist: Playlist(
      name: establishment.playlist.playlistName,
      songs: establishment.playlist.songs.map(
        (e) => CurrentSongCard(name: e.name, author: e.author, url: e.url?? "https://p.scdn.co/mp3-preview/948cf36c4175415fe6d318eead4b48545ea5dd74?cid=2ef223faabe64814b14d1721068497f9")).toList()
    ), 
    schedule: establishment.schedule.map(
      (e) => Schedule(day: e.day, open: e.open, close: e.close)).toList()
    );

}
