import 'dart:convert';
/// searchUrl : "https://m.ctrip.com/restapi/h5api/globalsearch/search?source=mobileweb&action=mobileweb&keyword="

Config configFromJson(String str) => Config.fromJson(json.decode(str));
String configToJson(Config data) => json.encode(data.toJson());
class Config {
  Config({
      this.searchUrl,});

  Config.fromJson(dynamic json) {
    searchUrl = json['searchUrl'];
  }
  String? searchUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['searchUrl'] = searchUrl;
    return map;
  }
}