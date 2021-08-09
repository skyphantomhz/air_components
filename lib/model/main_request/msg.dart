import 'city.dart';
import 'forecast.dart';
import 'i18n.dart';
import 'iaqi.dart';
import 'nearestV2.dart';
import 'time.dart';

class Msg {
  int timestamp;
  City city;
  List<Iaqi> iaqi;
  int aqi;
  Time time;
  I18n i18n;
  Forecast forecast;
  List<NearestV2> nearestV2;

  Msg(
      {this.timestamp,
      this.city,
      this.iaqi,
      this.aqi,
      this.time,
      this.i18n,
      this.forecast,
      this.nearestV2});

  Msg.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    if (json['iaqi'] != null) {
      iaqi = new List<Iaqi>();
      json['iaqi'].forEach((v) {
        iaqi.add(new Iaqi.fromJson(v));
      });
    }
    aqi = 0;
    if (json['aqi'].toString() != "-") {
      aqi = json['aqi'];
    }
    time = json['time'] != null ? new Time.fromJson(json['time']) : null;
    i18n = json['i18n'] != null ? new I18n.fromJson(json['i18n']) : null;
    forecast = json['forecast'] != null
        ? new Forecast.fromJson(json['forecast'])
        : null;
    if (json['nearest_v2'] != null) {
      nearestV2 = new List<NearestV2>();
      json['nearest_v2'].forEach((v) {
        nearestV2.add(new NearestV2.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    if (this.city != null) {
      data['city'] = this.city.toJson();
    }
    if (this.iaqi != null) {
      data['iaqi'] = this.iaqi.map((v) => v.toJson()).toList();
    }
    data['aqi'] = this.aqi;
    if (this.time != null) {
      data['time'] = this.time.toJson();
    }
    if (this.i18n != null) {
      data['i18n'] = this.i18n.toJson();
    }
    if (this.forecast != null) {
      data['forecast'] = this.forecast.toJson();
    }
    if (this.nearestV2 != null) {
      data['nearest_v2'] = this.nearestV2.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
