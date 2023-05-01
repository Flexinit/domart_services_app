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

class Adddtvbill extends StatefulWidget {
  final String name, imageasset;

  Adddtvbill(this.name, this.imageasset);

  @override
  _AdddtvbillState createState() =>
      _AdddtvbillState(this.name, this.imageasset);
}

class _AdddtvbillState extends State<Adddtvbill> {
  // access preferences
  String userid, server_mtrno;
  int minamt;
  TextEditingController _accountNumber = TextEditingController();

  var userArrr, userjson;

  var usersettings;
  String nai_meter, kplc_meter, star_times, dstv_no, go_tv;
  String jtl_s, nhif_s, parking_s, businessPermit_s, landRates_s, kasneb_s;

  Future getnai() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nai_meter = preferences.getString('user_naiwater');
    });
  }

  Future getkplc() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      kplc_meter = preferences.getString('user_kplc');
    });
  }

  Future getdstv() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      dstv_no = preferences.getString('user_dstv');
    });
  }

  Future getstar() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      star_times = preferences.getString('user_startimes');
    });
  }

  Future getgotv() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      go_tv = preferences.getString('user_gotv');
    });
  }

  Future getuserid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userid_a = await preferences.getString('userdata');
    return userid_a;
  }

  Future getjtl() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      jtl_s = preferences.getString('jtl');
    });
  }

  Future getnhif() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nhif_s = preferences.getString('nhif');
    });
  }

  Future getparking() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      parking_s = preferences.getString('parking');
    });
  }

  Future getbusiness_permit() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      businessPermit_s = preferences.getString('business_permit');
    });
  }

  Future getland_rates() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      landRates_s = preferences.getString('land_rates');
    });
  }

  Future getkasneb() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      kasneb_s = preferences.getString('kasneb');
    });
  }

  final String name, imageasset;
  String acc_no, pmt_mode, amount;

  _AdddtvbillState(this.name, this.imageasset);

  @override
  void initState() {
    super.initState();
    getuserid().then((value) => setState(() {
          userjson = value;
          userArrr = json.decode(userjson);
        }));
    getuserid();
    getdstv();
    getkplc();
    getgotv();
    getstar();
    getnai();
    getjtl();
    getnhif();
    getparking();
    getbusiness_permit();
    getland_rates();
    getkasneb();
  }

  @override
  Widget build(BuildContext context) {
    if (name == "DSTV") {
      server_mtrno = dstv_no;
      minamt = 10;
    }
    if (name == "GoTv") {
      server_mtrno = go_tv;
      minamt = 10;
    }
    if (name == "StarTimes") {
      server_mtrno = star_times;
      minamt = 10;
    }
    if (name == "Zuku") {
      server_mtrno = "";
      minamt = 10;
    }
    if (name == "Zuku Fibre") {
      server_mtrno = "";
      minamt = 200;
    }
    if (name == "NHIF") {
      server_mtrno = nhif_s;
      minamt = 500;
    }
    if (name == "JTL Fibre") {
      server_mtrno = jtl_s;
      minamt = 500;
    }
    if (name == "KASNEB") {
      server_mtrno = kasneb_s;
      minamt = 500;
    }
    if (name == "PACKING FEE") {
      server_mtrno = parking_s;
      minamt = 5;
    }
    if (name == "LAND RATES") {
      server_mtrno = landRates_s;
      minamt = 500;
    }
    if (name == "businessPermit") {
      server_mtrno = businessPermit_s;
      minamt = 500;
    }
    if (name == "NHIF") {
      server_mtrno = "";
      minamt = 500;
    }
    /*
    if (name == "NHIF") {
      server_mtrno = "";
      minamt = 500;
    }
    if (name == "NHIF") {
      server_mtrno = "";
      minamt = 500;
    }*/

    Future validate() async {
      if (amount?.isEmpty ?? false) {
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
      } else if (acc_no?.isEmpty ?? false) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("Please input account no"),
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
      } else if (int.parse(amount) < minamt) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("Please input amount greater than Ksh. " +
                    minamt.toString()),
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
          String tvname;
          switch (name) {
            case 'DSTV':
              tvname = "dstv";
              break;
            case 'GoTv':
              tvname = "gotv";
              break;
            case "StarTimes":
              tvname = "startimes";
              break;

            case "JTL Fibre":
              tvname = "JTL Fibre";

              break;
            case "NHIF":
              tvname = "NHIF";

              break;
            default:
              tvname = "zuku";
          }

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
                "payment_to": tvname,
                "payment_grp": "tv",
                "account": acc_no
              }));

          var jsonresponse = json.decode(response.body);
          print(
              '++++++++++SERVER RESPONSE+++++INITIATE TRANSACTION++++++${jsonresponse.toString()} ');



              switch (pmt_mode) {
                case "MPESA":
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Mpesa('sid', amount, acc_no,
                              'oid', '0', 'payto', 'paygrp', acc_no)));
                  break;

              }

      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
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
              this.name,
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
              /*   onChanged: (value) {
                setState(() {
                  if (!acc_no.isEmpty) {
                    acc_no = value;
                  } else {
                    acc_no = server_mtrno;
                  }
                });
              },*/
              controller: TextEditingController(text: server_mtrno),
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
                hintText: "Account Number",
                helperText: "Enter account number of service provider",
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
            height: 30,
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
                helperText: "Enter amount to pay",
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

              /*onSelected: (String selected) => setState(() {
                pmt_mode = selected.replaceAll(' ', '');
              }),*/
              onSelected: (String selected){
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
                child: Text("Pay now",
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
