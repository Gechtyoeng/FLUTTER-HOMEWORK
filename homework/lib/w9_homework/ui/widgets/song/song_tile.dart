import 'package:flutter/material.dart';
import 'package:w6_homework/w9_homework/model/songs/song_with_artist.dart';

class SongTile extends StatelessWidget {
  const SongTile({super.key, required this.songArtist, required this.isPlaying, required this.onTap});

  final SongWithArtist songArtist;
  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage(songArtist.song.imageUrl.toString())),
          onTap: onTap,
          title: Text(songArtist.song.title),
          subtitle: Row(children: [Text(formatDurationFull(songArtist.song.duration)), const SizedBox(width: 10), Text(songArtist.artist.name)]),
          trailing: Text(isPlaying ? "Playing" : "", style: TextStyle(color: Colors.amber)),
        ),
      ),
    );
  }

  /// time format
  String formatDurationFull(Duration d) {
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);

    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
  }
}
