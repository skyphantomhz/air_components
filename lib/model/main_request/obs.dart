import 'msg.dart';

class Obs {
  Msg msg;
  String status;
  String uid;
  String cached;

  Obs({this.msg, this.status, this.uid, this.cached});

  Obs.fromJson(Map<String, dynamic> json) {
    msg = json['msg'] != null ? new Msg.fromJson(json['msg']) : null;
    status = json['status'];
    uid = json['uid'];
    cached = json['cached'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.msg != null) {
      data['msg'] = this.msg.toJson();
    }
    data['status'] = this.status;
    data['uid'] = this.uid;
    data['cached'] = this.cached;
    return data;
  }
}
