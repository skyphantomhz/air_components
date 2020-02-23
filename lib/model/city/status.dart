class Status {
  String aqi;
  List<String> time;
  List<String> names;
  String u;

  Status({this.aqi, this.time, this.names, this.u});

  Status.fromJson(Map<String, dynamic> json) {
    aqi = json['a'];
    if(json['a'] == "-"){
      aqi = "0";
    }
    time = json['t']?.cast<String>();
    names = json['n']?.cast<String>();
    u = json['u'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['a'] = this.aqi;
    data['t'] = this.time;
    data['n'] = this.names;
    data['u'] = this.u;
    return data;
  }
}