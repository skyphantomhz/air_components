class Aqi {
  String t;
  List<int> v;

  Aqi({this.t, this.v});

  Aqi.fromJson(Map<String, dynamic> json) {
    t = json['t'];
    v = json['v'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['t'] = this.t;
    data['v'] = this.v;
    return data;
  }
}