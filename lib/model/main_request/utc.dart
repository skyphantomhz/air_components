class Utc {
  int v;
  String tz;
  String s;

  Utc({this.v, this.tz, this.s});

  Utc.fromJson(Map<String, dynamic> json) {
    v = json['v'];
    tz = json['tz'];
    s = json['s'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['v'] = this.v;
    data['tz'] = this.tz;
    data['s'] = this.s;
    return data;
  }
}