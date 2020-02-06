class Iaqi {
  String p;
  List<dynamic> v;
  String i;

  Iaqi({this.p, this.v, this.i});

  Iaqi.fromJson(Map<String, dynamic> json) {
    p = json['p'];
    i = json['i'];
    v = json['v']?.cast<dynamic>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['p'] = this.p;
    data['v'] = this.v;
    data['i'] = this.i;
    return data;
  }
}
