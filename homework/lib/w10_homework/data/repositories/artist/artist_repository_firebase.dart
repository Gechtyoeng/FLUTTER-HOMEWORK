import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../model/artist/artist.dart';
import '../../dtos/artist_dto.dart';
import 'artist_repository.dart';

class ArtistRepositoryFirebase implements ArtistRepository {
  final Uri artistsUri = Uri.https('test-a2a77-default-rtdb.asia-southeast1.firebasedatabase.app', '/artists.json');

  List<Artist>? _catchArtists;

  Future<List<Artist>> fetchArtists() async {
    final http.Response response = await http.get(artistsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> songJson = json.decode(response.body);

      List<Artist> result = [];
      for (final entry in songJson.entries) {
        result.add(ArtistDto.fromJson(entry.key, entry.value));
      }
      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  //Get artists
  @override
  Future<List<Artist>> getArtists({bool forceFetch = false}) async {
    //1- return catch if avaliable
    if (!forceFetch && _catchArtists != null) {
      return _catchArtists!;
    }

    //2- fetch from api
    final List<Artist> artists = await fetchArtists();
    //3- store in memory
    _catchArtists = artists;

    return artists;
  }

  @override
  Future<Artist?> fetchArtistById(String id) async {}
}
