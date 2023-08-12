
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
const catchUrl = ['m.ctrip.com/', 'm.ctrip.com/html5/', 'm.ctrip.com/html5'];

class WebViewScreen extends StatefulWidget {
  final String? url;
  final String? statusBarColor;
  final String? title;
  final bool? hideAppBar;
  final bool? backForbid;

  const WebViewScreen({Key? key, this.url, this.statusBarColor, this.title, this.hideAppBar, this.backForbid = false}) : super(key: key);

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebViewScreen> {
  late WebViewController controller;
  bool exiting = false;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            if (_isToMain(url) && !exiting) {
              if (widget.backForbid ?? false) {
                controller.goForward();
              } else {
                Navigator.pop(context);
                exiting = true;
              }
            }
          },
          onPageFinished: (String url) {
          },
        )
      )
      ..loadRequest(Uri.parse(widget.url!));
  }

  _isToMain(url) {
    bool isToMain = false;
    for (var value in catchUrl) {
      if (url?.endsWith(value) ?? false) {
        isToMain = true;
        break;
      }
    }
    return isToMain;
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(Color(int.parse('0xff$statusBarColorStr')), backButtonColor),
          Expanded(
            child: WebViewWidget(controller: controller,),
          )
        ],
      )
    );
  }

  _appBar(Color backgroundColor, Color backButtonColor) {
    if (widget.hideAppBar ?? false) {
      return Container(
        color: backgroundColor,
        height: 50,
      );
    } else {
      return Container(
        color: backgroundColor,
        padding: const EdgeInsets.fromLTRB(0, 40, 0, 10),
        child: FractionallySizedBox(
          widthFactor: 1,
          child: Stack(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  print('点击了返回');
                  Navigator.pop(context);
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.close,
                    color: backButtonColor,
                    size: 26,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    widget.title ?? '',
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}