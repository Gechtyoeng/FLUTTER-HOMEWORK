import '../../../model/songs/song.dart';

abstract class SongRepository {
  Future<List<Song>> getSongs({bool forceFetch = false});
  Future<Song?> fetchSongById(String id);
  Future<void> likeSong(String id, int likeCount);

}
