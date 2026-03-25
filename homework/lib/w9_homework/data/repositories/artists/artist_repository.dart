import 'package:w6_homework/w9_homework/model/artists/song_artist.dart';

abstract class ArtistRepository {
  Future<List<SongArtist>> fetchArtists();
}
