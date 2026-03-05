import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:w6_homework/data/repositories/songs/song_repository.dart';
import 'package:w6_homework/ui/screens/library/view_model/library_view_model.dart';
import 'package:w6_homework/ui/screens/library/widgets/library_content.dart';
import '../../states/player_state.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final SongRepository songRepository = context.read<SongRepository>();
        final PlayerState playerState = context.read<PlayerState>();

        final libraryVm = LibraryViewModel(songRepository: songRepository, playerState: playerState);
        libraryVm.init();

        return libraryVm;
      },
      child: const LibraryContent(),
    );
  }
}
