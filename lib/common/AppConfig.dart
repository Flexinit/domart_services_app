import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soko/common/definitions.dart';

class AppConfig {
  static List<dynamic> airtime_payments = [];
  static List<Payments> completedPayments = [];
  static String billPayments;
  static String email;
  static String password;
  static String completedPaymentsJsonStr;
  static String deviceToken;
  static Future<http.Response> requestResponse;
  static String commandId;
  static String providerID;
  static String latestTransactioData;

  static Future removeFromSharedPrefs(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(value);
  }

  static Future saveToSharedPrefs(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('$key', value);
  }

  static Future clearFromSharedPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  static void saveListToSharedPrefs(String key, List<dynamic> value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('$key', json.encode(value));
  }

  static Future<List<dynamic>> retrieveListFromSharedPrefs(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<dynamic> listData = preferences.get('$key');
    return listData;
  }

  static Future<String> retrieveFromSharedPrefs(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String data = preferences.get('$key');
    return data;
  }

  static Future<http.Response> getReceiptData() async {
    // try {
    String email = await AppConfig.retrieveFromSharedPrefs('email');
    String password = await AppConfig.retrieveFromSharedPrefs('password');
    String loginurl = Definitions.api_url + Definitions.endpoint_login;
    print(loginurl);

    var response = await http.post(
      Uri.parse(loginurl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    print('+++++++++++RECEIPT DATA+++++${response.body}++');

    var productsObjsJson =
        json.decode(response.body)['completed_payments'] as List;
    completedPayments =
        productsObjsJson.map((tagJson) => Payments.fromJson(tagJson)).toList();

    return response;

    /*   }catch(e){
return e;
    }*/
  }

  static String getPaymentStatus(String status) {
    String paymentStatus;
    if (status == 1) {
      paymentStatus = 'Completed';
    } else {
      paymentStatus = 'Pending';
    }
    return paymentStatus;
  }

  static String formartDateTimeString(String date) {
    DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(date);
    String dateString = '${tempDate.day}';
    return dateString;
  }

  static String calculateTotalAmount(List<Payments> payments) {
    double sum = 0;
    for (int i = 0; i < payments.length; i++) {
      //if (payments[i].status == 1) {
      if (payments[i].status!= null) {
        sum += double.parse(payments[i].amount_billed);
      }
    }
    return sum.toString();
  }

  static Future saveConfigsToSharedPrefs(dynamic jsonresponse) async {
    if (jsonresponse["settings"] != null) {
      var userSettings = jsonresponse['settings'];
      saveToSharedPrefs('nai_meter', userSettings['nai_meter'].toString());
      saveToSharedPrefs('dstv_no', userSettings['dstv_no'].toString());
      AppConfig.saveToSharedPrefs(
          'star_times', userSettings['star_times'].toString());
      AppConfig.saveToSharedPrefs('go_tv', userSettings['go_tv'].toString());
      AppConfig.saveToSharedPrefs(
          'kplc_meter', userSettings['kplc_meter'].toString());
      AppConfig.saveToSharedPrefs('jtl', userSettings['jtl'].toString());
      AppConfig.saveToSharedPrefs('nhif', userSettings['nhif'].toString());
      AppConfig.saveToSharedPrefs(
          'parking', userSettings['parking'].toString());
      AppConfig.saveToSharedPrefs(
          'business_permit', userSettings['business_permit'].toString());
      AppConfig.saveToSharedPrefs(
          'land_rates', userSettings['land_rates'].toString());
      AppConfig.saveToSharedPrefs(
          'kiwasco_meter', userSettings['kiwasco_meter'].toString());
      AppConfig.saveToSharedPrefs(
          'zuku_fibre', userSettings['zuku_fibre'].toString());
      AppConfig.saveToSharedPrefs(
          'zuku_tv', userSettings['zuku_tv'].toString());
    }
  }

  static void makePushNotificationRequest() async {
    String notification_url =
        Definitions.api_url + Definitions.endpoint_notification;

    var response = await http.post(
      Uri.parse(notification_url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': deviceToken,
      }),
    );
    print('++++++NOTIFICATION REQUEST RESPONSE+++++${response.body}++++');
  }


  static void getLatestTransactionData(String latestSID) async {
    String notification_url =
        Definitions.api_url + Definitions.endpoint_notification;

    var response = await http.post(
      Uri.parse(notification_url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'sid': latestSID,
      }),

    );
    print('++++++NOTIFICATION REQUEST RESPONSE+++++${response.body}++++');
  }
}
