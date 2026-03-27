import 'package:w6_homework/w9_homework/model/artists/artist.dart';
import 'package:w6_homework/w9_homework/model/songs/song.dart';

class SongWithArtist {
  final Song song;
  final Artist artist;

  SongWithArtist({required this.artist, required this.song});
}
