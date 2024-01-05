// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_miao/widget/text_field.dart';
import '../../api/api_client.dart';
import '../../api/api_client_info.dart';
import '../../common_widget/app_data.dart';
import '../../models/getInfo_bean.dart';
import '../../models/universal_bean.dart';
import '../../view_model/home_view_model.dart';
import 'package:image_picker/image_picker.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final listVM = Get.put(HomeViewModel());
  final TextEditingController _controller = TextEditingController();
  late File _selectedImage;

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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
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
          title: const Text(
            "账户信息",
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.w400),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 80,
                color: Colors.white.withOpacity(0.6),
                padding: const EdgeInsets.only(left: 48, right: 25),
                child: InkWell(
                  onTap: () {
                    _bottomSheet(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "头像",
                        style: TextStyle(fontSize: 20),
                      ),
                      Row(
                        children: [
                          Image.network(
                            AppData().currentAvatar,
                            width: 64,
                            height: 64,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Image.asset(
                            "assets/img/user_next.png",
                            width: 25,
                            height: 25,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 80,
                color: Colors.white.withOpacity(0.6),
                padding: const EdgeInsets.only(left: 48, right: 25),
                child: InkWell(
                  onTap: () {
                    _showNicknameDialog();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "昵称",
                        style: TextStyle(fontSize: 20),
                      ),
                      Row(
                        children: [
                          Text(
                            AppData().currentUsername,
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Image.asset(
                            "assets/img/user_next.png",
                            width: 25,
                            height: 25,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _bottomSheet(BuildContext context) async {
    final picker = ImagePicker();
    await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        builder: (context) => Container(
              height: 132,
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      final pickedFile =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        _selectedImage=File('assets/images/bg.png');
                        setState(() {
                          _selectedImage = File(pickedFile.path);
                          print(_selectedImage);
                        });
                        UniversalBean bean = await ChangeApiClient().changeHeader(
                            Authorization: AppData().currentToken,
                            avatar: _selectedImage);
                        GetInfoBean bean1 = await GetInfoApiClient().getInfo(
                            Authorization: AppData().currentToken);
                        AppData appData = AppData();
                        appData.box.write('currentAvatar', AppData().currentAvatar);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      "从相册上传头像",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff429482),
                      padding: const EdgeInsets.symmetric(vertical: 18),
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

  void _showNicknameDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
              child: Text(
            "修改昵称",
            style: TextStyle(fontSize: 20),
          )),
          content: TextFieldColor(
            controller: _controller,
            hintText: '请输入新昵称',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xff429482),
                minimumSize: const Size(130, 50),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(5.0), // Adjust the radius as needed
                ),
              ),
              child: const Text(
                "取消",
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () async {
                _updateNickname();
                UniversalBean bean = await ChangeApiClient().changeName(
                    Authorization: AppData().currentToken,
                    userName: AppData().currentUsername);
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xff429482),
                minimumSize: const Size(130, 50),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(5.0), // Adjust the radius as needed
                ),
              ),
              child: const Text(
                "保存",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _updateNickname() {
    setState(() {
      AppData appData = AppData();
      appData.box.write('currentUsername', _controller.text);
    });
  }
}
