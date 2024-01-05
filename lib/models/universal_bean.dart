class UniversalBean {
  int? code;
  String? msg;
  String? data;

  UniversalBean.formMap(Map map) {
    code = map['code'];
    msg = map['msg'];
    data = map['data'];
  }
}
