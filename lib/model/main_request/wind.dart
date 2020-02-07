class Wind {
  String t;
  List<double> w;
  num c;

  Wind({this.t, this.w, this.c});

  Wind.fromJson(Map<String, dynamic> json) {
    t = json['t'];
    w = json['w'].cast<double>();
    c = json['c'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['t'] = this.t;
    data['w'] = this.w;
    data['c'] = this.c;
    return data;
  }
}