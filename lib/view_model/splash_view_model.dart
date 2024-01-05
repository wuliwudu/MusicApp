
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_miao/view/begin/begin_view.dart';
class SplashViewModel extends GetxController{
  var scaffoldKey = GlobalKey<ScaffoldState>();

  void loadView() async{
    await Future.delayed(const Duration(seconds: 3),(){
      Get.to(()=>const BeginView());
    });
  }
}