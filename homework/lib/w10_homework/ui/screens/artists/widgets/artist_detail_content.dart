import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:w6_homework/w10_homework/ui/screens/library/view_model/library_item_data.dart';
import 'package:w6_homework/w10_homework/ui/screens/library/widgets/library_item_tile.dart';
import 'package:w6_homework/w10_homework/ui/states/player_state.dart';
import 'package:w6_homework/w10_homework/ui/utils/async_value.dart';
import '../../../../model/artist/artist.dart';
import '../../../../model/artist/comment.dart';
import '../view_model/artist_detail_view_model.dart';
import 'comment_tile.dart';

class ArtistDetailContent extends StatelessWidget {
  final Artist artist;
  const ArtistDetailContent({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ArtistDetailViewModel>();
    final player = context.watch<PlayerState>();
    final state = vm.state;

    Widget content;

    switch (state.state) {
      case AsyncValueState.loading:
        content = const Center(child: CircularProgressIndicator());
        break;

      case AsyncValueState.error:
        content = Center(
          child: Text('Error: ${state.error}', style: const TextStyle(color: Colors.red)),
        );
        break;

      case AsyncValueState.success:
        final data = state.data!;
        final List<LibraryItemData> libraryItems = data.songs.map((song) => LibraryItemData(song: song, artist: data.artist)).toList();
        final List<Comment> comments = data.comments;

        content = RefreshIndicator(
          onRefresh: () async => vm.fetchData(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Artist information
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(radius: 50, backgroundImage: NetworkImage(artist.imageUrl.toString())),
                      const SizedBox(height: 12),
                      Text(artist.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(artist.genre, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Songs
                Text("Songs", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                libraryItems.isEmpty
                    ? const Center(child: Text("No songs yet"))
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: libraryItems.length,
                        itemBuilder: (context, index) {
                          final item = libraryItems[index];
                          return LibraryItemTile(data: item, isPlaying: false, onTap: () => player.start(item.song));
                        },
                      ),
                const SizedBox(height: 24),

                // Comments
                Text("Comments", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                comments.isEmpty
                    ? const Center(child: Text("No comments yet"))
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: comments.length,
                        itemBuilder: (context, index) => CommentTile(comment: comments[index]),
                      ),
                const SizedBox(height: 16),

                // Add Comment
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: vm.commentController,
                        decoration: const InputDecoration(hintText: "Add a comment...", border: OutlineInputBorder()),
                      ),
                    ),
                    IconButton(icon: const Icon(Icons.send), onPressed: () => vm.createComment()),
                  ],
                ),
              ],
            ),
          ),
        );
        break;
    }

    return Scaffold(
      appBar: AppBar(title: Text(artist.name)),
      body: Padding(padding: const EdgeInsets.all(16.0), child: content),
    );
  }
}
