
import 'package:flutter_trip_xc/model/common_model.dart';
import 'package:flutter_trip_xc/model/config_model.dart';
import 'package:flutter_trip_xc/model/sales_box_model.dart';

import 'grid_nav_model.dart';

class HomeModel {
  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final GridNavModel gridNav;
  final List<CommonModel> subNavList;
  final SalesBoxModel salesBox;

  HomeModel({required this.config, required this.bannerList, required this.localNavList, required this.gridNav, required this.subNavList, required this.salesBox});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    var bannerListJson = json['bannerList'] as List;
    List<CommonModel> bannerList = bannerListJson.map((i) => CommonModel.fromJson(i)).toList();

    var localNavListJson = json['localNavList'] as List;
    List<CommonModel> localNavList = localNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    var subNavListJson = json['subNavList'] as List;
    List<CommonModel> subNavList = subNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    return HomeModel(
      config: ConfigModel.fromJson(json['config']),
      bannerList: bannerList,
      localNavList: localNavList,
      gridNav: GridNavModel.fromJson(json['gridNav']),
      subNavList: subNavList,
      salesBox: SalesBoxModel.fromJson(json['salesBox']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'config': config,
      'bannerList': bannerList,
      'localNavList': localNavList,
      'gridNav': gridNav,
      'subNavList': subNavList,
      'salesBox': salesBox,
    };
  }
}