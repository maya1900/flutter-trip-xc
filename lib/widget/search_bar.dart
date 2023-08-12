
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip_xc/widget/web_view_Screen.dart';

import '../model/common_model.dart';

enum SearchBarType { normal, home, homeLight }
class SearchBarWidget extends StatefulWidget {
  final bool enabled;
  final bool hideLeft;
  final SearchBarType searchBarType;
  final String? hint;
  final String? defaultText;
  final void Function()? leftButtonClick;
  final void Function()? rightButtonClick;
  final void Function()? speakClick;
  final void Function()? inputBoxClick;
  final ValueChanged<String>? onChanged;

  const SearchBarWidget({
    Key? key,
    this.enabled = true,
    this.hideLeft = true,
    this.searchBarType = SearchBarType.normal,
    this.hint,
    this.defaultText,
    this.leftButtonClick,
    this.rightButtonClick,
    this.speakClick,
    this.inputBoxClick,
    this.onChanged,
  }) : super(key: key);

  SearchBarState createState() => SearchBarState();
}

class SearchBarState extends State<SearchBarWidget> {
  bool showClear = false;
  // 这个是为了控制输入框的内容
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.defaultText != null) {
      setState(() {
        _controller.text = widget.defaultText!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchBarType == SearchBarType.normal ? _getNormalSearch() : _getHomeSearch();
  }

  _getNormalSearch() {
    return Container(
      child: Row(
        children: <Widget>[
          _wrapTap(
            Container(
              padding: const EdgeInsets.fromLTRB(6, 5, 10, 5),
              child: widget?.hideLeft ?? false ? null : const Icon(Icons.arrow_back_ios, color: Colors.grey, size: 26),
            ),
            widget.leftButtonClick,
          ),
          Expanded(
            flex: 1,
            child: _inputBox(),
          ),
          _wrapTap(
            Container(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: const Text('搜索', style: TextStyle(color: Colors.blue, fontSize: 17)),
            ),
            widget.rightButtonClick,
          ),
        ],
      ),
    );
  }

  _getHomeSearch() {
    return Container(
      child: Row(
        children: <Widget>[
          _wrapTap(
            Container(
              padding: const EdgeInsets.fromLTRB(6, 5, 5, 5),
              child: const Row(
                children: <Widget>[
                  Text('上海', style: TextStyle(color: Colors.white, fontSize: 14)),
                  Icon(Icons.expand_more, color: Colors.white, size: 22),
                ],
              ),
            ),
            widget.leftButtonClick,
          ),
          Expanded(
            flex: 1,
            child: _inputBox(),
          ),
          _wrapTap(
            Container(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: const Icon(Icons.comment, color: Colors.white, size: 26),
            ),
            widget.rightButtonClick,
          ),
        ],
      ),
    );
  }

  _wrapTap(Widget child, void Function()? callback) {
    return GestureDetector(
      onTap: () {
        if (callback != null) callback();
      },
      child: child,
    );
  }

  _inputBox() {
    Color inputBoxColor;
    if (widget.searchBarType == SearchBarType.home) {
      inputBoxColor = Colors.white;
    } else {
      inputBoxColor = Color(int.parse('0xffEDEDED'));
    }
    return Container(
      height: 30,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: inputBoxColor,
        borderRadius: BorderRadius.circular(widget.searchBarType == SearchBarType.normal ? 5 : 15),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.search, size: 20, color: Colors.grey),
          Expanded(
            // flex: 1,
            child: widget.searchBarType == SearchBarType.normal ? TextField(
              controller: _controller,
              onChanged: _onChanged,
              autofocus: true,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
              // 输入框样式
              decoration: InputDecoration(
                // contentPadding的意思是：内边距
                // EdgeInsets.fromLTRB fromLTRB的意思是：左上右下
                contentPadding: const EdgeInsets.only(left: 5, top: -20),
                border: InputBorder.none,
                hintText: widget.hint ?? '',
                hintStyle: const TextStyle(fontSize: 15),
              ),
            ) : _wrapTap(
              Container(
                child: Text(
                  widget.defaultText ?? '',
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ),
              widget.inputBoxClick,
            ),
          ),
          !showClear ? _wrapTap(
            const Icon(Icons.mic, size: 22, color: Colors.blue),
            widget.speakClick,
          ) : _wrapTap(
            const Icon(Icons.clear, size: 22, color: Colors.grey),
            () {
              setState(() {
                _controller.clear();
              });
              _onChanged('');
            },
          ),
        ],
      ),
    );
  }

  _onChanged(String text) {
    if (text.length > 0) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }
    if (widget.onChanged != null) {
      widget.onChanged!(text);
    }
  }

}