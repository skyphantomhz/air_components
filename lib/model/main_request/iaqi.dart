class Iaqi {
  String p;
  List<dynamic> v;
<<<<<<< HEAD
  String i;

  Iaqi({this.p, this.v, this.i});

  Iaqi.fromJson(Map<String, dynamic> json) {
    p = json['p'];
    i = json['i'];
=======
  // String i;

  Iaqi({this.p, this.v});

  Iaqi.fromJson(Map<String, dynamic> json) {
    p = json['p'];
    // i = json['i'];
>>>>>>> Improve behavior
    v = json['v']?.cast<dynamic>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['p'] = this.p;
    data['v'] = this.v;
<<<<<<< HEAD
    data['i'] = this.i;
=======
    // data['i'] = this.i;
>>>>>>> Improve behavior
    return data;
  }
}
