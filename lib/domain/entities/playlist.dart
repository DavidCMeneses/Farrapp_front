
import 'package:farrap/domain/entities/current_song.dart';

class Playlist {

  final String name;
  final List<CurrentSongCard> songs;

  Playlist({required this.name, required this.songs});
  
}