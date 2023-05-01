import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soko/common/AppConfig.dart';
import 'package:soko/common/definitions.dart';
import 'package:soko/pages/ToursAndTravel/views/tours_and_travel_booking.dart';
import 'package:soko/pages/payments/addtvbill.dart';
import 'package:soko/pages/payments/airtime.dart';
import 'package:soko/pages/payments/power.dart';
import 'package:soko/pages/payments/powergetbill.dart';
import 'package:soko/pages/payments/watergetbill.dart';
import 'package:soko/pages/payments/kasneb.dart';
import 'dart:convert';

import 'package:soko/pages/payments/waterpaybill.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var usersettings;
  String nai_meter, kplc_meter, star_times, dstv_no, go_tv, kiwasco;

  Future getnai() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nai_meter = preferences.getString('user_naiwater');
    });
  }

  Future getKiwasco() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      kiwasco = preferences.getString('kiwasco_meter');
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

  String userid;

  Future getuserid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userid = preferences.getString('userdata');
    });
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  _HomeState();

  @override
  Widget build(BuildContext context) {
    getuserid();
    getdstv();
    getkplc();
    getgotv();
    getstar();
    getnai();
    getKiwasco();

    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: ListView(
        children: <Widget>[
          Container(
            height: 230,
            child: Carousel(
              boxFit: BoxFit.contain,
              autoplay: true,
              animationCurve: Curves.easeInOut,
              animationDuration: Duration(milliseconds: 2000),
              overlayShadow: false,
              overlayShadowSize: 0.3,
              overlayShadowColors: Colors.purple[50],

              dotSize: 6.0,
              dotIncreasedColor:Theme.of(context).secondaryHeaderColor,
              dotBgColor: Colors.transparent,
              dotPosition: DotPosition.bottomCenter,
              dotVerticalPadding: 10.0,
              showIndicator: true,
              indicatorBgPadding: 0.0,
              images: [
                ExactAssetImage("assets/airtel_saf.jpeg"),
                ExactAssetImage("assets/cheap_airtime.jpeg"),
                ExactAssetImage("assets/honey.jpeg"),
              ],
            ),
          ),
          SizedBox(
            height: 1,
          ),
          Card(
            borderOnForeground: true,
            shadowColor: Theme.of(context).primaryColor,
            margin: EdgeInsets.all(15.0),
            elevation: 5.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),

            child: Container(
              color: Theme.of(context).secondaryHeaderColor,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Airtime",
                      style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 30, left: 30),
                    child: Text(
                      "Recharge your airtime",
                      style: GoogleFonts.quicksand(fontWeight: FontWeight.normal),
                    ),
                  ),

                  Container(
                    height: 100,
                    padding: EdgeInsets.all(10),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Card(
                            child: GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/saf.png",
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              onTap: () {

                                AppConfig.commandId = Definitions.TOPUP_FLEXI;
                                AppConfig.providerID = Definitions.SAFARICOM;

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Buyairtime("SAFARICOM")));
                              },
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Card(
                            child: GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/airtel.png",
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              onTap: () {

                                AppConfig.commandId = Definitions.TOPUP_FLEXI;
                                AppConfig.providerID = Definitions.AIRTEL;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Buyairtime("AIRTEL")));
                              },
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Card(
                            child: GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/telkom.png",
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              onTap: () {
                                AppConfig.commandId = Definitions.TOPUP_FLEXI;
                                AppConfig.providerID = Definitions.TELKOM;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Buyairtime("TELKOM")));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          /////////Card  Begin
          SizedBox(
            height: 1,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ColoredBox(
                color: Color(0xff81A632),
              ),
            ),
          ),
          Card(
            borderOnForeground: true,
            shadowColor: Colors.pinkAccent,
            margin: EdgeInsets.all(15.0),
            elevation: 5.0,

            child: Container(
              color: Theme.of(context).secondaryHeaderColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ColoredBox(
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Bill Payments",
                      style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 20, left: 20),
                    child: Text(
                      "Settle your debts in an easy way",
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ColoredBox(
                        color: Color(0xff81A632),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(2),
                    child: GridView.count(
                      crossAxisCount: 4,
                      physics: ScrollPhysics(), // to disable GridView's scrolling
                      shrinkWrap: true,
                      children: <Widget>[
               /*         Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Card(
                            child: GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/saf.png",
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Buyairtime("SAFARICOM")));
                              },
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Card(
                            child: GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/airtel.png",
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Buyairtime("AIRTEL")));
                              },
                            ),
                          ),
                        ),*/
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Card(
                            child: GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/nai.png",
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              onTap: () {
                                AppConfig.commandId = Definitions.BILL_PAY;
                                AppConfig.providerID = Definitions.NAIROBI_WTR;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            WaterPayBill('Nairobi Water',nai_meter)));
                              },
                            ),
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.all(5),
                          child: Card(
                            child: GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/kplc.png",
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Power()));
                              },
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Card(
                            child: GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/dstv.png",
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              onTap: () {
                                AppConfig.commandId = Definitions.TOPUP_FIX;
                                AppConfig.providerID = Definitions.DSTV;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Adddtvbill(
                                            "DSTV", "assets/dstv.png")));
                              },
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Card(
                            child: GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/gotv.jpg",
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              onTap: () {
                                AppConfig.commandId = Definitions.TOPUP_FIX;
                                AppConfig.providerID = Definitions.GOTV;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Adddtvbill(
                                            "GoTv", "assets/dstv.png")));
                              },
                            ),
                          ),
                        ),
                 /*       Container(
                          padding: EdgeInsets.all(5),
                          child: Card(
                            child: GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/telkom.png",
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Buyairtime("TELKOM")));
                              },
                            ),
                          ),
                        ),*/
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Card(
                            child: GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/star.jpg",
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              onTap: () {
                                AppConfig.commandId = Definitions.TOPUP_FIX;
                                AppConfig.providerID = Definitions.STARTIMES;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Adddtvbill(
                                            "StarTimes", "assets/dstv.png")));
                              },
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Card(
                            child: GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/zukulogo.jpg",
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Adddtvbill(
                                            "Zuku", "assets/dstv.png")));
                              },
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          /////////Card  Begin
          SizedBox(
            height: 1,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ColoredBox(
                color: Color(0xff81A632),
              ),
            ),
          ),
          Card(
            borderOnForeground: true,
            shadowColor: Colors.pinkAccent,
            margin: EdgeInsets.all(15.0),
            elevation: 5.0,

            child: Container(
              color: Colors.purple[100],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Tours & Travel",
                      style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 20, left: 20),
                    child: Text(
                      "Travel allover the world",
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ColoredBox(
                        color: Color(0xff81A632),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: GridView.count(
                      crossAxisCount: 4,
                      physics: ScrollPhysics(), // to disable GridView's scrolling
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          child:
                              Card(
                                child: GestureDetector(
                                  child: Container(
                                    padding: EdgeInsets.all(35),
                                    child: Image.asset(
                                      "assets/bus_icon.png",
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ToursAndTravel()));
                                  },
                                ),

                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child:
                              Card(
                                child: GestureDetector(
                                  child: Container(
                                    padding: EdgeInsets.all(30),
                                    child:
                                        Image.asset(
                                          "assets/tours.png",
                                          height: 50,
                                          width: 50,

                                        ),


                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Buyairtime("AIRTEL")));
                                  },
                                ),

                          ),
                        ),






                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),


          SizedBox(
            height: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ColoredBox(
                color: Color(0xff81A632),
              ),
            ),
          ),
          Card(
            borderOnForeground: true,
            shadowColor: Colors.pinkAccent,
            margin: EdgeInsets.all(15.0),
            elevation: 5.0,


            child: Container(
              color: Colors.purple[100],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Organic Honey",
                      style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 20, left: 20),
                    child: Text(
                      "Sale of Organic Honey Countrywide",
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ColoredBox(
                        color: Color(0xff81A632),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(2),
                    child: GridView.count(
                      crossAxisCount: 4,
                      physics: ScrollPhysics(), // to disable GridView's scrolling
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Card(
                            child: GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/organic_honey.jpeg",
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Buyairtime("SAFARICOM")));
                              },
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
