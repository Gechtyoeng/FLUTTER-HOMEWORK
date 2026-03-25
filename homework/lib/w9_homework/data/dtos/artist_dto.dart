import 'package:w6_homework/w9_homework/model/artists/song_artist.dart';

class ArtistDto {
  static const String nameKey = 'name';
  static const String genreKey = 'genre';
  static const String imageUrlKey = 'imageUrl';

  /// convert data from json to artist model
  static SongArtist fromJson(String id, Map<String, dynamic> json) {
    assert(json[nameKey] is String);
    assert(json[genreKey] is String);
    assert(json[imageUrlKey] is String);

    return SongArtist(id: id, name: json[nameKey], gener: json[genreKey], imageUrl: Uri.parse(json[imageUrlKey]));
  }

  /// convert from model to json
  Map<String, dynamic> toJson(SongArtist artist) {
    return {nameKey: artist.name, genreKey: artist.gener, imageUrlKey: artist.imageUrl};
  }
}
