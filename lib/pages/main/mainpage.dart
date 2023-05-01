import 'dart:async';
import 'dart:convert';
import 'dart:io';

//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soko/common/AppConfig.dart';
import 'package:soko/common/CallsAndMessagesService.dart';
import 'package:soko/common/definitions.dart';
import 'package:soko/common/service_locator.dart';
import 'package:soko/pages/main/bottomnavpages/explore.dart';
import 'package:soko/pages/main/bottomnavpages/settings.dart';
import 'package:soko/pages/main/bottomnavpages/home.dart';
import 'package:soko/pages/main/bottomnavpages/receipt.dart';
import 'package:soko/pages/main/bottomnavpages/shopping_page.dart';
import 'package:soko/pages/main/editprofile.dart';
import 'package:http/http.dart' as http;

import '../auth/signin.dart';

class Mainpage extends StatefulWidget {
  @override
  _MainpageState createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  String userid;
  var userArrr, userjson;
  String notificationTitle = 'BillSasa Notification';
  String notificationBody = 'Description';
  SharedPreferences sp;
 // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final String number = "0774619953 ";
  final String email = "billsasakenyacomplaints@gmail.com";
  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();



  Future getuserid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userid_a = await preferences.getString('userdata');
    return userid_a;
  }

  int _currentindex = 0;

  List<Widget> pages;

  @override
  void initState() {
    super.initState();
    //_firebaseMessaging.requestNotificationPermissions();
    //Initialise Firebase Cloud Messaging
    //firebaseCloudMessaging_Listeners();
    initialiseNotificationSettings();
    AppConfig.makePushNotificationRequest();
    Home home = new Home();
    Settings settings = new Settings();
    Receipt receipt = new Receipt();

    Explore explore = new Explore();
    ShoppingPage shoppingPage = new ShoppingPage();

    pages = [home, settings, receipt, shoppingPage];
    getuserid().then((value) => setState(() {
          userjson = value;
          userArrr = json.decode(userjson);
        }));

    AppConfig.getReceiptData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              onDetailsPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Eeditprofile()));
              },
              currentAccountPicture: CircleAvatar(
                child: Icon(
                  Icons.person_outline,
                  color: Colors.grey,
                ),
                backgroundColor: Colors.purple,
              ),
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              accountName: Text(userArrr["fname"]),
              accountEmail: Text(userArrr["email"]),
            ),
            ListTile(
              title: Text(
                "Call Support",
                style: GoogleFonts.quicksand(),
              ),
              onTap: (){
                _service.call(number);
              },
            ),
            ListTile(
              title: Text(
                "Email Support",
                style: GoogleFonts.quicksand(),
              ),
              onTap: (){
                _service.sendEmail(email);
              },
            ),
            ListTile(
              title: Text(
                "About",
                style: GoogleFonts.quicksand(),
              ),
            ),
            GestureDetector(
              onTap: () {
                logout(context);
              },
              child: ListTile(
                title: Text(
                  "Logout",
                  style: GoogleFonts.quicksand(),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Powered By domart.com',
                    style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Colors.green),
      //  backgroundColor: Colors.purple,
        title: Row(
          children: <Widget>[

          ],
        ),
        actions: <Widget>[],
      ),
      body: SafeArea(child: pages[_currentindex]),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).primaryColor,
        fixedColor: Colors.purple,
        currentIndex: _currentindex,
        onTap: (value) {
          setState(() {
            _currentindex = value;
          });
        },
        items: [
          BottomNavigationBarItem(

            label: "Home",
            icon: Icon(
              Icons.home,
            ),
          ),
          BottomNavigationBarItem(
            label: "Settings",
            icon: Icon(
              Icons.settings,
            ),
          ),
          BottomNavigationBarItem(
            label: "Receipts",
            icon: Icon(
              Icons.receipt,
            ),
          ),
          BottomNavigationBarItem(
              label: "Shop now",
              icon: Icon(
                Icons.explore,
              )),
        ],
      ),
    );
  }

  void logout(BuildContext context) {
    //AppConfig.clearFromSharedPrefs();
    AppConfig.removeFromSharedPrefs("logged_in_user_id");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignIn()));
    Fluttertoast.showToast(
        msg: "You're now logged out",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
      print('++++FIREBASE CLOUD MESSAGE+++++++++$data++++++++++++++');
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

  // Replace with server token from rfgfirebase console settings.
  void initialiseNotificationSettings() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings("@mipmap/ic_launcher");
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future<dynamic> onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        titleTextStyle: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold, color: Color(0xffc70404)),
        scrollable: true,
        title: Text('SUCCESSFUL'),
        content: Text(payload),
        semanticLabel: 'BillSasa',
      ),
    );
  }

}
