import 'dart:async';
import 'dart:convert';
import 'package:flutter_trip_xc/model/travel_model.dart';
import 'package:http/http.dart' as http; // as语法表示重命名
import 'package:flutter_trip_xc/model/home_model.dart';
const homeUrl = 'https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5';
Map body = {
  "districtId": -1,
  "groupChannelCode": "tourphoto_global1",
  "type": null,
  "lat": -180,
  "lon": -180,
  "locatedDistrictId": 2,
  "pagePara": {
    "pageIndex": 1,
    "pageSize": 10,
    "sortType": 9,
    "sortDirection": 0
  },
  "imageCutType": 1,
  "head": {
  },
  "contentType": "json"
};
class TravelDao {
  static Future<TravelModel> fetch(
      String url, String groupChannelCode, int pageIndex, int pageSize) async {
    Map paramsMap = body['pagePara'];
    body['groupChannelCode'] = groupChannelCode;
    paramsMap['pageIndex'] = pageIndex;
    paramsMap['pageSize'] = pageSize;
    final response = await http.post(Uri.parse(url), body: jsonEncode(body));
    if (response.statusCode == 200) {
      // fix中文乱码
      Utf8Decoder utf8decoder = const Utf8Decoder();
      var result = jsonDecode(utf8decoder.convert(response.bodyBytes));
      return TravelModel.fromJson(result);
    } else {
      throw Exception('Failed to load travel_page.json');
    }
  }
}