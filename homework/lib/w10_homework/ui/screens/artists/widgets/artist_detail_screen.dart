import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../model/artist/artist.dart';
import '../../../../data/repositories/artist/artist_repository.dart';
import 'artist_detail_content.dart';
import '../view_model/artist_detail_view_model.dart';

class ArtistDetailScreen extends StatelessWidget {
  final Artist artist;

  const ArtistDetailScreen({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ArtistDetailViewModel(
        repository: context.read<ArtistRepository>(), 
        artistId: artist.id,
      ),
      child: ArtistDetailContent(artist: artist),
    );
  }
}
