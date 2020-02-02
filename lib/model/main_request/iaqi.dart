class Iaqi {
  String p;
  List<int> v;
  String i;
  List<String> h;

  Iaqi({this.p, this.v, this.i, this.h});

  Iaqi.fromJson(Map<String, dynamic> json) {
    p = json['p'];
    i = json['i'];
    h = json['h'].cast<String>();
    try {
      v = json['v']?.cast<int>();
    } catch(error) {
      v = [0, 0, 0];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['p'] = this.p;
    data['v'] = this.v;
    data['i'] = this.i;
    data['h'] = this.h;
    return data;
  }
}
