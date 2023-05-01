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

class ShoppingCheckout extends StatefulWidget {
  String productName;
  String productPrice;

  ShoppingCheckout(this.productName, this.productPrice);

  @override
  _ShoppingCheckoutState createState() =>
      _ShoppingCheckoutState(this.productName, this.productPrice);
}

class _ShoppingCheckoutState extends State<ShoppingCheckout> {
  // access preferences
  String userid;
  var userArrr, userjson;

  Future getuserid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userid_a = await preferences.getString('userdata');
    return userid_a;
  }

  String nai_meter, kiwasco;
  String nai_meter_s, kiwasco_s;

  String  amount, pmt_mode;
  String server_mtrno;

  String productName;
  String productPrice;

  _ShoppingCheckoutState(this.productName, this.productPrice);
  var  _controllerMeterNumber = new  TextEditingController();
  var  _controllerAmount = new  TextEditingController();

  Future getNairobiWater() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nai_meter_s = preferences.getString('user_naiwater');
    });
  }

  Future getKiwasco() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      kiwasco_s = preferences.getString('kiwasco_meter');
    });
  }

  @override
  void initState() {
    super.initState();
    getuserid().then((value) => setState(() {
          userjson = value;
          userArrr = json.decode(userjson);
        }));
    getNairobiWater();
    getKiwasco();
  }

  @override
  Widget build(BuildContext context) {


    Future validate() async {
      amount = _controllerAmount.text;
      if (productName?.isEmpty ?? false) {
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
      } else if (productPrice?.isEmpty ?? false) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("Please input meter no."),
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
        try {
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
                "tel": userArrr["phone"],
                "amount": amount,
                "app_token": Definitions.app_token,
                "fname": userArrr["fname"],
                "lname": userArrr["lname"],
                "user_id": userArrr["id"],
                "payment_to": "NAIROBI_WTR",
                "payment_grp": "bills",
                "account": productName
              }));

          var jsonresponse = json.decode(response.body);

         /* if (jsonresponse["status"] != null) {
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
                      builder: (context) => Mpesa('sid', amount, userArrr['phone'],
                          oid, '0', 'payto', 'paygrp', userArrr["phone"])));
              break;
            case "AIRTELMONEY":
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AirtelMoney('sid', amount, userArrr['phone'],
                          oid, '0', 'payto', 'paygrp')));
              break;

            case "T-KASH":
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => T_kash('sid', amount, userArrr['phone'],
                          oid, '0', 'payto', 'paygrp')));
              break;



          }
           /* } else {
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
          }*/
        } catch (e) {}
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment',
          style: GoogleFonts.quicksand(
              fontWeight: FontWeight.bold,
              color: Colors.purple
          ),

        ),
        backgroundColor: Colors.purple[50],
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              "Payment",
              style: GoogleFonts.quicksand(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                keyboardType: TextInputType.text,
                onChanged: (value) {
                /*  if(productName.isEmpty){

                    meter_no = server_mtrno;
                  }
                  meter_no = value;*/
                },
                controller: TextEditingController(text: this.productName),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Colors.purple),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Colors.purple),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Colors.purple),
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
                  hintText: "Product ",
                  helperText: "Product name",
                  helperStyle: GoogleFonts.quicksand(
                    fontWeight: FontWeight.bold,
                  ),
                  hintStyle: GoogleFonts.quicksand(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
          Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  amount = this.amount;
                },
                controller: TextEditingController(text: this.productPrice),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Colors.purple),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Colors.orange),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Colors.purple),
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
                  helperText: "Amount",
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

              onSelected: (String selected) => setState(() {
                pmt_mode = selected.replaceAll(' ', '');
              }),

              labels: <String>[
                "     MPESA     ",

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
          Image.asset(
              "assets/mpesa.jpg",
            width: 1,
            height: 100,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: ButtonTheme(
              height: 40,
              minWidth: 300,
              child: ElevatedButton(
                //color: Colors.purple,
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
