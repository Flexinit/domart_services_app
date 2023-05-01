import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
class DecoderContainer extends StatefulWidget {
//  final url;
  DecoderContainer();
  @override
  createState() => _DecoderContainerState();
}
class _DecoderContainerState extends State<DecoderContainer> {
  String userid;
  Future getuserid()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    setState(() {
      userid=preferences.getString('userdata');

    });
  }

//  final _key = UniqueKey();
  _DecoderContainerState();
  @override
  Widget build(BuildContext context) {
    getuserid();
    var userArrr = jsonDecode(userid);
//    Map<String, dynamic> map = jsonDecode(userid);
    var _url = "http://checkout.ondla.co/decoders.php?email="+userArrr['email']+"&phone_no="+userArrr['phone']+"&name="+userArrr['phone']+"&description=airtime purchase";

    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Expanded(
                child: WebView(
//                    key: _key,
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: _url))
          ],
        ));
  }
}