import 'package:flutter/material.dart';

import '../pages/home_page.dart';
import '../pages/my_page.dart';
import '../pages/search_page.dart';
import '../pages/travel_page.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final _defaultColor = Colors.grey; // 默认颜色
  final _activeColor = Colors.blue; // 激活颜色
  int _currentIndex = 0; // 当前选中的索引
  final PageController _controller = PageController(
    initialPage: 0, // 默认选中第一个
  ); // PageView的控制器

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomePage(),
          SearchPage(hideLeft: true,),
          TravelPage(),
          MyPage(),
        ], // 禁止滚动
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // 当前选中的索引
        onTap: (index) { // 点击事件
          _controller.jumpToPage(index); // 跳转到指定页面
          setState(() { // 刷新状态
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed, // 固定
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: _defaultColor),
            activeIcon: Icon(Icons.home, color: _activeColor),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: _defaultColor),
            activeIcon: Icon(Icons.search, color: _activeColor),
            label: '搜索',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt, color: _defaultColor),
            activeIcon: Icon(Icons.camera_alt, color: _activeColor),
            label: '旅拍',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: _defaultColor),
            activeIcon: Icon(Icons.account_circle, color: _activeColor),
            label: '我的',
          ),
        ],
      ),
    );
  }
}