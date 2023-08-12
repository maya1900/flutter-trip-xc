// class ConfigModel {
//   final String icon;
//   final String url;
//   final String searchUrl;
//
//   ConfigModel({this.searchUrl = '', this.icon = '', this.url = ''});
//
//   factory ConfigModel.fromJson(Map<String, dynamic> json) {
//     return ConfigModel(
//       searchUrl: json['searchUrl'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'searchUrl': searchUrl,
//     };
//   }
// }

class ConfigModel {
  ConfigModel({
    this.searchUrl,});

  ConfigModel.fromJson(dynamic json) {
    searchUrl = json['searchUrl'];
  }
  String? searchUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['searchUrl'] = searchUrl;
    return map;
  }
}