import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:soko/pages/main/mainpage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soko/common/definitions.dart';
import 'package:http/http.dart' as http;


class AirtelMoney extends StatefulWidget {
  final String server_sid,server_amountBilled,server_acc_no,oid,payto,paygrp,accno;
  AirtelMoney(this.server_sid,this.server_amountBilled,this.server_acc_no,this.oid,this.payto, this.paygrp, this.accno);

  @override
  _AirtelMoneyState createState() => _AirtelMoneyState(this.server_sid,this.server_amountBilled,this.server_acc_no,this.oid,this.payto, this.paygrp, this.accno);
}

class _AirtelMoneyState extends State<AirtelMoney> {
// access preferences
  String userid;

  Future getuserid()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    setState(() {
      userid=preferences.getString('userdata');
    });
  }
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String recipient_no, amount;
  String pmt_mode ;
  final String server_sid,server_amountBilled,server_acc_no,oid,payto,paygrp,accno;
  _AirtelMoneyState(this.server_sid,this.server_amountBilled,this.server_acc_no,this.oid,this.payto, this.paygrp, this.accno);
  @override
  Widget build(BuildContext context) {
    getuserid();
    var userArrr = json.decode(userid);
    Future verifyPayment() async {
      try {
        ProgressDialog pr = new ProgressDialog(context,
            type: ProgressDialogType.Normal, showLogs: true,isDismissible: false);
        pr.style(message: 'Please wait...');
        pr.show();

        String url = Definitions.api_url+Definitions.endpoint_mobilemoney;
        var data = {"oid": oid,"sid" : server_sid, "amt_billed" : server_amountBilled, "app_token" : Definitions.app_token,"user_id" : userArrr["id"],"payment_to" : payto, "payment_grp" : paygrp, "account" : accno};
        print(data);
        var response = await http.post(Uri.parse(url),
            body: json.encode(data));
        print(response.body);
        var jsonresponse = json.decode(response.body);

        if (jsonresponse["status"] != null) {
          var status = jsonresponse["status"];
          if(status == '00'){
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

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Airtel Money",style:
        GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),),
      ),

      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          SizedBox(height: 30,),
          Container(
            padding: EdgeInsets.all(10),
            child: Text('Navigate to your STK, choose paybill and pay to the following account details.',
              style: GoogleFonts.quicksand(
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              )),
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.all(10),
            child: Text('1) Paybill: 510800',
                style: GoogleFonts.quicksand(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                )),
          ),

          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.all(10),
            child: Text('2) Account number: '+ server_acc_no,
                style: GoogleFonts.quicksand(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                )),
          ),

          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.all(10),
            child: Text('3) Amount: '+ server_amountBilled,
                style: GoogleFonts.quicksand(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                )),
          ),

          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.all(10),
            child: Text('After sending the payment and receiving the confirmation message, click verify button below',
                style: GoogleFonts.quicksand(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                )),
          ),

          SizedBox(height: 40,),

          Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: ButtonTheme(
              height: 40,
              minWidth: 300,
              child: ElevatedButton(
               // color: Color(0xffc70404),
                onPressed: () {
                  verifyPayment();
                },
                child: Text("Verify payment",
                    style: GoogleFonts.quicksand(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    )),
              ),
            ),
          ),

        ],

      ),
    );
  }
}