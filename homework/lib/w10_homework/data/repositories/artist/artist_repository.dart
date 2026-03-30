import '../../../model/artist/artist.dart';

abstract class ArtistRepository {
  Future<List<Artist>> getArtists({bool forceFetch = false});
  Future<Artist?> fetchArtistById(String id);
}
