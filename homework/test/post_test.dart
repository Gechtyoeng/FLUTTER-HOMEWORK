import 'package:w6_homework/w8_homework/data/repositories/songs/song_repository_mock.dart';
import 'package:w6_homework/w8_homework/model/songs/song.dart';

Future<void> main() async {
  final SongRepositoryMock mockSongs = SongRepositoryMock();

  //sucess case
  try {
    Song? song = await mockSongs.fetchSongById("s1");
    if (song != null) {
      print("Song recieved ${song.title}");
    }
  } catch (e) {
    print(e.toString());
  }

  //fail case
  mockSongs
      .fetchSongById("s23")
      .then((song) {
        print("Song recieved ${song?.title}");
      })
      .catchError((e) {
        print(e.toString());
      });
}
