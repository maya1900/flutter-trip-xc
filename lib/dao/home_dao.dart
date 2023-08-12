import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http; // as语法表示重命名
import 'package:flutter_trip_xc/model/home_model.dart';
const homeUrl = 'https://www.devio.org/io/flutter_app/json/home_page.json';
class HomeDao {
  static Future<HomeModel> fetch() async {
    final response = await http.get(Uri.parse(homeUrl));
    if (response.statusCode == 200) {
      // fix中文乱码
      Utf8Decoder utf8decoder = const Utf8Decoder();
      var result = jsonDecode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    } else {
      throw Exception('Failed to load home_page.json');
    }
  }
}