import 'package:air_components/model/city/status.dart';

class CitySortInfo {
  Status s;
  List<String> n;
  int x;
  String c;
  int z;

  CitySortInfo({this.s, this.n, this.x, this.c, this.z});

  CitySortInfo.fromJson(Map<String, dynamic> json) {
    s = json['s'] != null ? new Status.fromJson(json['s']) : null;
    n = json['n']?.cast<String>();
    x = json['x'];
    c = json['c'];
    z = json['z'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.s != null) {
      data['s'] = this.s.toJson();
    }
    data['n'] = this.n;
    data['x'] = this.x;
    data['c'] = this.c;
    data['z'] = this.z;
    return data;
  }
}