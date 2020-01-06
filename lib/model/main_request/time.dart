import 'package:air_components/model/main_request/status.dart';
import 'package:air_components/model/main_request/utc.dart';

class Time {
  String v;
  Utc utc;
  Status s;

  Time({this.v, this.utc, this.s});

  Time.fromJson(Map<String, dynamic> json) {
    v = json['v'];
    utc = json['utc'] != null ? new Utc.fromJson(json['utc']) : null;
    s = json['s'] != null ? new Status.fromJson(json['s']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['v'] = this.v;
    if (this.utc != null) {
      data['utc'] = this.utc.toJson();
    }
    if (this.s != null) {
      data['s'] = this.s.toJson();
    }
    return data;
  }
}