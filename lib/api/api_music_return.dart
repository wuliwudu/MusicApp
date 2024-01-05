// api/api_client.dart
// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:music_player_miao/models/universal_bean.dart';
import '../models/getComment_bean.dart';
import '../models/getInfo_bean.dart';
import '../models/search_bean.dart';

const String _SearchURL = 'http://flyingpig.fun:10010/musics/search';
const String _postComment = 'http://flyingpig.fun:10010/comments';
///搜索
class SearchMusic{
  final Dio dio = Dio();
  Future<SearchBean> search({required String keyword,}) async {
    Response response = await dio.get(
        _SearchURL,
        queryParameters: {'keyword':keyword}
    );
    print(response.data);
    return SearchBean.formMap(response.data);
  }
}

///评论
class commentMusic {
  final Dio dio = Dio();
  Future<UniversalBean> comment({
    required int musicId,
    required String content,
    required String Authorization,
  }) async {
    Response response = await dio.post(
        _postComment,
        data: {
          'musicId': musicId,
          'password': content,
          'Authorization': Authorization
        },
        options: Options(headers:{'Authorization':Authorization,'Content-Type':'application/json;charset=UTF-8'})
    );
    print(response.data);
    return UniversalBean.formMap(response.data);

  }
}
///get评论
class getCommentApi {
  final Dio dio = Dio();
  Future<GetCommentBean> getComment({
    required String musicId,
    required String pageNo,
    required String pageSize,
    required String Authorization
  }) async {
    Response response = await dio.get(
      _postComment,
        queryParameters: {'musicId':musicId,'pageNo':pageNo,'pageSize':pageSize},
        options: Options(headers:{'Authorization':Authorization,'Content-Type':'application/json;charset=UTF-8'})
    );
    print(response.data);
    return GetCommentBean.formMap(response.data);
  }

}






