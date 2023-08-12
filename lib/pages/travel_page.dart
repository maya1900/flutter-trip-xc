import 'package:flutter/material.dart';
import 'package:flutter_trip_xc/model/travel_tab_model.dart';
import 'package:flutter_trip_xc/pages/travel_tab_page.dart';

import '../dao/travel_tab_dao.dart';

class TravelPage extends StatefulWidget {
  const TravelPage({super.key});

  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin {
  TabController? _controller;
  List<TravelTab?>? tabs = [];
  TravelTabModel? travelTabModel;

  @override
  void initState() {
    _controller = TabController(length: 0, vsync: this);
    TravelTabDao.fetch().then((TravelTabModel value) {
      _controller = TabController(length: value.tabs!.length, vsync: this);
      setState(() {
        tabs = value.tabs;
        travelTabModel = value;
        print(travelTabModel);
      });
    }).catchError((e) {
      print(e);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 50),
            child: TabBar(
              controller: _controller,
              isScrollable: true, // 是否可以滚动
              labelColor: Colors.black, // 选中的颜色
              labelPadding: const EdgeInsets.fromLTRB(20, 0, 10, 5), // 选中的padding
              indicator: const UnderlineTabIndicator( // 下划线
                  borderSide: BorderSide(color: Color(0xff2fcfbb), width: 3),
                  insets: EdgeInsets.only(bottom: 10)),
              tabs: tabs!.map<Tab>((TravelTab? tab) {
                return Tab(
                  text: tab?.labelName,
                );
              }).toList(),
            ),
          ),
          Flexible(
            child: TabBarView(
              controller: _controller,
              children: tabs!.map((TravelTab? tab) {
                return TravelTabPage(
                  groupChannelCode: tab!.groupChannelCode,
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}