import 'dart:convert';

import 'package:w6_homework/w9_homework/data/dtos/artist_dto.dart';
import 'package:w6_homework/w9_homework/data/repositories/artists/artist_repository.dart';
import 'package:w6_homework/w9_homework/model/artists/song_artist.dart';
import 'package:http/http.dart' as http;

class ArtistRepositoryFirebase extends ArtistRepository {
  final Uri artistUri = Uri.http('w9-database-81acf-default-rtdb.asia-southeast1.firebasedatabase.app', '/artists.json');

  @override
  Future<List<SongArtist>> fetchArtists() async {
    final http.Response response = await http.get(artistUri);

    if (response.statusCode == 200) {
      Map<String, dynamic> artistJson = json.decode(response.body);
      List<SongArtist> artists = [];

      for (var artist in artistJson.entries) {
        artists.add(ArtistDto.fromJson(artist.key, artist.value));
      }
      return artists;
    } else {
      throw Exception('Fial to laod artist');
    }
  }
}
