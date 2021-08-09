import 'city_sort_info.dart';

class SearchResponse {
  String dt;
  String term;
  List<CitySortInfo> results;

  SearchResponse({this.dt, this.term, this.results});

  SearchResponse.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    term = json['term'];
    if (json['results'] != null) {
      results = new List<CitySortInfo>();
      json['results'].forEach((v) {
        results.add(new CitySortInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = this.dt;
    data['term'] = this.term;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
