import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:soko/common/AppConfig.dart';
import 'package:soko/pages/main/mainpage.dart';
import 'package:soko/common/definitions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Mpesa extends StatefulWidget {
  final String server_sid,
      server_amountBilled,
      server_acc_no,
      oid,
      payto,
      paygrp,
      accno;
  String showed;

  Mpesa(this.server_sid, this.server_amountBilled, this.server_acc_no, this.oid,
      this.showed, this.payto, this.paygrp, this.accno);

  @override
  _MpesaState createState() => _MpesaState(
      this.server_sid,
      this.server_amountBilled,
      this.server_acc_no,
      this.oid,
      this.showed,
      this.payto,
      this.paygrp,
      this.accno);
}

class _MpesaState extends State<Mpesa> {
  // access preferences
  String userid;
  var userArrr, userjson;

  Future getuserid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userid_a = await preferences.getString('userdata');
    return userid_a;
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String recipient_no, amount;
  String pmt_mode;

  final String server_sid,
      server_amountBilled,
      server_acc_no,
      oid,
      payto,
      paygrp,
      accno;
  String showed;

  _MpesaState(this.server_sid, this.server_amountBilled, this.server_acc_no,
      this.oid, this.showed, this.payto, this.paygrp, this.accno);

  @override
  void initState() {
    super.initState();
    getuserid().then((value) => setState(() {
          userjson = value;
          userArrr = json.decode(userjson);
        }));
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, showLogs: true, isDismissible: false);


    Future verifyPayment() async {
      try {
        pr.style(message: 'Please wait...');
        pr.show();

        String url = Definitions.api_url + Definitions.endpoint_mobilemoney;

        var response = await http.post(Uri.parse(url),
            body: json.encode({
              "oid": oid,
              "sid": server_sid,
              "amt_billed": server_amountBilled,
              "app_token": Definitions.app_token,
              "user_id": userArrr["id"],
              "payment_to": payto,
              "payment_grp": paygrp,
              "account": accno,
              "phone": userArrr["phone"],
              "commandId": AppConfig.commandId,
              "providerId": AppConfig.providerID
            }));

        var jsonresponse = json.decode(response.body);

        if (jsonresponse["status"] != null) {
          showed = '1';
          var status = jsonresponse["status"];
          if (status == '00') {
            //success message
            pr.hide().whenComplete(() {
              Fluttertoast.showToast(
                  msg: jsonresponse["message"],
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);

         /*     showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  titleTextStyle: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold, color: Color(0xffc70404)),
                  scrollable: true,
                  title: Text('SUCCESSFUL'),
                  content: Text('TOKEN CODE: '),
                  semanticLabel: 'BillSasa',
                ),
              );
*/

            });
          } else {
            //error message
            pr.hide().whenComplete(() {
              Fluttertoast.showToast(
                  msg: jsonresponse["message"],
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.redAccent,
                  textColor: Colors.white,
                  fontSize: 16.0);
            });
          }

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Mainpage()));
        }
      } catch (e) {}
    }



    Future initiateStk() async {
      // prepare the payment
      try {
        pr.style(message: 'Mpesa request will pop up soon...');
        pr.show();

        String url = Definitions.api_url + Definitions.endpoint_stk;
        String urlTest = Definitions.api_url + Definitions.endpoint_mpesa_stk;
        var data = {
          "oid": oid,
          "sid": server_sid,
          "phone": userArrr["phone"],
          "amt_billed": server_amountBilled,
          "app_token": Definitions.app_token,
          "user_id": userArrr["id"],
          "account": accno,
          "commandId": AppConfig.commandId,
          "providerId": AppConfig.providerID

        };

        print(data);
        var response = await http.post(Uri.parse(url), body: json.encode(data));
        print(server_sid);
        var jsonresponse = json.decode(response.body);
        print("++++++++++++RESPONSE FOR STK PUSH++++++${response.body}");
        if (jsonresponse["status"] != null) {
          showed = '1';
          var status = jsonresponse["status"];
          if (status == '00') {
            pr.hide();
       /*  .whenComplete(() {
              verifyPayment();
            });*/
          } else {
            //error message
            pr.hide().whenComplete(() {
              Fluttertoast.showToast(
                  msg: jsonresponse["message"],
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.redAccent,
                  textColor: Colors.white,
                  fontSize: 16.0);
            });
          }
        }
      } catch (e) {}
    }


    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Mpesa",
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
                'Request for STK push ONLY and Input yor PIN. Offline purchase directly using the Paybill Number is currently disabled. ',
                style: GoogleFonts.quicksand(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text('1) Paybill: 4068423',
                style: GoogleFonts.quicksand(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text('2) Account number: ' + server_acc_no,
                style: GoogleFonts.quicksand(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text('3) Amount: ' + server_amountBilled,
                style: GoogleFonts.quicksand(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
                'After sending the payment and receiving the confirmation message, click verify button below',
                style: GoogleFonts.quicksand(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: ButtonTheme(
              height: 40,
              minWidth: 300,
              child: ElevatedButton(
                //color: Color(0xffc70404),
                onPressed: () {
                  initiateStk();
                },
                child: Text("Request for STK",
                    style: GoogleFonts.quicksand(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
        /*  Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: ButtonTheme(
              height: 40,
              minWidth: 300,
              child: RaisedButton(
                color: Color(0xffc70404),
                onPressed: () {
                  verifyPayment();
                },
                child: Text("Verify payment",
                    style: GoogleFonts.quicksand(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}
