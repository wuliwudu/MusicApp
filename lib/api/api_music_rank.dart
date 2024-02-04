import 'package:dio/dio.dart';

import '../models/getRank_bean.dart';

const String _getRank = 'http://flyingpig.fun:10010/musics/rank-list';
///排行榜
class GetRank {
  final Dio dio = Dio();

  Future<RankBean> getRank() async {
    Response response = await dio.get(
        _getRank,
    );
    print(response.data);
    return RankBean.formMap(response.data);
  }
}