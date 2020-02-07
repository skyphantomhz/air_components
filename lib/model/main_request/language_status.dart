class LanguageStatus {
  String ago;
  String time;

  LanguageStatus({this.ago, this.time});

  LanguageStatus.fromJson(Map<String, dynamic> json) {
    ago = json['ago'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ago'] = this.ago;
    data['time'] = this.time;
    return data;
  }
}