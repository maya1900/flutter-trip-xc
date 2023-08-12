import 'package:flutter/material.dart';
import 'package:flutter_trip_xc/dao/search_dao.dart';
import 'package:flutter_trip_xc/model/search_model.dart';
import 'package:flutter_trip_xc/widget/search_bar.dart';

import '../widget/web_view_Screen.dart';

const url =
    'https://m.ctrip.com/restapi/h5api/globalsearch/search?userid=M2208559994&source=mobileweb&action=mobileweb&keyword=';
class SearchPage extends StatefulWidget {
  final String? keyword;
  final String? hint;
  final bool hideLeft;
  final String? searchUrl;

  const SearchPage({super.key, this.keyword, this.hint, this.hideLeft = true, this.searchUrl = url});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String keyword = '';
  SearchModel? searchModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(),
          MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Expanded(
                flex: 1,
                child: ListView.builder(
                  itemCount: searchModel?.data?.length ?? 0,
                  itemBuilder: (BuildContext context, int position) {
                    return _item(position);
                  },
                ),
              )
          )
        ],
      ),

    );
  }

  void _onTextChange(String text) {
    keyword = text;
    if (text.isEmpty) {
      setState(() {
        searchModel = null;
      });
      return;
    }
    String url = widget.searchUrl! + text;
    SearchDao.fetch(url, text).then((SearchModel value) {
      if (value.keyword == keyword) {
        setState(() {
          searchModel = value;
        });
      }
    }).catchError((e) {
      print(e);
    });

  }

  _appBar() {
    return Column(
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.only(top: 30),
            height: 80,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: SearchBarWidget(
              hideLeft: widget.hideLeft,
              defaultText: widget.keyword,
              hint: widget.hint,
              leftButtonClick: () {
                Navigator.pop(context);
              },
              onChanged: _onTextChange,
            ),
          ),
        ),
      ],
    );
  }

  _item(int position) {
    SearchItem item = searchModel!.data![position];
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebViewScreen(
                  url: item.url,
                  title: '详情',
                )));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0.3,
              color: Colors.grey,
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            // Container(
            //   margin: const EdgeInsets.all(1),
            //   child: Image(
            //     width: 26,
            //     height: 26,
            //     image: AssetImage(_typeImage(item.type)),
            //   ),
            // ),
            Column(
              children: <Widget>[
                Container(
                  width: 300,
                  child: _title(item),
                ),
                Container(
                  width: 300,
                  margin: const EdgeInsets.only(top: 5),
                  child: _subTitle(item),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _typeImage(String? type) {
    if (type == null) return 'images/type_travelgroup.png';
    String path = 'travelgroup';
    if (type.contains('travelgroup')) {
      path = 'travelgroup';
    } else if (type.contains('flight')) {
      path = 'flight';
    } else if (type.contains('hotel')) {
      path = 'hotel';
    } else if (type.contains('travel')) {
      path = 'travel';
    }
    return 'images/type_$path.png';
  }

  _subTitle(SearchItem item) {
    return RichText(
      text: TextSpan(
        text: item.word!.substring(0, keyword.length),
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: item.word!.substring(keyword.length),
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  _title(SearchItem? item) {
    if (item == null) return null;
    List<TextSpan> spans = [];
    spans.addAll(_keywordTextSpans(item.word!, searchModel!.keyword!));
    spans.add(TextSpan(
      text: ' ${item.districtname ?? ''} ${item.zonename ?? ''}',
      style: const TextStyle(
        color: Colors.grey,
      ),
    ));
    return RichText(text: TextSpan(children: spans));
  }

  _keywordTextSpans(String word, String keyword) {
    List<TextSpan> spans = [];
    if (word.length == 0) return spans;
    List<String> arr = word.split(keyword);
    TextStyle normalStyle = const TextStyle(
      color: Colors.black87,
    );
    TextStyle keywordStyle = const TextStyle(
      color: Colors.orange,
    );
    for (int i = 0; i < arr.length; i++) {
      if ((i + 1) % 2 == 0) {
        spans.add(TextSpan(text: keyword, style: keywordStyle));
      }
      String val = arr[i];
      if (val.length > 0) {
        spans.add(TextSpan(text: val, style: normalStyle));
      }
    }
    return spans;
  }
}