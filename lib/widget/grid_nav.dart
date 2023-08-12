
import 'package:flutter/material.dart';
import 'package:flutter_trip_xc/model/grid_nav_model.dart';
import 'package:flutter_trip_xc/widget/web_view_Screen.dart';

import '../model/common_model.dart';

class GridNav extends StatelessWidget {
  final GridNavModel? gridNavModel;

  const GridNav({Key? key,required this.gridNavModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 使用PhysicalModel实现圆角效果
    // 使用decoration没有圆角效果，是因为decoration是在child之下的，把child的圆角给遮住了
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: _gridNavItems(context),
      ),
    );
  }
  _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    if (gridNavModel == null) return items;
    items.add(_gridNavItem(context, gridNavModel!.hotel, true));
    items.add(_gridNavItem(context, gridNavModel!.flight, false));
    items.add(_gridNavItem(context, gridNavModel!.travel, false));
    return items;
  }
  _gridNavItem(BuildContext context, GridNavItem gridNavItem, bool first) {
    List<Widget> items = [];
    items.add(_mainItem(context, gridNavItem.mainItem));
    items.add(_doubleItem(context, gridNavItem.item1, gridNavItem.item2));
    items.add(_doubleItem(context, gridNavItem.item3, gridNavItem.item4));
    List<Widget> expandItems = [];
    for (var item in items) {
      expandItems.add(Expanded(flex: 1,child: item,));
    }
    Color startColor = Color(int.parse('0xff${gridNavItem.startColor}'));
    Color endColor = Color(int.parse('0xff${gridNavItem.endColor}'));
    return Container(
      height: 88,
      margin: first ? null : const EdgeInsets.only(top: 3),
      // 渐变色
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [startColor, endColor]),
      ),
      child: Row(
        children: expandItems,
      ),
    );
  }
  _mainItem(BuildContext context, CommonModel model) {
    return _wrapGesture(
      context,
      Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Image.network(
            model.icon,
            fit: BoxFit.contain,
            height: 88,
            width: 121,
            alignment: AlignmentDirectional.bottomEnd,
          ),
          Container(
            margin: const EdgeInsets.only(top: 11),
            child: Text(
              model.title,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ],
      ),
      model,
    );
  }
  _doubleItem(BuildContext context, CommonModel topItem, CommonModel bottomItem) {
    return Column(
      children: <Widget>[
        // Expanded撑满剩余空间, 垂直方向撑满
        Expanded(
          child: _item(
            context,
            topItem,
            true,
          ),
        ),
        Expanded(
          child: _item(
            context,
            bottomItem,
            false,
          ),
        ),
      ],
    );
  }
  _item(BuildContext context, CommonModel item, bool first) {
    BorderSide borderSide = const BorderSide(width: 0.8, color: Colors.white);
    // FractionallySizedBox宽度撑满父布局, 水平方向撑满
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: borderSide,
            bottom: first ? borderSide : BorderSide.none,
          ),
        ),
        child: _wrapGesture(
          context,
          Center(
            child: Text(
              item.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
          item,
        ),
      ),
    );
  }
  _wrapGesture(BuildContext context, Widget widget, CommonModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewScreen(
              url: model.url,
              statusBarColor: model.statusBarColor,
              hideAppBar: model.hideAppBar,
              title: model.title,
            )
          )
        );
      },
      child: widget,
    );
  }

}
