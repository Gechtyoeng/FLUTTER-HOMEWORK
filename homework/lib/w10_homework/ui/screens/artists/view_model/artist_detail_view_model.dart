import 'package:flutter/material.dart';
import 'package:w6_homework/w10_homework/data/repositories/artist/artist_repository.dart';
import 'package:w6_homework/w10_homework/model/artist/comment.dart';
import 'package:w6_homework/w10_homework/ui/screens/artists/view_model/artist_detail.dart';
import 'package:w6_homework/w10_homework/ui/utils/async_value.dart';

class ArtistDetailViewModel extends ChangeNotifier {
  final ArtistRepository repository;
  final String artistId;
  TextEditingController commentController = TextEditingController();

  AsyncValue<ArtistDetailData> state = AsyncValue.loading();

  ArtistDetailViewModel({required this.repository, required this.artistId}) {
    fetchData();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    state = AsyncValue.loading();
    notifyListeners();

    try {
      final artist = await repository.fetchArtistById(artistId);
      final songs = await repository.fetchArtistSong(artistId);
      final comments = await repository.fetchArtistComments(artistId);

      state = AsyncValue.success(ArtistDetailData(artist: artist!, songs: songs, comments: comments));
    } catch (e) {
      state = AsyncValue.error(e);
    }

    notifyListeners();
  }

  Future<void> createComment() async {
    if (commentController.text.isEmpty) return;

    try {
      await repository.addComment(Comment(id: '', artistId: artistId, comment: commentController.text));
      commentController.clear();
      await fetchData();
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }
}
