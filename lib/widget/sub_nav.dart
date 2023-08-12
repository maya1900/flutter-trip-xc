
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip_xc/widget/web_view_Screen.dart';

import '../model/common_model.dart';

class SubNav extends StatelessWidget {
  final List<CommonModel>? subNavList;

  const SubNav({Key? key, this.subNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    if (subNavList == null) return null;
    List<Widget> items = [];
    for (var model in subNavList!) {
      items.add(_item(context, model));
    }
    // 计算出第一行显示的数量
    int separate = (subNavList!.length / 2 + 0.5).toInt();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0, separate),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(separate, subNavList!.length),
        ),
      ],
    );
  }

  _item(BuildContext context, CommonModel model) {
    // GestureDetector 用于监听点击事件
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebViewScreen(
                url: model.url,
                statusBarColor: model.statusBarColor,
                hideAppBar: model.hideAppBar,
              ),
            ),
          );
        },
        child: Column(
          children: [
            Image.network(
              model.icon,
              width: 18,
              height: 18,
            ),
            Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(
                  model.title,
                  style: const TextStyle(fontSize: 12),
                )
            ),
          ],
        ),
      )
    );
  }

}