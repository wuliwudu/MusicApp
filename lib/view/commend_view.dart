import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_miao/api/api_music_return.dart';
import 'package:music_player_miao/common_widget/app_data.dart';
import 'package:music_player_miao/models/getComment_bean.dart';
import 'package:music_player_miao/models/universal_bean.dart';
import 'package:music_player_miao/widget/text_field.dart';


class CommentView extends StatefulWidget {
  @override
  _CommentViewState createState() => _CommentViewState();

  CommentView({super.key, required this.initialSongIndex});

  late final int initialSongIndex;
}

class _CommentViewState extends State<CommentView> {
  List comments = [];

  TextEditingController commentController = TextEditingController();
  FocusNode commentFocusNode = FocusNode();
  List commentTimes = [];
  List commentHeader = [];
  List commentName = [];
  bool ascendingOrder = true;
  int playlistCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchSonglistData();
  }

  Future<void> _fetchSonglistData() async {
    try {
      GetCommentBean bean1 = await getCommentApi().getComment(
          musicId: '1',
          pageNo: '0',
          pageSize: '10',
          Authorization: AppData().currentToken);
        setState(() {
          comments = bean1.rows!.map((rows) => rows.content!).toList();
          commentTimes = bean1.rows!.map((rows) => rows.time!).toList();
          commentHeader = bean1.rows!.map((rows) => rows.avatar!).toList();
          commentName = bean1.rows!.map((rows) => rows.username!).toList();
          playlistCount = comments.length;
        });

    } catch (error) {
      if (error != null) {
        print('Response data: $error');
      } else {
        print('Error fetching songlist data: $error');
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xffF6FFD1),
        title: const Text(
          '评论(200)',
          style: TextStyle(
              color: Colors.black,
              fontSize: 22
          ),
        ),
        elevation: 0,
        leading: IconButton(
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
      ),
      body: Column(
        children: [
          Container(
            height: 80,
            padding: const EdgeInsets.only(left: 20, right: 10),
            decoration: BoxDecoration(
                color: const Color(0xffF9F2AF),
                borderRadius: BorderRadius.circular(20)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/img/artist_pic.png",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 20,),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "背对背拥抱",
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "林俊杰",
                          maxLines: 1,
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        )
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    "assets/img/music_pause.png",
                    width: 25,
                    height: 25,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "评论区",
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      "时间",
                      style: TextStyle(
                          fontSize: 16
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // setState(() {
                        //   ascendingOrder = !ascendingOrder;
                        //   comments.sort((a, b) {
                        //     int compare = ascendingOrder
                        //         ? commentTimes.indexOf(a).compareTo(
                        //         commentTimes.indexOf(b))
                        //         : commentTimes.indexOf(b).compareTo(
                        //         commentTimes.indexOf(a));
                        //     return compare;
                        //   });
                        // });
                      },
                      icon: Image.asset(
                        ascendingOrder
                            ? "assets/img/commend_up.png"
                            : "assets/img/commend_down.png",
                        fit: BoxFit.contain,
                      ),
                    ),

                  ],
                )
              ],
            ),
          ),
          /// 显示评论的区域
          Expanded(
            child:
            ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(commentHeader[index])
                          ),
                          const SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(commentName[index],
                                  style: const TextStyle(fontSize: 18)),
                              const SizedBox(width: 8),
                              // Adjust the spacing between elements
                              Text(commentTimes[index],
                                style: const TextStyle(fontSize: 14),),
                              // Add the timestamp
                            ],
                          ),
                        ],
                      ), // Ad
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 50, top: 10, bottom: 20),
                        child: Text(
                          comments[index],
                          style: const TextStyle(
                              fontSize: 18), // Customize the font size if needed
                        ),
                      ),
                      Container(
                        width: 560,
                        height: 2,
                        color: const Color(0xffE3F0ED),
                      )
                    ],
                  ),
                );
              },
            ),
          ),

          ///输入框和提交按钮
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: TextFieldColor(
                      controller: commentController,
                      hintText: '来发表你的评论吧!',
                    )
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () async {
                    submitComment();
                    UniversalBean bean = await commentMusic().comment(
                        musicId: widget.initialSongIndex,
                        content: commentController.text,
                        Authorization: AppData().currentToken);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff429482),
                    // Change Colors.blue to your desired background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Adjust the radius as needed
                    ),
                    minimumSize: const Size(30, 44),
                  ),
                  child: const Text(
                    '提交',
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void submitComment() {
    String comment = commentController.text;
    if (comment.isNotEmpty) {
      DateTime currentTime = DateTime.now();
      String formattedTime = "${currentTime.year}/${currentTime
          .month}/${currentTime.day} ${currentTime.hour}:${currentTime.minute}";

      setState(() {
        comments.add(comment);
        commentTimes.add(formattedTime);
        commentName.add(AppData().currentUsername);
        commentHeader.add(AppData().currentAvatar);
        commentController.clear();
        playlistCount++;
      });
    }
  }
}
