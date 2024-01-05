import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import 'package:music_player_miao/api/api_music_return.dart';
import 'package:music_player_miao/models/search_bean.dart';
import 'package:music_player_miao/view/commend_view.dart';
import '../../view_model/home_view_model.dart';
import '../common_widget/Song_widegt.dart';
import '../common_widget/list_cell.dart';
import 'music_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final homeVM = Get.put(HomeViewModel());
  final TextEditingController _controller = TextEditingController();
  bool _isSearching = false;

  ///轮播图
  List<Map> imgList = [
    {"image": "assets/img/banner.png"},
    {"image": "assets/img/banner.png"},
    {"image": "assets/img/banner.png"},
  ];
  final List<Song> songs = [
    Song(
        artistPic: 'assets/img/music_artist.png',
        title: '背对背拥抱1',
        artist: '林俊杰 1',
        musicurl: 'audio/MAMAMOO.mp3',
        pic: 'assets/img/artist_pic.png'),
    Song(
        artistPic: 'assets/img/music_artist.png',
        title: '背对背拥抱2',
        artist: '林俊杰 2',
        musicurl: 'audio/FLOWER.mp3',
        pic: 'assets/img/artist_pic.png'),
    Song(
        artistPic: 'assets/img/music_artist.png',
        title: '背对背拥抱3',
        artist: '林俊杰 3',
        musicurl: 'audio/All.mp3',
        pic: 'assets/img/artist_pic.png'),
  ];
  List<String> _filteredData = [];

  Future<void> _filterData(String query) async {
    if (query.isNotEmpty) {
      SearchBean bean = await SearchMusic().search(keyword: query);
      if (bean.code == 200) {
        setState(() {
          _filteredData = bean.data
              ?.map((data) => "${data.name} ") // Adjust this based on your data structure
              .toList() ??
              [];
          _isSearching = true;
        });
      }
    } else {
      setState(() {
        _isSearching = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    ///轮播图
    var MySwiperWidget = Swiper(
      itemBuilder: (BuildContext context, int index) {
        //每次循环遍历时，将i赋值给index
        return new Image.asset(
          imgList[index]['image'],
          fit: BoxFit.fill,
        );
      },
      itemCount: imgList.length,
      //指示器
      pagination: SwiperPagination(
        builder: DotSwiperPaginationBuilder(
          color: Colors.white.withOpacity(0.85), // Color of inactive dots
          activeColor: const Color(0xff429482), // Color of active dot
        ),
      ),
      autoplay: true,
      autoplayDelay: 3000,
    );
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///头部
              Container(
                padding: const EdgeInsets.only(left: 20, top: 50),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '喵听',
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '你的云端音乐库',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),

              ///搜索
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Column(
                  children: [
                    Container(
                      height: 38,
                      decoration: BoxDecoration(
                        color: const Color(0xffF9F2AF),
                        borderRadius: BorderRadius.circular(19),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 1),
                            blurRadius: 0.1,
                          )
                        ],
                      ),
                      child: TextField(
                        controller: _controller,
                        onChanged: (query) {
                          setState(() async{
                            _filterData(query);
                          });
                        },
                        decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 20,
                          ),
                          prefixIcon: Container(
                            margin: const EdgeInsets.only(left: 20),
                            alignment: Alignment.centerLeft,
                            width: 30,
                            child: Image.asset(
                              "assets/img/home_search.png",
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                            ),
                          ),
                          hintText: "大家都在搜《背对背拥抱》",
                          hintStyle: const TextStyle(
                            color: Color(0xffA5A5A5),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    if (_isSearching)
                      Container(
                        height: 150,
                        width: 345,
                        decoration: BoxDecoration(
                            color:  const Color(0xffF9F2AF).withOpacity(0.7),
                            ),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: _filteredData.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(_filteredData[index]),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),

              ///推荐+轮播图
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: const Text(
                  '每日推荐',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                height: 186,
                width: double.infinity,
                child: MySwiperWidget,
              ),

              ///精选歌曲
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                child: const Text(
                  '精选歌曲',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: songs.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.asset(songs[index].pic),
                    title: Text(
                      songs[index].title,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    subtitle: Text(
                      songs[index].artist,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    trailing: InkWell(
                      onTap: () {
                        _bottomSheet(context,index);
                      },
                      child: Image.asset('assets/img/More.png'),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MusicView(
                              song: songs[index], initialSongIndex: index),
                        ),
                      );
                    },
                  );
                },
              ),

              ///精选歌单
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                child: const Text(
                  '精选歌单',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 180,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(left: 20),
                    itemCount: homeVM.listArr.length,
                    itemBuilder: (context, index) {
                      var sObj = homeVM.listArr[index];
                      return ListRow(
                        sObj: sObj,
                        onPressed: () {},
                        onPressedPlay: () {},
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _bottomSheet(BuildContext context,int index) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        builder: (context) => Container(
              height: 210,
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Image.asset("assets/img/list_add.png"),
                            iconSize: 60,
                          ),
                          const Text("加入歌单")
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Image.asset("assets/img/list_download.png"),
                            iconSize: 60,
                          ),
                          const Text("下载")
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Image.asset("assets/img/list_collection.png"),
                            iconSize: 60,
                          ),
                          const Text("收藏")
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Image.asset("assets/img/list_good.png"),
                            iconSize: 60,
                          ),
                          const Text("点赞")
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.to(() => CommentView(initialSongIndex: index,));
                            },
                            icon: Image.asset("assets/img/list_comment.png"),
                            iconSize: 60,
                          ),
                          const Text("评论")
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "查看详情页",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffE6F4F1),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff429482),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: const Text(
                      "取消",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ));
  }
}
