class City {
  String name;
  String url;
  int idx;
  String id;
  List<String> geo;
  String key;

  City({this.name, this.url, this.idx, this.id, this.geo, this.key});

  City.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    idx = json['idx'];
    id = json['id'];
    geo = json['geo'].cast<String>();
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    data['idx'] = this.idx;
    data['id'] = this.id;
    data['geo'] = this.geo;
    data['key'] = this.key;
    return data;
  }
}