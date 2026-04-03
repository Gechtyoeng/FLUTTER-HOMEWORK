import 'package:w6_homework/w10_homework/model/artist/comment.dart';

class CommentDto {
  static const String artistIdKey = 'artistId';
  static const String comment = 'comment';

  static Comment fromJson(String id, Map<String, dynamic> json) {
    assert(json[artistIdKey] is String);
    assert(json[comment] is String);

    return Comment(id: id, artistId: json[artistIdKey], comment: json[comment]);
  }

  ///convert comment to json
  static Map<String, dynamic> toJson(Comment newComment) {
    return {artistIdKey: newComment.artistId, comment: newComment.comment};
  }
}
