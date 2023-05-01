import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
class WebViewContainer extends StatefulWidget {
//  final url;
  WebViewContainer();
  @override
  createState() => _WebViewContainerState();
}
class _WebViewContainerState extends State<WebViewContainer> {
  String userid;
  Future getuserid()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    setState(() {
      userid=preferences.getString('userdata');

    });
  }

//  final _key = UniqueKey();
  final Set gestureRecognizers = [
    Factory(() => EagerGestureRecognizer()),
  ].toSet();
  _WebViewContainerState();
  @override
  Widget build(BuildContext context) {
    getuserid();
    var userArrr = jsonDecode(userid);
//    Map<String, dynamic> map = jsonDecode(userid);
    var _url = "http://checkout.ondla.co/airtime.php?email="+userArrr['email']+"&phone_no="+userArrr['phone']+"&name="+userArrr['phone']+"&description=airtime purchase";

    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Expanded(
                child: WebView(
//                    key: _key,
                    gestureRecognizers: gestureRecognizers,
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: _url))
          ],
        ));
  }
}