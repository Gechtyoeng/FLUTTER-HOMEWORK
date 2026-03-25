import 'package:flutter/widgets.dart';
import 'package:w6_homework/w9_homework/model/artists/song_artist.dart';
import 'package:w6_homework/w9_homework/data/repositories/artists/artist_repository.dart';
import 'package:w6_homework/w9_homework/ui/utils/async_value.dart';

class ArtistViewModel extends ChangeNotifier {
  final ArtistRepository artistRepository;

  AsyncValue<List<SongArtist>> artistValue = AsyncValue.loading();

  ArtistViewModel({required this.artistRepository}) {
    init(); //fetch the artist
  }

  void init() async {
    fetchArtists();
  }

  // fetch all artist
  void fetchArtists() async {
    artistValue = AsyncValue.loading();
    notifyListeners();

    try {
      List<SongArtist> artists = await artistRepository.fetchArtists();

      artistValue = AsyncValue.success(artists);
    } catch (e) {
      artistValue = AsyncValue.error(e);
    }

    notifyListeners();
  }
}
