import 'package:audioplayers/audioplayers.dart';
import 'package:farrap/domain/entities/current_song.dart';
import 'package:flutter/material.dart';

class PlaylistWidget extends StatefulWidget {
  final String playlistTitle;
  final List<CurrentSongCard> songs;

  const PlaylistWidget({super.key, required this.playlistTitle, required this.songs});

  @override
  State<PlaylistWidget> createState() => _PlaylistWidgetState();
}

class _PlaylistWidgetState extends State<PlaylistWidget> {

  late List<AudioPlayer> _audioPlayers;
  late List<bool> _isPlayingList;

  @override
  void initState() {
    super.initState();
    _audioPlayers = List.generate(widget.songs.length, (index) => AudioPlayer());
    _isPlayingList = List.generate(widget.songs.length, (index) => false); // Ajusta la longitud según sea necesario
  }

  @override
  void dispose() {
    for (var player in _audioPlayers) {
      player.dispose();
    }
    super.dispose();
  }

  void _playPause(int buttonIndex, String urlSong) {
    setState(() {
      for (int i = 0; i < _audioPlayers.length; i++) {
        if (i == buttonIndex) {
          if (_isPlayingList[i]) {
            _audioPlayers[i].pause();
          } else {
            _audioPlayers[i].play(UrlSource(urlSong));
          }
          _isPlayingList[i] = !_isPlayingList[i];
        } else {
          _audioPlayers[i].pause(); // Pausa los demás botones
          _isPlayingList[i] = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(delegate: SliverChildBuilderDelegate(
            (context, index) => SongItem(
              song: widget.songs[index],
              index: index,
              isPlaying: _isPlayingList[index],
              onPressed: _playPause,
              ),
            childCount: widget.songs.length
          ));
  }
}


class SongItem extends StatelessWidget {
  final CurrentSongCard song;
  final int index;
  final bool isPlaying;
  final Function(int, String) onPressed;
  

  const SongItem({
    super.key, 
    required this.song,
    required this.index,
    required this.isPlaying,
    required this.onPressed
    });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(song.name),
      subtitle: Text(song.author),
      trailing: IconButton(
        onPressed: () => onPressed(index, song.url),
        icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}
