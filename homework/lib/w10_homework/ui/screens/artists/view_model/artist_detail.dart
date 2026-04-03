import 'package:w6_homework/w10_homework/model/artist/artist.dart';
import 'package:w6_homework/w10_homework/model/artist/comment.dart';
import 'package:w6_homework/w10_homework/model/songs/song.dart';

class ArtistDetailData {
  final Artist artist;
  final List<Song> songs;
  final List<Comment> comments;

  ArtistDetailData({required this.artist, required this.songs, required this.comments});
}
