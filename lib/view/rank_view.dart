import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common_widget/rank_song_row.dart';
import '../view_model/rank_view_model.dart';

class RankView extends StatefulWidget {
  const RankView({super.key});

  @override
  State<RankView> createState() => _RankViewState();
}

class _RankViewState extends State<RankView> {
  final rankVM = Get.put(RankViewModel());

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
              const SizedBox(height: 40,),
              //头部
              const Center(
                child: Column(
                  children: [
                    Text(
                      '喵听排行榜',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      'Top50',
                      style: TextStyle(
                        color: Color(0xffCE0000),
                          fontSize: 40,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      '2023/12/12更新  1期',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
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
                            onPressed: (){},
                            icon: Image.asset(
                              "assets/img/button_play.png",
                              width: 20,
                              height: 20,
                            ),
                          ),
                          const Text(
                            '播放全部',
                            style: TextStyle(
                                fontSize: 16
                            ),
                          ),
                          const SizedBox(width: 5,),
                          const Text(
                            '50',
                            style: TextStyle(
                                fontSize: 16
                            ),
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
                                  padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                                  itemCount: rankVM.rankDetailArr.length,
                                  itemBuilder: (context, index) {
                                    var sObj = rankVM.rankDetailArr[index];
                                    return RankSongsRow(
                                      sObj: sObj,
                                      onPressed: () {},
                                      onPressedPlay: () {},
                                      rank: sObj["rank"],
                                    );
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
}
