import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:w6_homework/w10_homework/config/firebase_config.dart';

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  final Uri songsUri = FirebaseConfig.baseUri.replace(path: '/songs.json');
  List<Song>? _cacheSongs;

  Future<List<Song>> fetchSongs() async {
    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> songJson = json.decode(response.body);

      List<Song> result = [];
      for (final entry in songJson.entries) {
        result.add(SongDto.fromJson(entry.key, entry.value));
      }
      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<List<Song>> getSongs({bool forceFetch = false}) async {
    //return cache if avaliable
    if (!forceFetch && _cacheSongs != null) {
      return _cacheSongs!;
    }
    //fetch from api
    List<Song> songs = await fetchSongs();
    //store in cache
    _cacheSongs = songs;

    return songs;
  }

  @override
  Future<Song?> fetchSongById(String id) async {}

  @override
  Future<void> likeSong(String id, int likeCount) async {
    final Uri songUri = FirebaseConfig.baseUri.replace(path: '/songs/$id.json');
    try {
      await http.patch(songUri, body: json.encode({'likeCount': likeCount}));
    } catch (e) {
      throw Exception('Failed to patch like count: $e');
    }
  }
}
