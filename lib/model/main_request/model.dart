class Model {
  String feed;
  String extracted;

  Model({this.feed, this.extracted});

  Model.fromJson(Map<String, dynamic> json) {
    feed = json['feed'];
    extracted = json['extracted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feed'] = this.feed;
    data['extracted'] = this.extracted;
    return data;
  }
}