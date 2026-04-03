import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:w6_homework/w10_homework/config/firebase_config.dart';
import 'package:w6_homework/w10_homework/data/dtos/comment_dto.dart';
import 'package:w6_homework/w10_homework/data/dtos/song_dto.dart';
import 'package:w6_homework/w10_homework/model/artist/comment.dart';
import 'package:w6_homework/w10_homework/model/songs/song.dart';
import '../../../model/artist/artist.dart';
import '../../dtos/artist_dto.dart';
import 'artist_repository.dart';

class ArtistRepositoryFirebase implements ArtistRepository {
  final Uri artistsUri = FirebaseConfig.baseUri.replace(path: '/artists.json');
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
  Future<Artist?> fetchArtistById(String id) async {
    final Uri artistsUri = FirebaseConfig.baseUri.replace(path: '/artists/$id.json');
    final http.Response response = await http.get(artistsUri);
    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      if (decoded == null) return null;

      return ArtistDto.fromJson(id, decoded);
    } else {
      throw Exception('faile to fetch artist with if $id');
    }
  }

  @override
  Future<List<Comment>> fetchArtistComments(String artistId) async {
    final Uri uri = FirebaseConfig.baseUri.replace(path: '/comments/$artistId.json');

    final http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);

      if (decoded == null) return [];

      Map<String, dynamic> data = decoded;
      List<Comment> result = [];

      for (final entry in data.entries) {
        result.add(CommentDto.fromJson(entry.key, entry.value));
      }

      return result;
    } else {
      throw Exception('Failed to load comments');
    }
  }

  @override
  @override
  Future<List<Song>> fetchArtistSong(String artistId) async {
    final Uri uri = FirebaseConfig.baseUri.replace(path: '/songs.json');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      if (decoded == null) return [];

      Map<String, dynamic> data = decoded;
      List<Song> result = [];

      for (final entry in data.entries) {
        final song = SongDto.fromJson(entry.key, entry.value);

        if (song.artistId == artistId) {
          result.add(song);
        }
      }

      return result;
    } else {
      throw Exception('Failed to load songs');
    }
  }

  @override
  Future<Comment> addComment(Comment comment) async {
    final Uri uri = FirebaseConfig.baseUri.replace(path: '/comments/${comment.artistId}.json');

    final response = await http.post(uri, body: json.encode(CommentDto.toJson(comment)));

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final String id = decoded['name'];

      return Comment(id: id, artistId: comment.artistId, comment: comment.comment);
    } else {
      throw Exception('Failed to add comment');
    }
  }
}
