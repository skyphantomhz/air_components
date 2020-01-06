import 'package:air_components/model/main_request/aqi.dart';
import 'package:air_components/model/main_request/species.dart';
import 'package:air_components/model/main_request/wind.dart';

class Forecast {
  List<Aqi> aqi;
  Species species;
  List<Wind> wind;

  Forecast({this.aqi, this.species, this.wind});

  Forecast.fromJson(Map<String, dynamic> json) {
    if (json['aqi'] != null) {
      aqi = new List<Aqi>();
      json['aqi'].forEach((v) {
        aqi.add(new Aqi.fromJson(v));
      });
    }
    species =
        json['species'] != null ? new Species.fromJson(json['species']) : null;
    if (json['wind'] != null) {
      wind = new List<Wind>();
      json['wind'].forEach((v) {
        wind.add(new Wind.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aqi != null) {
      data['aqi'] = this.aqi.map((v) => v.toJson()).toList();
    }
    if (this.species != null) {
      data['species'] = this.species.toJson();
    }
    if (this.wind != null) {
      data['wind'] = this.wind.map((v) => v.toJson()).toList();
    }
    return data;
  }
}