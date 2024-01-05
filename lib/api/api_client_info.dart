import 'dart:io';

import 'package:dio/dio.dart';

import '../models/universal_bean.dart';

const String _changeNameURL = 'http://flyingpig.fun:10010/users/username';
const String _changeHeaderURL = 'http://flyingpig.fun:10010/users/avatar';

class ChangeApiClient {
  final Dio dio = Dio();
  ///修改昵称
  Future<UniversalBean> changeName({
    required String Authorization,
    required String userName
  }) async {
    Response response = await dio.put(
        _changeNameURL,
        data: {
          'Authorization': Authorization,
        },
        queryParameters: {'userName':userName},
        options: Options(headers:{'Authorization':Authorization,'Content-Type':'application/json;charset=UTF-8'})
    );
    print(response.data);
    return UniversalBean.formMap(response.data);
  }
///修改头像

  Future<UniversalBean> changeHeader({
    required String Authorization,
    required File avatar,
  }) async {
    FormData formData = FormData.fromMap({
      'Authorization': Authorization,
      'avatar': await MultipartFile.fromFile(avatar.path, filename: 'avatar.jpg'),
    });

    Response response = await dio.put(
      _changeHeaderURL,
      data: formData,
      options: Options(
        headers: {
          'Authorization': Authorization,
          'Content-Type': 'multipart/form-data',
        },
      ),
    );

    print(response.data);
    return UniversalBean.formMap(response.data);
  }

}
