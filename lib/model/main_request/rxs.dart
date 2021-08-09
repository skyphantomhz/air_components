import 'obs.dart';

class Rxs {
  List<Obs> obs;
  String status;
  String ver;

  Rxs({this.obs, this.status, this.ver});

  Rxs.fromJson(Map<String, dynamic> json) {
    if (json['obs'] != null) {
      obs = new List<Obs>();
      json['obs'].forEach((v) {
        obs.add(new Obs.fromJson(v));
      });
    }
    status = json['status'];
    ver = json['ver'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.obs != null) {
      data['obs'] = this.obs.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['ver'] = this.ver;
    return data;
  }
}
