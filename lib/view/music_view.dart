
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_miao/common_widget/app_data.dart';
import '../../view_model/home_view_model.dart';
import 'package:audioplayers/audioplayers.dart';

import '../common_widget/Song_widegt.dart';

class MusicView extends StatefulWidget {
  final Song song;
  final int initialSongIndex;
  const MusicView({super.key, required this.song, required this.initialSongIndex});


  @override
  State<MusicView> createState() => _MusicViewState();
}

class _MusicViewState extends State<MusicView> {
  final homeVM = Get.put(HomeViewModel());
  bool isGoodCommended = AppData().isLikes;
  bool isStarCommended = false;
  bool _isDisposed = false;
  AppData appData = AppData();
  late int currentSongIndex;

  List<String> song2 = [
    "audio/MAMAMOO.mp3",
    "audio/FLOWER.mp3",
    "audio/All.mp3"
  ];
  List<String> artist = [
    "林俊杰 1",
    "林俊杰 2",
    "林俊杰 3"
  ];
  List<String> music = [
    "背对背拥抱 1",
    "背对背拥抱 2",
    "背对背拥抱 3"
  ];


  late AudioPlayer _audioPlayer;
  late Duration _duration;
  late Duration _position;
  late String artistName;
  late String musicName;

  void playerInit() {
    _audioPlayer = AudioPlayer()..setSourceAsset('${widget.song.musicurl}');
    _duration = const Duration();
    _position = const Duration();
    artistName = '${widget.song.artist}';
    musicName = '${widget.song.title}';

    _audioPlayer.onDurationChanged.listen((Duration d) {
      _duration = d;
      setState(() {});
    });

    _audioPlayer.onPositionChanged.listen((Duration p) {
      _position = p;
      setState(() {});
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _position = _duration;
      });
    });
  }

  void playOrPause() {
    if (_audioPlayer.state == PlayerState.playing) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.resume();
    }

    setState(() {});
  }

  void playNextSong() {
    if (currentSongIndex < 2) {
      currentSongIndex++;
    } else {
      currentSongIndex = 0;
    }

    _audioPlayer.setSourceAsset(song2[currentSongIndex]);
    artistName = artist[currentSongIndex];
    musicName = music[currentSongIndex];
    _audioPlayer.resume();
  }

  void playPreviousSong() {
    if (currentSongIndex > 0) {
      currentSongIndex--;
    } else {
      currentSongIndex = 2;
    }

    _audioPlayer.setSourceAsset(song2[currentSongIndex]);
    artistName = artist[currentSongIndex];
    musicName = music[currentSongIndex];
    _audioPlayer.resume();
  }


  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inMinutes)}:$twoDigitSeconds";
  }

  @override
  void initState() {
    playerInit();
    currentSongIndex = widget.initialSongIndex;
    super.initState();
  }

  @override
  void dispose() {
    _isDisposed = true;
    _audioPlayer.release();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/img/app_bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 45, left: 10, right: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Image.asset(
                        "assets/img/back.png",
                        width: 25,
                        height: 25,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            "assets/img/music_add.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            "assets/img/music_download.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 80,
                ),
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/img/music_Ellipse.png",
                          width: 320,
                          height: 320,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(80),
                          child: Image.asset(
                            '${widget.song.artistPic}',
                            width: 230,
                            height: 230,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          musicName,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          artistName,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isGoodCommended = !isGoodCommended;
                              appData.box.write('isLikes', isGoodCommended);
                            });
                          },
                          icon: Image.asset(
                            isGoodCommended
                                ? "assets/img/music_good.png"
                                : "assets/img/music_good_un.png",
                            width: 29,
                            height: 29,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isStarCommended = !isStarCommended;
                            });
                          },
                          icon: Image.asset(
                            isStarCommended
                                ? "assets/img/music_star.png"
                                : "assets/img/music_star_un.png",
                            width: 29,
                            height: 29,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Image.asset("assets/img/music_good.png");
                          },
                          icon: Image.asset(
                            "assets/img/music_commend_un.png",
                            width: 29,
                            height: 29,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${formatDuration(_position)}",
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: SliderTheme(
                        data: const SliderThemeData(
                          trackHeight: 3.0, // 调整轨道的高度
                          thumbShape: RoundSliderThumbShape(
                              enabledThumbRadius: 7.0), // 调整拇指的大小
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 12.0),
                        ),
                        child: Slider(
                          min: 0,
                          max: _duration.inSeconds.toDouble(),
                          value: _position.inSeconds.toDouble(),
                          onChanged: (value) async {
                            await _audioPlayer
                                .seek(Duration(seconds: value.toInt()));
                            setState(() {});
                          },
                          activeColor: const Color(0xff429482),
                          inactiveColor: const Color(0xffE3F0ED),
                        ),
                      ),
                    ),
                    Text(
                      "${formatDuration(_duration)}",
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        "assets/img/music_random.png",
                        width: 35,
                        height: 35,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: playPreviousSong,
                          icon: Image.asset(
                            "assets/img/music_back.png",
                            width: 42,
                            height: 42,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                            onPressed: playOrPause,
                            icon: _audioPlayer.state == PlayerState.playing
                                ? Image.asset(
                                    "assets/img/music_play.png",
                                  )
                                : Image.asset(
                                    "assets/img/music_pause.png",
                                  )),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: playNextSong,
                          icon: Image.asset(
                            "assets/img/music_next.png",
                            width: 42,
                            height: 42,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: _showPlaylist,
                      icon: Image.asset(
                        "assets/img/music_more.png",
                        width: 35,
                        height: 35,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showPlaylist() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.only(top: 15),
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.45),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: Text(
                  "播放列表",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    bool isCurrentlyPlaying = currentSongIndex == index;
                    return ListTile(
                      tileColor: isCurrentlyPlaying ? const Color(0xffE3F0ED) : null,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            // Add left padding
                            child: Text(
                              music[index],
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            // Add right padding
                            child: Image.asset(
                              "assets/img/songs_run.png",
                              width: 25,
                            ), // Add your desired icon here
                          ),
                        ],
                      ),
                      onTap: () {
                        _changeCurrentSong(index);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff429482),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: const Text(
                  "关闭",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _changeCurrentSong(int index) {
    if (!_isDisposed) { // Check the flag before using the player
      setState(() {
        currentSongIndex = index;
        _audioPlayer.setSourceAsset(song2[currentSongIndex]);
        artistName = artist[currentSongIndex];
        musicName = music[currentSongIndex];
        _audioPlayer.resume();
      });
    }
  }

}
