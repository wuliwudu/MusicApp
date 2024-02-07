import 'package:dio/dio.dart';

import '../models/getMusicList_bean.dart';
import '../models/getRank_bean.dart';

const String _getMusic1 = 'http://flyingpig.fun:10010/musics/1';
const String _getMusic2 = 'http://flyingpig.fun:10010/musics/2';
const String _getMusic3 = 'http://flyingpig.fun:10010/musics/3';

///排行榜
class GetMusic {
  final Dio dio = Dio();

  Future<MusicListBean> getMusic1({required String Authorization}) async {
    Response response = await dio.get(
        _getMusic1,
        data: {
          'Authorization': Authorization,
        },
        options: Options(headers: {
          'Authorization': Authorization,
          'Content-Type': 'application/json;charset=UTF-8'
        }));
    print(response.data);
    return MusicListBean.formMap(response.data);
  }
  Future<MusicListBean> getMusic2({required String Authorization}) async {
    Response response = await dio.get(
        _getMusic2,
        data: {
          'Authorization': Authorization,
        },
        options: Options(headers: {
          'Authorization': Authorization,
          'Content-Type': 'application/json;charset=UTF-8'
        }));
    print(response.data);
    return MusicListBean.formMap(response.data);
  }
  Future<MusicListBean> getMusic3({required String Authorization}) async {
    Response response = await dio.get(
        _getMusic3,
        data: {
          'Authorization': Authorization,
        },
        options: Options(headers: {
          'Authorization': Authorization,
          'Content-Type': 'application/json;charset=UTF-8'
        }));
    print(response.data);
    return MusicListBean.formMap(response.data);
  }
}
