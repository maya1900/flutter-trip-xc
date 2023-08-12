// To parse this JSON data, do
//
//     final travelTabModel = travelTabModelFromJson(jsonString);

import 'dart:convert';

TravelTabModel? travelTabModelFromJson(String str) => TravelTabModel.fromJson(json.decode(str));

String travelTabModelToJson(TravelTabModel? data) => json.encode(data!.toJson());

class TravelTabModel {
  TravelTabModel({
    this.tabs,
  });

  List<TravelTab?>? tabs;

  factory TravelTabModel.fromJson(Map<String, dynamic> json) => TravelTabModel(
    tabs: json["tabs"] == null ? [] : List<TravelTab?>.from(json["tabs"]!.map((x) => TravelTab.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tabs": tabs == null ? [] : List<dynamic>.from(tabs!.map((x) => x!.toJson())),
  };
}

class TravelTab {
  TravelTab({
    this.labelName,
    this.groupChannelCode = '',
  });

  String? labelName;
  String groupChannelCode;

  factory TravelTab.fromJson(Map<String, dynamic> json) => TravelTab(
    labelName: json["labelName"],
    groupChannelCode: json["groupChannelCode"],
  );

  Map<String, dynamic> toJson() => {
    "labelName": labelName,
    "groupChannelCode": groupChannelCode,
  };
}
