import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
//import 'package:international_phone_input/international_phone_input.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soko/common/AppConfig.dart';
import 'package:soko/pages/main/mainpage.dart';
import 'signup.dart';
import 'package:soko/common/definitions.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email, password;

  bool _obscuredtextlogin = true;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool hidePass = true;

  void togglelogin() {
    setState(() {
      _obscuredtextlogin = !_obscuredtextlogin;
    });
  }

  @override
  void initState() {
    super.initState();
    checkifauthenticated();
  }

  Future validate() async {
    email = _email.text;
    password = _password.text;

    if (email?.isEmpty ?? true) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Please input email"),
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
    } else if (!EmailValidator.validate(email)) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Please input valid email"),
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
    } else if (password?.isEmpty ?? true) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Please input password"),
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
      try {
        ProgressDialog pr = new ProgressDialog(context,
            type: ProgressDialogType.Normal,
            showLogs: true,
            isDismissible: false);
        pr.style(message: 'Please wait...');
        pr.show();

        String loginurl = Definitions.api_url + Definitions.endpoint_login;
        print(loginurl);

        var response = await http
            .post(Uri.parse(loginurl), body: {"email": email, "password": password});
        // AppConfig.requestResponse = response as Future<http.Response> ;
        var jsonresponse = json.decode(response.body);

        print('++++++++SERVER RESPONSE+LOGIN++++${response.body}');
        print(
            '++++++++SERVER RESPONSE+PAYMENTS++++${jsonresponse['completed_payments']}');
        print('++++++++SERVER RESPONSE+AIRTIME++++${jsonresponse['user']}');

        if (jsonresponse["user"] != null) {
          userid(jsonresponse['user']['id']);


          AppConfig.saveToSharedPrefs('email', email);
          AppConfig.saveToSharedPrefs('password', password);

          userdata(json.encode(jsonresponse['user'])); // stores the user data
          if (jsonresponse["settings"] != null) {
            var userSettings = jsonresponse['settings'];
            usernaiwtr(userSettings['nai_meter'].toString());
            userdstv(userSettings['dstv_no'].toString());
            userstartimes(userSettings['star_times'].toString());
            usergotv(userSettings['go_tv'].toString());
            userkplc(userSettings['kplc_meter'].toString());
            AppConfig.saveToSharedPrefs('jtl', userSettings['jtl'].toString());
            AppConfig.saveToSharedPrefs(
                'nhif', userSettings['nhif'].toString());
            AppConfig.saveToSharedPrefs(
                'kasneb', userSettings['kasneb'].toString());
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

            var billPayments = jsonresponse['completed_payments'];
            var airtimePayments = jsonresponse['airtime_payments'];
            AppConfig.completedPaymentsJsonStr = json.encode(billPayments);
            String airtimePaymentsJsonStr = json.encode(airtimePayments);
            saveToSharedPrefs(
                'completed_payments', AppConfig.completedPaymentsJsonStr);
            saveToSharedPrefs('airtime_payments', airtimePaymentsJsonStr);

            print('+++++++++RESPONSE BODY+++${response.body}+++++++');
            AppConfig.billPayments = AppConfig.completedPaymentsJsonStr;
            /*  var productsObjsJson = jsonresponse['completed_payments'] as List;
        AppConfig.completedPayments   = productsObjsJson.map((tagJson) => Payments.fromJson(tagJson)).toList();*/
            /*AppConfig.completedPayments = jsonresponse['completed_payments'];



            for (int i = 0; i <  AppConfig.completedPayments.length; i++) {

              AppConfig.saveToSharedPrefs('completedPayments',  AppConfig.completedPayments[i].toString());

            }

           AppConfig.airtime_payments = jsonresponse['airtime_payments'];
            for (int j = 0; j < AppConfig.airtime_payments.length; j++) {

              AppConfig.saveToSharedPrefs('airtime_payments', AppConfig.airtime_payments[j].toString());

            }*/
          } else {
            usernaiwtr("");
            userdstv("");
            userstartimes("");
            usergotv("");
            userkplc("");
          }

          pr.hide().whenComplete(() {
            Fluttertoast.showToast(
                msg: "Welcome " + jsonresponse['user']['fname'],
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          });

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Mainpage()));
        } else {
          pr.hide().whenComplete(() {
            Fluttertoast.showToast(
                msg: jsonresponse['message'],
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Color(0xff81A632),
                textColor: Colors.white,
                fontSize: 16.0);
          });
        }
      } catch (e) {
        return e;
      }
    }
  }

  String phoneNumber;
  String phoneIsoCode;
  bool visible = false;
  String confirmedNumber;

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    print(number);
    setState(() {
      phoneNumber = number;
      phoneIsoCode = isoCode;
    });
  }

  void saveToSharedPrefs(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('$key', value);
    print('++++++++ENCODED PAYMENTS LIST++++++$value+++++++++');
  }

  onValidPhoneNumber(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      visible = true;
      confirmedNumber = internationalizedPhoneNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[350],
                      blurRadius:
                          20.0, // has the effect of softening the shadow
                    )
                  ],
                ),
                child: Form(
                    //key: _formKey,
                    child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                            "assets/ezee_logo.jpeg",
                            height: 150,
                            width: 250,
                          )),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey.withOpacity(0.3),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextFormField(
                            controller: _email,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelStyle: GoogleFonts.quicksand(
                                  color: Color(0xff81A632)),
                              hintText: "Email",
                              icon: Icon(Icons.alternate_email),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                Pattern pattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regex = new RegExp(pattern);
                                if (!regex.hasMatch(value))
                                  return 'Please make sure your email address is valid';
                                else
                                  return null;
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey.withOpacity(0.3),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: ListTile(
                            title: TextFormField(
                              controller: _password,
                              obscureText: hidePass,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                labelStyle: GoogleFonts.quicksand(
                                    color: Color(0xff81A632)),
                                icon: Icon(Icons.lock_outline),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "The password field cannot be empty";
                                } else if (value.length < 6) {
                                  return "the password has to be at least 6 characters long";
                                }
                                return null;
                              },
                            ),
                            trailing: IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: () {
                                  setState(() {
                                    hidePass = !hidePass;
                                  });
                                }),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                      child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Color(0xff81A632),
                          elevation: 0.0,
                          child: MaterialButton(
                            onPressed: () async {
                              validate();
                            },
                            minWidth: MediaQuery.of(context).size.width,
                            child: Text(
                              "SIGN IN",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Forgot password",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xff81A632),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                            child: Text(
                              "Create an account",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.quicksand(
                                  color: Color(0xff81A632),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[],
                    ),

//                        Padding(
//                          padding: const EdgeInsets.all(16.0),
//                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//
//                              Padding(
//                                padding: const EdgeInsets.all(8.0),
//                                child: Text("or sign in with", style: TextStyle(fontSize: 18,color: Colors.grey),),
//                              ),
//                              Padding(
//                                padding: const EdgeInsets.all(8.0),
//                                child: MaterialButton(
//                                    onPressed: () {},
//                                    child: Image.asset("images/ggg.png", width: 30,)
//                                ),
//                              ),
//
//                            ],
//                          ),
//                        ),
                  ],
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void checkifauthenticated() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      if (sharedPreferences.getInt("logged_in_user_id") != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Mainpage()));

        print(
            "++++++USER_ID++++++${sharedPreferences.getString("logged_in_user_id")}");
      } else {
        // return;
        //   validate();

      }
    } catch (e) {
      //  return;
    }
  }

  Future userid(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('logged_in_user_id', id);
  }

  Future userkplc(String user_settings) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('user_kplc', user_settings);
  }

  Future userdstv(String user_settings) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('user_dstv', user_settings);
  }

  Future usergotv(String user_settings) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('user_gotv', user_settings);
  }

  Future userstartimes(String user_settings) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('user_startimes', user_settings);
  }

  Future usernaiwtr(String user_settings) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('user_naiwater', user_settings);
  }

  Future userdata(var userdata) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString('userdata', userdata);
  }
}
