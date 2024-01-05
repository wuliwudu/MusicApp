// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_miao/common_widget/app_data.dart';
import 'package:music_player_miao/models/search_bean.dart';
import 'package:music_player_miao/view/main_tab_view/main_tab_view.dart';

import '../../api/api_client.dart';
import '../../api/api_songlist.dart';
import '../../common/color_extension.dart';
import '../../models/getInfo_bean.dart';
import '../../models/login_bean.dart';
import '../../models/songlist_bean.dart';
import '../../widget/my_text_field.dart';

class LoginV extends StatefulWidget {
  const LoginV({super.key});

  @override
  State<LoginV> createState() => _LoginVState();
}

class _LoginVState extends State<LoginV> {
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool signInRequired = false;
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 30),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: MyTextField(
                    controller: nameController,
                    hintText: '请输入账号',
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Image.asset("assets/img/login_user.png"))),
            const SizedBox(height: 15),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Center(
                child: MyTextField(
                  controller: passwordController,
                  hintText: '请输入密码',
                  obscureText: obscurePassword,
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon: Image.asset("assets/img/login_lock.png"),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                        if (obscurePassword) {
                          iconPassword = CupertinoIcons.eye_fill;
                        } else {
                          iconPassword = CupertinoIcons.eye_slash_fill;
                        }
                      });
                    },
                    icon: Icon(
                      iconPassword,
                      color: MColor.DGreen,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            !signInRequired
                ? SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: TextButton(
                        onPressed: () async {
                          try {
                            LoginBean bean = await LoginApiClient().login(
                              email: nameController.text,
                              password: passwordController.text,
                            );
                            if (bean.code == 200) {
                              Get.to(() => const MainTabView());
                              _showDialog(context,
                                  title: 'assets/img/correct.png',
                                  message: '登录成功!');
                              GetInfoBean bean1 = await GetInfoApiClient()
                                  .getInfo(
                                      Authorization: AppData().currentToken);
                            }
                          } catch (error) {
                            String errorMessage = error.toString();
                            _showDialog(context,
                                title: 'assets/img/warning.png',
                                message: errorMessage);
                          }
                        },
                        style: TextButton.styleFrom(
                            elevation: 3.0,
                            backgroundColor: MColor.LGreen,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          child: Text(
                            '确认',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        )),
                  )
                : const CircularProgressIndicator(),
          ],
        ));
  }

  void _showDialog(BuildContext context,
      {required String title, required String message}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Image.asset(
            title,
            width: 47,
            height: 46,
          ),
          content: Text(message, textAlign: TextAlign.center),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              style: TextButton.styleFrom(
                backgroundColor: MColor.DGreen,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(5.0), // Adjust the radius as needed
                ),
              ),
              child: const Text(
                '确认',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
