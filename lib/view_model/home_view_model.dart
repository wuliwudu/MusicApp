import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {

  void removeSong(int index) {
    listDetailArr.removeAt(index);
  }
  final txtSearch = TextEditingController().obs;
  final all =['你好'];

  final songsArr = [
    {
      "image": "assets/img/artist_pic.png",
      "name": "背对背拥抱1",
      "artists": "林"
    },
    {
    "image": "assets/img/artist_pic.png",
      "name": "背对背拥抱2",
      "artists": "林俊"
    },
    {
    "image": "assets/img/artist_pic.png",
      "name": "背对背拥抱3",
      "artists": "林俊杰"
    },
  ].obs;

  final listArr = [
    {
      "image": "assets/img/list_pic.png",
      "text": "华语歌曲精选",
    },
    {
      "image": "assets/img/list_pic.png",
      "text": "华语歌曲精选",
    },
    {
      "image": "assets/img/list_pic.png",
      "text": "华语歌曲精选",
    },
    {
      "image": "assets/img/list_pic.png",
      "text": "华语歌曲精选",
    },
  ].obs;
  final listDetailArr = [
    {
      "rank": "1",
      "name": "背对背拥抱",
      "artists": ""
    },
    {
      "rank": "2",
      "name": "背对背拥抱",
      "artists": "林俊杰"
    },
    {
      "rank": "3",
      "name": "背对背拥抱r",
      "artists": "林俊杰"
    },
    {
      "rank": "4",
      "name": "背对背拥抱",
      "artists": "林俊杰"
    },
    {
      "rank": "5",
      "name": "背对背拥抱",
      "artists": "林俊杰"
    },
    {
      "rank": "6",
      "name": "背对背拥抱",
      "artists": "林俊杰"
    },
    {
      "rank": "7",
      "name": "背对背拥抱",
      "artists": "林俊杰"
    },
    {
      "rank": "8",
      "name": "背对背拥抱",
      "artists": "林俊杰"
    },
    {
      "rank": "9",
      "name": "背对背拥抱",
      "artists": "林俊杰"
    },

  ].obs;
}
