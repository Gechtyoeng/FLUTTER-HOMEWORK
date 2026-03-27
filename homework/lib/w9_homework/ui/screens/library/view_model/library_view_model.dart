import 'package:flutter/material.dart';
import 'package:w6_homework/w9_homework/data/repositories/artists/artist_repository.dart';
import 'package:w6_homework/w9_homework/model/artists/artist.dart';
import 'package:w6_homework/w9_homework/model/songs/song_with_artist.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';
import '../../../utils/async_value.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;
  final ArtistRepository artistRepository;

  AsyncValue<List<SongWithArtist>> songsValue = AsyncValue.loading();

  LibraryViewModel({required this.songRepository, required this.playerState, required this.artistRepository}) {
    playerState.addListener(notifyListeners);

    // init
    _init();
  }

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    fetchSong();
  }

  void fetchSong() async {
    // 1- Loading state
    songsValue = AsyncValue.loading();
    notifyListeners();

    try {
      // 2- Fetch both songs and artists
      List<Song> songs = await songRepository.fetchSongs();
      List<Artist> artists = await artistRepository.fetchArtists();

      // create map
      final artistMap = {for (var artist in artists) artist.id: artist};

      //map the song with the artist
      List<SongWithArtist> results = [];

      for (var song in songs) {
        final artist = artistMap[song.artistId];

        if (artist != null) {
          results.add(SongWithArtist(song: song, artist: artist));
        }
      }

      songsValue = AsyncValue.success(results);
    } catch (e) {
      // 3- Fetch is unsucessfull
      songsValue = AsyncValue.error(e);
    }
    notifyListeners();
  }

  bool isSongPlaying(SongWithArtist songWithArtist) => playerState.currentSong == songWithArtist.song;

  void start(SongWithArtist songWithArtist) => playerState.start(songWithArtist.song);
  void stop(SongWithArtist songWithArtist) => playerState.stop();
}
