class NearestV2 {
  int x;
  List<double> g;
  String t;
  String aqi;
  String name;
  String utime;

  NearestV2({this.x, this.g, this.t, this.aqi, this.name, this.utime});

  NearestV2.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    g = json['g'].cast<double>();
    t = json['t'];
    aqi = json['aqi'];
    name = json['name'];
    utime = json['utime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['x'] = this.x;
    data['g'] = this.g;
    data['t'] = this.t;
    data['aqi'] = this.aqi;
    data['name'] = this.name;
    data['utime'] = this.utime;
    return data;
  }
}