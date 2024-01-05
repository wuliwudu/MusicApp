// home_view_model.dart

import 'package:get/get.dart';

import 'Song_widegt.dart';

class TryRow extends GetxController {
  final RxString txtSearch = ''.obs;

  final List<Song> allSongs = [
    Song(
      artistPic: 'assets/img/music_artist.png',
      title: '背对背拥抱1',
      artist: '林俊杰 1',
      musicurl: 'audio/MAMAMOO.mp3',
      pic: 'assets/img/artist_pic.png',
    ),
    // Add more songs here
  ];

  RxList<Song> filteredSongs = <Song>[].obs;

  @override
  void onInit() {
    filteredSongs.assignAll(allSongs);
    super.onInit();
  }

  void updateSearchResults() {
    final String query = txtSearch.value.toLowerCase();
    if (query.isEmpty) {
      filteredSongs.assignAll(allSongs);
    } else {
      filteredSongs.assignAll(allSongs
          .where((song) =>
      song.title.toLowerCase().contains(query) ||
          song.artist.toLowerCase().contains(query))
          .toList());
    }
  }
}
