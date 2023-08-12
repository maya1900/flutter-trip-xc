import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:flutter_trip_xc/dao/home_dao.dart';
import 'package:flutter_trip_xc/model/grid_nav_model.dart';
import 'package:flutter_trip_xc/model/home_model.dart';
import 'package:flutter_trip_xc/model/sales_box_model.dart';
import 'package:flutter_trip_xc/pages/search_page.dart';
import 'package:flutter_trip_xc/widget/grid_nav.dart';
import 'package:flutter_trip_xc/widget/loading_container.dart';
import 'package:flutter_trip_xc/widget/local_nav.dart';
import 'package:flutter_trip_xc/widget/search_bar.dart';
import 'package:flutter_trip_xc/widget/sub_nav.dart';
import 'package:flutter_trip_xc/widget/web_view_Screen.dart';

import '../model/common_model.dart';
import '../widget/sales_box.dart';

const appBarScrollOffset = 100.0;
const searchBarDefaultText = '网红打卡地 景点 酒店 美食';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>{
  double appBarAlpha = 0;
  List<CommonModel> localNavList = [];
  List<CommonModel> bannerList = [];
  GridNavModel? gridNavModel;
  List<CommonModel> subNavList = [];
  SalesBoxModel? salesBoxModel;
  bool _loading = true;

  _onScroll(offset) {
    double alpha = offset / appBarScrollOffset;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }

    setState(() {
      appBarAlpha = alpha;
    });
  }

  Future<void> _handleRefresh() async {
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        localNavList = model.localNavList;
        gridNavModel = model.gridNav;
        subNavList = model.subNavList;
        salesBoxModel = model.salesBox;
        bannerList = model.bannerList;
        _loading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
        _loading = false;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingContainer(
        isLoading: _loading,
        child: Stack(
          children: [
            MediaQuery.removePadding(
              removeTop: true, // 移除顶部的padding
              context: context,
              child: RefreshIndicator(
                onRefresh: _handleRefresh,
                child: NotificationListener(
                  // ignore: missing_return
                  onNotification: (scrollNotification) {
                    // ignore: missing_return
                    if (scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0) {
                      // 滚动且是列表滚动的时候
                      _onScroll(scrollNotification.metrics.pixels);
                    }
                    return false;
                  },
                  child: _listView,
                ),
              ),
            ),
            _appBar,
          ],
        ),
      ),
    );
  }

  Widget get _listView {
    return ListView(
      children: [
        _banner,
        // const GridNav(gridNavModel: null),
        Padding(padding: const EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(localNavList: localNavList),
        ),
        Padding(padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: GridNav(gridNavModel: gridNavModel),
        ),
        Padding(padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SubNav(subNavList: subNavList),
        ),
        Padding(padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SalesBox(salesBox: salesBoxModel),
        ),
      ],
    );
  }

  Widget get _appBar {
    return Column(
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              // AppBar渐变遮罩背景
              colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Container(
            // padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            height: 80,
            decoration: BoxDecoration(
              color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255),
            ),
            child: SearchBarWidget(
              searchBarType: appBarAlpha > 0.2 ? SearchBarType.homeLight : SearchBarType.home,
              inputBoxClick: _jumpToSearch,
              speakClick: _jumpToSpeak,
              defaultText: searchBarDefaultText,
              leftButtonClick: () {},
            ),
          ),
        ),
        Container(
          height: appBarAlpha > 0.2 ? 0.5 : 0,
          decoration: const BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)],
          ),
        )
      ],
    );
  }

  Widget get _banner {
    return SizedBox(
      height: 160,
      child: Swiper(
        itemCount: bannerList.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    CommonModel model = bannerList[index];
                    return WebViewScreen(
                      url: model.url,
                      hideAppBar: model.hideAppBar,
                      title: model.title,
                    );
                  })
              );
            },
            child: Image.network(
              bannerList[index].icon,
              fit: BoxFit.fill,
            ),
          );
        },
        pagination: const SwiperPagination(),
      ),
    );
  }

  _jumpToSearch() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return const SearchPage(hint: searchBarDefaultText, hideLeft: false);
        })
    );
  }

  _jumpToSpeak() {
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) {
    //       return SpeakScreen();
    //     })
    // );
  }
}

