import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:soko/common/definitions.dart';
import 'package:soko/pages/payments/payment_modes/airtel_money.dart';
import 'package:soko/pages/payments/payment_modes/credit_card.dart';
import 'package:soko/pages/payments/payment_modes/mpesa.dart';
import 'package:soko/pages/payments/payment_modes/tkash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Powerbill extends StatefulWidget {
  final String service, meter_type;

  Powerbill(this.meter_type, this.service);

  @override
  _PowerbillState createState() =>
      _PowerbillState(this.meter_type, this.service);
}

class _PowerbillState extends State<Powerbill> {
  // access preferences
  String userid;
  var userArrr, userjson;

  Future getuserid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userid_a = await preferences.getString('userdata');
    return userid_a;
  }

  String meter_no, amount, pmt_mode;
  final String service, meter_type;

  _PowerbillState(this.meter_type, this.service);

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
    meter_no = service;
    Future validate() async {
      if (amount?.isEmpty ?? true) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("Please input amount"),
                actions: <Widget>[
                  ElevatedButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
      } else if (meter_no?.isEmpty ?? true) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("Please input meter no"),
                actions: <Widget>[
                  ElevatedButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
      } else if (int.parse(amount) < 10) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("Please enter value greater than Ksh 10!"),
                actions: <Widget>[
                  ElevatedButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
      } else {
        // prepare the payment
      //  try {
          ProgressDialog pr = new ProgressDialog(context,
              type: ProgressDialogType.Normal,
              showLogs: true,
              isDismissible: false);
          pr.style(message: 'Please wait...');
          pr.show();

          String url = Definitions.api_url + Definitions.endpoint_initiate_pmt;
          var timestamp = new DateTime.now().millisecondsSinceEpoch;
          String oid = userArrr['id'].toString() + timestamp.toString();

          var response = await http.post(Uri.parse(url),
              body: json.encode({
                "email": userArrr["email"],
                "oid": oid,
                "inv": oid,
                "phone": userArrr["phone"],
                "tel": userArrr["phone"],
                "amount": amount,
                "app_token": Definitions.app_token,
                "fname": userArrr["fname"],
                "lname": userArrr["lname"],
                "user_id": userArrr["id"],
                "payment_to": meter_type,
                "payment_grp": "bills",
                "account": meter_no
              }));

          print('++++++++++INITIATE_PAYMENT_REQUEST_DATA+++OID+$oid++++METER_TYPE:$meter_type');
          var jsonresponse = json.decode(response.body);
          print('++++++++++INITIATE_PAYMENT_RESPONSE_DATA++++$jsonresponse');

        /*  if (jsonresponse["status"] != null) {
            var status = jsonresponse["status"];
            if (status == '00') {
              pr.hide();
              var data = jsonresponse["data"];
              var misc = jsonresponse['misc'];
              var payto = misc['payment_to'];
              var paygrp = misc['payment_grp'];
              var accno = misc['account'];
              var sid = data['sid'];
              var amountBilled = data['amount'];
              var acc_no = data['account'];
*/
              switch (pmt_mode) {
                case "MPESA":
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Mpesa('sid', amount, meter_no,
                              oid, '0', 'payto', 'paygrp', meter_no)));
                  break;
              /*  case "AIRTELMONEY":
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AirtelMoney(sid, amountBilled,
                              acc_no, oid, payto, paygrp, accno)));
                  break;
                case "CREDITCARD":
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CreditCard(sid, amountBilled, acc_no, oid)));
                  break;
                case "T-KASH":
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => T_kash(sid, amountBilled,
                              acc_no, oid, payto, paygrp, accno)));
                  break;*/
              }
          /*  } else {
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
        } catch (e) {}*/
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Bill",
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              "KPLC Tokens",
              style: GoogleFonts.quicksand(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                meter_no = value;
              },
              controller: TextEditingController(text: service),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1, color: Colors.red),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1, color: Colors.orange),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1, color: Colors.red),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(
                      width: 1,
                    )),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Colors.black)),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide:
                        BorderSide(width: 1, color: Colors.yellowAccent)),
                hintText: "Meter Number",
                helperText: "Enter meter",
                helperStyle: GoogleFonts.quicksand(
                  fontWeight: FontWeight.bold,
                ),
                hintStyle: GoogleFonts.quicksand(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  amount = value;
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Colors.red),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Colors.orange),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Colors.red),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(
                        width: 1,
                      )),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 1, color: Colors.black)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide:
                          BorderSide(width: 1, color: Colors.yellowAccent)),
                  hintText: "Amount",
                  helperText: "Enter amount",
                  helperStyle: GoogleFonts.quicksand(
                    fontWeight: FontWeight.bold,
                  ),
                  hintStyle: GoogleFonts.quicksand(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: RadioButtonGroup(
              orientation: GroupedButtonsOrientation.HORIZONTAL,
//               margin: const EdgeInsets.only(left: 12.0),
              onSelected: (String selected) {
                pmt_mode = selected.replaceAll(' ', '');
              },
              labels: <String>[
                "     MPESA     ",
                "     AIRTEL MONEY     ",
                "     T-KASH     "
              ],
//               picked: pmt_mode,
              itemBuilder: (Radio rb, Text txt, int i) {
                return Column(
                  children: <Widget>[
                    rb,
                    txt,
                  ],
                );
              },
            ),
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
               // color: Color(0xffc70404),
                onPressed: () {
                  validate();
                },
                child: Text("Pay",
                    style: GoogleFonts.quicksand(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
