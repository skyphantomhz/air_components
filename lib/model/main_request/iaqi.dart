class Iaqi {
  String p;
  List<dynamic> v;

  Iaqi({this.p, this.v});

  Iaqi.fromJson(Map<String, dynamic> json) {
    p = json['p'];
    v = json['v']?.cast<dynamic>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['p'] = this.p;
    data['v'] = this.v;
    return data;
  }

  String getConditionUnit(bool isCelsius) {
    String unit = "";
    switch (p) {
      case "t":
        unit = isCelsius ? "°C" :"°F";
        break;
      case "p":
        unit = "mb";
        break;
      case "h":
        unit = "%";
        break;
      case "w":
        unit = "m/s";
        break;
      case "r":
        unit = "mm";
        break;
      default:
    }
    return unit;
  }

  String getConditionTitle() {
    String title = "";
    switch (p) {
      case "t":
        title = "Temp.";
        break;
      case "p":
        title = "Pressure";
        break;
      case "h":
        title = "Humidity";
        break;
      case "w":
        title = "Wind";
        break;
      case "r":
        title = "Rain";
        break;
      default:
    }
    return title;
  }
}
