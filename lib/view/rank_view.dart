import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../api/api_music_rank.dart';
import '../common_widget/rank_song_row.dart';
import '../models/getRank_bean.dart';
import '../view_model/rank_view_model.dart';

class RankView extends StatefulWidget {
  const RankView({super.key});

  @override
  State<RankView> createState() => _RankViewState();
}

class _RankViewState extends State<RankView> {
  final rankVM = Get.put(RankViewModel());
  List rankNames = [];
  List rankSingerName = [];
  List rankCoverPath = [];
  List rankMusicPath = [];

  void initState() {
    super.initState();
    _fetchSonglistData();
  }

  Future<void> _fetchSonglistData() async {
    RankBean bean2 = await GetRank().getRank();
    setState(() {
      rankNames = bean2.data!.map((data) => data.name!).toList();
      rankSingerName = bean2.data!.map((data) => data.singerName!).toList();
      rankCoverPath = bean2.data!.map((data) => data.coverPath!).toList();
      rankMusicPath = bean2.data!.map((data) => data.musicPath!).toList();
    });
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            //头部
            const Center(
              child: Column(
                children: [
                  Text(
                    '喵听排行榜',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Top50',
                    style: TextStyle(
                        color: Color(0xffCE0000),
                        fontSize: 40,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '2023/12/12更新  1期',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      "assets/img/button_play.png",
                      width: 20,
                      height: 20,
                    ),
                  ),
                  const Text(
                    '播放全部',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    '50',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          itemCount: rankNames.length,
                          itemBuilder: (context, index) {
                            int rankNum = index + 1;
                            return ListTile(
                                title: Column(
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 25,
                                          child: RichText(
                                            text: TextSpan(
                                              text: rankNum.toString(),
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xffCE0000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            rankCoverPath[index],
                                            width: 60,
                                            height: 60,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              // 如果加载失败，返回一个默认图片
                                              return Image.asset(
                                                'assets/img/app_logo.png',
                                                // 你的默认图片路径
                                                width: 60,
                                                height: 60,
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        SizedBox(
                                          width: 170,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                rankNames[index],
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                rankSingerName[index],
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        _bottomSheet(context);
                                      },
                                      icon: Image.asset(
                                        "assets/img/More.png",
                                        width: 25,
                                        height: 25,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                )
                              ],
                            ));
                          }),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Future _bottomSheet(BuildContext context){
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        builder: (context) =>Container(
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
                        onPressed: (){},
                        icon: Image.asset("assets/img/list_add.png"),
                        iconSize: 60,
                      ),
                      Text("加入歌单")
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: (){},
                        icon: Image.asset("assets/img/list_download.png"),
                        iconSize: 60,
                      ),
                      Text("下载")
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: (){},
                        icon: Image.asset("assets/img/list_collection.png"),
                        iconSize: 60,
                      ),
                      Text("收藏")
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: (){},
                        icon: Image.asset("assets/img/list_good.png"),
                        iconSize: 60,
                      ),
                      Text("点赞")
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: (){},
                        icon: Image.asset("assets/img/list_comment.png"),
                        iconSize: 60,
                      ),
                      Text("评论")
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () {
                  // Get.to(()=>const MainTabView());
                },
                child: Text(
                  "查看详情页",
                  style: const TextStyle(color:Colors.black,fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffE6F4F1),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),

              ),
              ElevatedButton(
                onPressed: () =>Navigator.pop(context),
                child: Text(
                  "取消",
                  style: const TextStyle(color:Colors.black,fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff429482),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),

              ),
            ],
          ),
        )

    );
  }
}
