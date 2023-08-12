import 'dart:async';
import 'dart:convert';
import 'package:flutter_trip_xc/model/search_model.dart';
import 'package:http/http.dart' as http; // as语法表示重命名

class SearchDao {
  static Future<SearchModel> fetch(String url, String text) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // fix中文乱码
      Utf8Decoder utf8decoder = const Utf8Decoder();
      var result = jsonDecode(utf8decoder.convert(response.bodyBytes));
      SearchModel model = SearchModel.fromJson(result);
      model.keyword = text;
      return model;
    } else {
      throw Exception('Failed to load home_page.json');
    }
  }
}