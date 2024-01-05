import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_miao/api/api_songlist.dart';
import 'package:music_player_miao/common_widget/app_data.dart';
import 'package:music_player_miao/models/songlist_bean.dart';
import 'package:music_player_miao/models/universal_bean.dart';
import 'package:music_player_miao/view/begin/begin_view.dart';
import 'package:music_player_miao/view/user/my_music_view.dart';
import 'package:music_player_miao/view/user/user_info.dart';
import 'package:music_player_miao/widget/text_field.dart';
import '../../../view_model/home_view_model.dart';
import '../../api/api_client.dart';
import '../../models/search_bean.dart';
import 'my_work_view.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  final homeVM = Get.put(HomeViewModel());
  final TextEditingController _controller = TextEditingController();
  int playlistCount = 2;
  List playlistNames = [];
  List playlistid = [];

  @override
  void initState() {
    super.initState();
    _fetchSonglistData();
  }

  ///getSonglist
  Future<void> _fetchSonglistData() async {
    try {
      SearchBean bean2 = await SonglistApi().getSonglist(
        Authorization: AppData().currentToken,
      );

      setState(() {
        playlistNames = bean2.data!.map((data) => data.name!).toList();
        playlistid = bean2.data!.map((data) => data.id!).toList();
        playlistCount = playlistNames.length;
      });
    } catch (error) {
      print('Error fetching songlist data: $error');
    }
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
            padding: const EdgeInsets.only(left: 15, right: 15, top: 55),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///头部--头像、昵称、下弹框
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 10, bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.network(
                            AppData().currentAvatar,
                            width: 64,
                            height: 64,
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Text(
                            AppData().currentUsername,
                            style: const TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            _bottomSheet(context);
                          },
                          icon: Image.asset("assets/img/user_more.png"))
                    ],
                  ),
                ),
                ///我的音乐库
                const Text(
                  '我的音乐库',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Container(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 20, bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(const MyMusicView());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset("assets/img/artist_pic.png"),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "我的收藏",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    "19首",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 80,
                              ),
                              Image.asset(
                                "assets/img/user_next.png",
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(const MyMusicView());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset("assets/img/artist_pic.png"),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "本地下载",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    "19首",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 80,
                              ),
                              Image.asset(
                                "assets/img/user_next.png",
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
                ///歌单
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '歌单 $playlistCount',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              _showAddPlaylistDialog();
                            },
                            icon: Image.asset(
                              "assets/img/user_add.png",
                              width: 31,
                              color: const Color(0xff404040),
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: Image.asset("assets/img/user_export.png",
                                width: 31))
                      ],
                    )
                  ],
                ),
                Container(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset("assets/img/artist_pic.png"),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "我的收藏",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    "19首",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 80,
                              ),
                              Image.asset(
                                "assets/img/user_next.png",
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset("assets/img/artist_pic.png"),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "本地下载",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    "19首",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 80,
                              ),
                              Image.asset(
                                "assets/img/user_next.png",
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
                InkWell(
                  onTap: () {
                    Get.to(const MyMusicView());
                  },
                  child: Column(
                    children: List.generate(playlistNames.length, (index) {
                      return Dismissible(
                        key: Key(playlistNames[index]),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20.0),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        confirmDismiss: (direction) async {
                          return await _showDeleteConfirmationDialog(
                              context, index);
                        },
                        onDismissed: (direction) {
                          setState(() {
                            playlistNames.removeAt(index);
                            playlistid.removeAt(index);
                            playlistCount--;
                          });
                        },
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset("assets/img/artist_pic.png"),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        playlistNames[index],
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      const Text(
                                        '0首',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Image.asset(
                                "assets/img/user_next.png",
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                const Text(
                  '已发布音乐10',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Container(
                    padding: const EdgeInsets.only(
                        left: 15, right: 20, top: 20, bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(const MyWorkView());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset("assets/img/artist_pic.png"),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "我的作品",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    "10首",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 80,
                              ),
                              Image.asset(
                                "assets/img/user_next.png",
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///下弹框--退出，个人信息修改
  Future _bottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        builder: (context) => Container(
              height: 200,
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
                            onPressed: () {
                              Get.to(const UserInfo());
                            },
                            icon: Image.asset("assets/img/user_infor.png"),
                            iconSize: 60,
                          ),
                          const Text("账户信息")
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () async {
                              UniversalBean bean = await LogoutApiClient()
                                  .logout(
                                      Authorization: AppData().currentToken);
                              if (bean.code == 200) {
                                Get.to(const BeginView());
                              }
                            },
                            icon: Image.asset("assets/img/user_out.png"),
                            iconSize: 60,
                          ),
                          const Text("退出登录")
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
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
                      "取消",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ));
  }

  ///弹出框--添加歌单
  void _showAddPlaylistDialog() {
    _controller.clear();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Center(
            child: Text(
              "新建歌单",
              style: TextStyle(fontSize: 20),
            ),
          ),
          content: TextFieldColor(controller: _controller, hintText: '请输入歌单名称'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xff429482),
                minimumSize: const Size(130, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              child: const Text(
                "取消",
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                String enteredSongName = _controller.text;
                playlistCount++;
                // Add the new playlist
                setState(() {
                  playlistNames.add(enteredSongName);
                });
                SonglistBean bean = await SonglistApi().addSonglist(
                    songlistName: _controller.text,
                    Authorization: AppData().currentToken);
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xff429482),
                minimumSize: const Size(130, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              child: const Text(
                "确认",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  ///删除
  Future<bool> _showDeleteConfirmationDialog(
      BuildContext context, int index) async {
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Image.asset(
            "assets/img/warning.png",
            width: 47,
            height: 46,
          ),
          content: const Text(
            "确认删除?",
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xff429482),
                minimumSize: const Size(130, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              child: const Text(
                "取消",
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
                UniversalBean bean = await SonglistApi().delSonglist(
                  Authorization: AppData().currentToken,
                  id: playlistid[index],
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xff429482),
                minimumSize: const Size(130, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              child: const Text(
                "确认",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );

    return confirmDelete == true;
  }
}
