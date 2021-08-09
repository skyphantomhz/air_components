import 'model.dart';

class SpeciesValue {
  List<String> data;
  Model model;

  SpeciesValue({this.data, this.model});

  SpeciesValue.fromJson(Map<String, dynamic> json) {
    data = json['data'].cast<String>();
    model = json['model'] != null ? new Model.fromJson(json['model']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    if (this.model != null) {
      data['model'] = this.model.toJson();
    }
    return data;
  }
}
