import 'language_status.dart';

class Status {
  LanguageStatus en;
  LanguageStatus zhCN;
  LanguageStatus ja;
  LanguageStatus es;
  LanguageStatus ko;
  LanguageStatus ru;
  LanguageStatus zhTW;
  LanguageStatus fr;
  LanguageStatus pl;
  LanguageStatus de;
  LanguageStatus pt;
  LanguageStatus vi;

  Status(
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

  Status.fromJson(Map<String, dynamic> json) {
    en = json['en'] != null ? new LanguageStatus.fromJson(json['en']) : null;
    zhCN = json['zh-CN'] != null
        ? new LanguageStatus.fromJson(json['zh-CN'])
        : null;
    ja = json['ja'] != null ? new LanguageStatus.fromJson(json['ja']) : null;
    es = json['es'] != null ? new LanguageStatus.fromJson(json['es']) : null;
    ko = json['ko'] != null ? new LanguageStatus.fromJson(json['ko']) : null;
    ru = json['ru'] != null ? new LanguageStatus.fromJson(json['ru']) : null;
    zhTW = json['zh-TW'] != null
        ? new LanguageStatus.fromJson(json['zh-TW'])
        : null;
    fr = json['fr'] != null ? new LanguageStatus.fromJson(json['fr']) : null;
    pl = json['pl'] != null ? new LanguageStatus.fromJson(json['pl']) : null;
    de = json['de'] != null ? new LanguageStatus.fromJson(json['de']) : null;
    pt = json['pt'] != null ? new LanguageStatus.fromJson(json['pt']) : null;
    vi = json['vi'] != null ? new LanguageStatus.fromJson(json['vi']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.en != null) {
      data['en'] = this.en.toJson();
    }
    if (this.zhCN != null) {
      data['zh-CN'] = this.zhCN.toJson();
    }
    if (this.ja != null) {
      data['ja'] = this.ja.toJson();
    }
    if (this.es != null) {
      data['es'] = this.es.toJson();
    }
    if (this.ko != null) {
      data['ko'] = this.ko.toJson();
    }
    if (this.ru != null) {
      data['ru'] = this.ru.toJson();
    }
    if (this.zhTW != null) {
      data['zh-TW'] = this.zhTW.toJson();
    }
    if (this.fr != null) {
      data['fr'] = this.fr.toJson();
    }
    if (this.pl != null) {
      data['pl'] = this.pl.toJson();
    }
    if (this.de != null) {
      data['de'] = this.de.toJson();
    }
    if (this.pt != null) {
      data['pt'] = this.pt.toJson();
    }
    if (this.vi != null) {
      data['vi'] = this.vi.toJson();
    }
    return data;
  }
}
