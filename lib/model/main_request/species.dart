import 'species_value.dart';

class Species {
  SpeciesValue pm25;
  SpeciesValue pm10;
  SpeciesValue o3;
  SpeciesValue uvi;

  Species({this.pm25, this.pm10, this.o3, this.uvi});

  Species.fromJson(Map<String, dynamic> json) {
    pm25 =
        json['pm25'] != null ? new SpeciesValue.fromJson(json['pm25']) : null;
    pm10 =
        json['pm10'] != null ? new SpeciesValue.fromJson(json['pm10']) : null;
    o3 = json['o3'] != null ? new SpeciesValue.fromJson(json['o3']) : null;
    uvi = json['uvi'] != null ? new SpeciesValue.fromJson(json['uvi']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pm25 != null) {
      data['pm25'] = this.pm25.toJson();
    }
    if (this.pm10 != null) {
      data['pm10'] = this.pm10.toJson();
    }
    if (this.o3 != null) {
      data['o3'] = this.o3.toJson();
    }
    if (this.uvi != null) {
      data['uvi'] = this.uvi.toJson();
    }
    return data;
  }
}
