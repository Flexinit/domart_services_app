import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
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

class Buyairtime extends StatefulWidget {
  final String provider;

  Buyairtime(this.provider);

//  var userArr;
//  Buyairtime({Key key}) : super(key: key);

  @override
  _BuyairtimeState createState() => _BuyairtimeState(this.provider);
}

class _BuyairtimeState extends State<Buyairtime> {
  // access preferences
  String userid;
  var userArrr, userjson;

  final String provider;

  _BuyairtimeState(this.provider);

  Future getuserid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userid_a = await preferences.getString('userdata');
    return userid_a;
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  PhoneContact _phoneContact;
  final txtPhone = TextEditingController();

  void dispose() {
    txtPhone.dispose();
    super.dispose();
  }

  String recipient_no, amount;
  String pmt_mode;

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

    Future validate() async {
      if ((recipient_no.substring(0, 1)) == "0") {
        recipient_no = '254' + recipient_no.substring(1);
      }

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
      } else if (int.parse(amount) < 10) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text(
                    "Please enter value greater than or equals to Ksh 10!"),
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
      } else if (recipient_no?.length != 12 ) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("Please input a Valid recipient phone no. Begin with 07"),
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
      }

      else if (pmt_mode?.isEmpty ?? true) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("Please select preferred payment mode"),
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
       // try {
//          print("accessible");
         ProgressDialog pr = new ProgressDialog(context,
              type: ProgressDialogType.Normal,
              showLogs: true,
              isDismissible: false);
          pr.style(message: 'Please wait...');
          pr.show();

          String url = Definitions.api_url + Definitions.endpoint_initiate_pmt;

          var timestamp = new DateTime.now().millisecondsSinceEpoch;

          String oid = userArrr['id'].toString() + timestamp.toString();

          print(oid);

          var data = {
            "email": userArrr["email"],
            "oid": oid,
            "inv": oid,
            "tel": userArrr["phone"],
            "amount": amount,
            "app_token": Definitions.app_token,
            "fname": userArrr["fname"],
            "lname": userArrr["lname"],
            "user_id": userArrr["id"],
            "payment_to": provider,
            "payment_grp": "airtime",
            "account": recipient_no
          };
          print(data);
          var response = await http.post(Uri.parse(url), body: json.encode(data));
          print('started at ' + url);
          var jsonresponse = json.decode(response.body);
          print('responded with ' + response.body);



              switch (pmt_mode) {
                case "MPESA":
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Mpesa('sid', amount, userArrr['phone'],
                              oid, '0', 'payto', 'paygrp', recipient_no)));
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
            }*/
          }
       /* } catch (e) {}
      }*/
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Buy Airtime",
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
              child: Stack(
                alignment: Alignment.centerRight,
                children: <Widget>[
                  TextField(
                    controller: txtPhone,
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      recipient_no = value;
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
                          borderSide:
                              BorderSide(width: 1, color: Colors.black)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.yellowAccent)),
                      hintText: "Mobile Number",
                      helperText: "Enter mobile number of recipient(07___)",
                      helperStyle: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                      ),
                      hintStyle: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                /*  IconButton(
                    icon: Icon(Icons.perm_contact_calendar),
                    onPressed: () async {
                      try {
                        final PhoneContact contact =
                            await FlutterContactPicker.pickPhoneContact();

                        setState(() {
//                       print("accessible");
                          _phoneContact = contact;
                        });
                        if (_phoneContact != null) {
                          txtPhone.text =
                              _phoneContact.phoneNumber.number.toString();
                          recipient_no = txtPhone.text;
//                       print(_contact.toString());

                        }
                      } catch (e) {
                        print(e.toString());
                      }
                    },
                  )*/
                ],
              )),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              keyboardType: TextInputType.number,
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
                helperText: "Enter airtime amount to send to number",
                helperStyle: GoogleFonts.quicksand(
                  fontWeight: FontWeight.bold,
                ),
                hintStyle: GoogleFonts.quicksand(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
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
                //color: Color(0xffc70404),
                onPressed: () {
                  validate();
                },
                child: Text("Buy Airtime",
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
