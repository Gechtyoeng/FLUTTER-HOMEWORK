import 'package:flutter/widgets.dart';
import 'package:w6_homework/data/repositories/songs/song_repository.dart';
import 'package:w6_homework/model/songs/song.dart';
import 'package:w6_homework/ui/states/player_state.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;

  LibraryViewModel({required this.songRepository, required this.playerState});
  List<Song> _songs = [];
  List<Song> get songs => _songs;

  Song? get currentSong => playerState.currentSong;

  void init() {
    _songs = songRepository.fetchSongs();
    playerState.addListener(() {
      notifyListeners();
    });
    notifyListeners();
  }

  void play(Song song) {
    playerState.start(song);
  }

  void stop() {
    playerState.stop();
  }
}
