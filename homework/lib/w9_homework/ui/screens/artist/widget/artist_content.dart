import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:w6_homework/w9_homework/ui/theme/theme.dart';
import 'package:w6_homework/w9_homework/model/artists/artist.dart';
import 'package:w6_homework/w9_homework/ui/screens/artist/view_model/artist_view_model.dart';
import 'package:w6_homework/w9_homework/ui/screens/artist/widget/artist_tile.dart';
import 'package:w6_homework/w9_homework/ui/utils/async_value.dart';

class ArtistContent extends StatelessWidget {
  const ArtistContent({super.key});

  @override
  Widget build(BuildContext context) {
    // call the view model
    ArtistViewModel mv = context.watch<ArtistViewModel>();
    AsyncValue<List<Artist>> asyncValue = mv.artistValue;

    Widget content;
    switch (asyncValue.state) {
      
      case AsyncValueState.loading:
        content = Center(child: CircularProgressIndicator());
        break;
      case AsyncValueState.error:
        content = Center(
          child: Text('error = ${asyncValue.error!}', style: TextStyle(color: Colors.red)),
        );

      case AsyncValueState.success:
        List<Artist> artists = asyncValue.data!;
        content = ListView.builder(
          itemCount: artists.length,
          itemBuilder: (context, index) => ArtistTile(artist: artists[index]),
        );
    }
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Artists", style: AppTextStyles.heading),
          SizedBox(height: 50),

          Expanded(child: content),
        ],
      ),
    );
  }
}
