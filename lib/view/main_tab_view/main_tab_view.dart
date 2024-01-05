import 'package:flutter/material.dart';
import 'package:music_player_miao/view/rank_view.dart';
import 'package:music_player_miao/view/user/user_view.dart';

import '../home_view.dart';
import '../release_view.dart';


class MainTabView extends StatefulWidget {
  const MainTabView({super.key});
  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> with SingleTickerProviderStateMixin{
  TabController? controller;
  int selectTab = 0;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 4, vsync: this);

    controller?.addListener(() {
      selectTab = controller?.index ?? 0;
      setState(() {

      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller?.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      body: TabBarView(
        controller: controller,
        children: const [
          HomeView(),
          RankView(),
          ReleaseView(),
          UserView()
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 0,
        child: TabBar(
          controller: controller,
          indicatorColor: Colors.transparent,
          indicatorWeight: 3,
          labelColor: Colors.black,
          labelStyle: const TextStyle(
              fontSize: 12
          ),
          unselectedLabelColor: const Color(0xffCDCDCD),
          unselectedLabelStyle: const TextStyle(
              fontSize: 12
          ),
          tabs: [
            Tab(
              text:
              "首页",
              icon:Image.asset(
                selectTab == 0?"assets/img/home_tab.png":"assets/img/home_tab_un.png",
                width: 45,height: 45,),

            ),
            Tab(
              text:
              "排行榜",
              icon:Image.asset(
                selectTab == 1?"assets/img/list_tab.png":"assets/img/list_tab_un.png",
                width: 45,height: 45,),

            ),
            Tab(
              text:
              "发布",
              icon:Image.asset(selectTab == 2?"assets/img/music_tab.png":"assets/img/music_tab_un.png",
                width: 45,height: 45,),

            ),
            Tab(
              text:
              "个人",
              icon:Image.asset(selectTab == 3?"assets/img/user_tab.png":"assets/img/user_tab_un.png",
                width: 45,height: 45,),

            ),
          ],
        ),
      ),
    );
  }
}
