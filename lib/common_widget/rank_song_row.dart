import 'package:flutter/material.dart';
class RankSongsRow extends StatelessWidget {
  final Map sObj;
  final VoidCallback onPressedPlay;
  final VoidCallback onPressed;
  final String? rank;
  const RankSongsRow({
    super.key,
    required this.sObj,
    required this.onPressed,
    required this.onPressedPlay, required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    rank: sObj["rank"];
    return
      Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 15,
                    child: RichText(
                      text: TextSpan(
                        text: sObj["rank"],
                        style: TextStyle(
                          fontSize: getRankFontSize(sObj["rank"]),
                          fontWeight: FontWeight.w700,
                          color: Color(0xffCE0000),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      sObj["image"],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(width: 20,),
                  SizedBox(
                    width: 170,
                    child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              sObj["name"],
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              sObj["artists"],
                              maxLines: 1,
                              style: TextStyle(color: Colors.black, fontSize: 14),
                            )
                          ],
                    ),
                  ),
                  const SizedBox(width: 20,),


                ],
              ),
              IconButton(
                onPressed: (){
                  _bottomSheet(context);
                },
                icon: Image.asset(
                  "assets/img/More.png",
                  width: 25,
                  height: 25,

                ),
              ),
              const SizedBox(height: 20,)
            ],
          ),
          const SizedBox(height: 10,)
        ],

      );

  }
   getRankFontSize(String rank) {
    switch (rank) {
      case '1': case '2':case '3':
      return 30.0;
      default:
        return 20.0;
    }
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
