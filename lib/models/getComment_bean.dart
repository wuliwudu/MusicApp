
class GetCommentBean {
  int? code;
  String? msg;
  int? total;
  List<CommentBean>? rows;

  GetCommentBean.formMap(Map map) {
    code = map['code'];
    msg = map['msg'];
    total = map['total'];

    List<dynamic>? rowList = map['rows'];
    if (rowList == null) return;

    rows = rowList
        .map((item) => CommentBean._formMap(item))
        .toList();
  }
}



class CommentBean {
  int? id;
  String? content;
  String? time;
  String? username;
  String? avatar;

  CommentBean._formMap(Map map) {
    id = map['id'];
    content = map['content'];
    time = map['time'];
    username = map['username'];
    avatar = map['avatar'];
  }
}
