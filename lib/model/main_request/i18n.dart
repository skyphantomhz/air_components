import 'package:air_components/model/main_request/localize_string.dart';

class I18n {
  LocalizeString name;
  LocalizeString title;

  I18n({this.name, this.title});

  I18n.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? new LocalizeString.fromJson(json['name']) : null;
    title = json['title'] != null ? new LocalizeString.fromJson(json['title']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.name != null) {
      data['name'] = this.name.toJson();
    }
    if (this.title != null) {
      data['title'] = this.title.toJson();
    }
    return data;
  }
}