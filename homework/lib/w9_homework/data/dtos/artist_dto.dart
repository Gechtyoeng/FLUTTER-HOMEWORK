import 'package:w6_homework/w9_homework/model/artists/artist.dart';

class ArtistDto {
  static const String nameKey = 'name';
  static const String genreKey = 'genre';
  static const String imageUrlKey = 'imageUrl';

  /// convert data from json to artist model
  static Artist fromJson(String id, Map<String, dynamic> json) {
    assert(json[nameKey] is String);
    assert(json[genreKey] is String);
    assert(json[imageUrlKey] is String);

    return Artist(id: id, name: json[nameKey], gener: json[genreKey], imageUrl: Uri.parse(json[imageUrlKey]));
  }

  /// convert from model to json
  Map<String, dynamic> toJson(Artist artist) {
    return {nameKey: artist.name, genreKey: artist.gener, imageUrlKey: artist.imageUrl};
  }
}
