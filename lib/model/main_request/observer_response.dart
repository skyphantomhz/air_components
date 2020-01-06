import 'package:air_components/model/main_request/rxs.dart';

class ObserverResponse {
  String dt;
  Rxs rxs;

  ObserverResponse({this.dt, this.rxs});

  ObserverResponse.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    rxs = json['rxs'] != null ? new Rxs.fromJson(json['rxs']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = this.dt;
    if (this.rxs != null) {
      data['rxs'] = this.rxs.toJson();
    }
    return data;
  }
}