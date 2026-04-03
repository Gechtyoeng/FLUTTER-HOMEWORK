import 'package:w6_homework/w10_homework/model/artist/comment.dart';
import 'package:w6_homework/w10_homework/model/songs/song.dart';

import '../../../model/artist/artist.dart';

abstract class ArtistRepository {
  Future<List<Artist>> getArtists({bool forceFetch = false});
  Future<Artist?> fetchArtistById(String id);
  Future<List<Song>> fetchArtistSong(String artistId);
  Future<List<Comment>> fetchArtistComments(String artistId);
  Future<Comment> addComment(Comment comment);
}
