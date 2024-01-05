import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_player_miao/common/color_extension.dart';
import 'package:music_player_miao/view/begin/login_v.dart';
import 'package:music_player_miao/view/begin/setup_view.dart';

class BeginView extends StatefulWidget {
  const BeginView({super.key});

  @override
  State<BeginView> createState() => _BeginViewState();
}

class _BeginViewState extends State<BeginView> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
        initialIndex: 0,
        length: 2,
        vsync: this
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/img/app_bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 110,left: 40,right: 40),
                child: Row(
                  children: [
                    const Column(
                      children: [
                        Text(
                          "你好吖喵星来客,",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "欢迎来到",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            Text(
                              "喵听",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w800
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(width: 25,),
                    Image.asset("assets/img/app_logo.png", width: 80),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Align(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height/1.06,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Material(
                                color: Colors.white,
                                elevation: 3,
                                borderRadius: BorderRadius.circular(10),
                                child: TabBar(
                                  controller: tabController,
                                  unselectedLabelColor: Color(0xffCDCDCD),
                                  labelColor: Colors.black,
                                  indicator:BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      color: MColor.LGreen
                                    ),
                                  tabs:  [
                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      // color: Colors.pink,
                                      child: Text(
                                        '登录',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),

                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        '注册',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                child: TabBarView(
                                  controller: tabController,
                                  children: [
                                    LoginV(),
                                    SignUpView(),
                                  ],
                                )
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}