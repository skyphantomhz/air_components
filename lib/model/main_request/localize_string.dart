class LocalizeString {
  String en;
  String zhCN;
  String ja;
  String es;
  String ko;
  String ru;
  String zhTW;
  String fr;
  String pl;
  String de;
  String pt;
  String vi;

  LocalizeString(
      {this.en,
      this.zhCN,
      this.ja,
      this.es,
      this.ko,
      this.ru,
      this.zhTW,
      this.fr,
      this.pl,
      this.de,
      this.pt,
      this.vi});

  LocalizeString.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    zhCN = json['zh-CN'];
    ja = json['ja'];
    es = json['es'];
    ko = json['ko'];
    ru = json['ru'];
    zhTW = json['zh-TW'];
    fr = json['fr'];
    pl = json['pl'];
    de = json['de'];
    pt = json['pt'];
    vi = json['vi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['zh-CN'] = this.zhCN;
    data['ja'] = this.ja;
    data['es'] = this.es;
    data['ko'] = this.ko;
    data['ru'] = this.ru;
    data['zh-TW'] = this.zhTW;
    data['fr'] = this.fr;
    data['pl'] = this.pl;
    data['de'] = this.de;
    data['pt'] = this.pt;
    data['vi'] = this.vi;
    return data;
  }
}