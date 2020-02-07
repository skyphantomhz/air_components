class Aqi {
  String t;
  List<int> values;

  Aqi({this.t, this.values});

  Aqi.fromJson(Map<String, dynamic> json) {
    t = json['t'];
    values = json['v'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['t'] = this.t;
    data['v'] = this.values;
    return data;
  }
}