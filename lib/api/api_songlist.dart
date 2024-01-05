import 'package:dio/dio.dart';
import 'package:music_player_miao/models/search_bean.dart';
import 'package:music_player_miao/models/songlist_bean.dart';

import '../models/universal_bean.dart';

const String _SonglistURL = 'http://flyingpig.fun:10010/songlists';
///返回歌单
class SonglistApi {
  final Dio dio = Dio();

  Future<SearchBean> getSonglist({required String Authorization}) async {
    Response response = await dio.get(_SonglistURL,
        data: {
          'Authorization': Authorization,
        },
        options: Options(headers: {
          'Authorization': Authorization,
          'Content-Type': 'application/json;charset=UTF-8'
        }));
    print(response.data);
    return SearchBean.formMap(response.data);
  }

  ///添加歌单
  Future<SonglistBean> addSonglist(
      {required String songlistName, required String Authorization}) async {
    Response response = await dio.post(_SonglistURL,
        data: {
          'Authorization': Authorization,
        },
        queryParameters: {'songlistName': songlistName},
        options: Options(headers: {
          'Authorization': Authorization,
          'Content-Type': 'application/json;charset=UTF-8'
        }));
    print(response.data);
    return SonglistBean.formMap(response.data);
  }

  ///删除歌单
  Future<UniversalBean> delSonglist({required String Authorization,required int id}) async {
    String urlWithId = '$_SonglistURL/$id';
    Response response = await dio.delete(
        urlWithId,
        data: {
          'Authorization': Authorization,
        },
        options: Options(headers: {
          'Authorization': Authorization,
          'Content-Type': 'application/json;charset=UTF-8'
        }));

    print(response.data);
    return UniversalBean.formMap(response.data);
  }
}
