import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:international_phone_input/international_phone_input.dart';
//import 'package:international_phone_input/international_phone_input.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soko/pages/main/mainpage.dart';
import 'package:soko/common/definitions.dart';

import 'signin.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email, referrer_email, fname, lname, password, confirm;

  bool _obscuredtextlogin_pass = true; // _password
  bool _obscuredtextlogin_cpass = true; // _pconfirm

  String phoneNumber;

  String phoneIsoCode;
  bool visible = false;
  String confirmedNumber = '';

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    print(number);
    setState(() {
      phoneNumber = number;
      phoneIsoCode = isoCode;
    });
  }

  onValidPhoneNumber(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      visible = true;
      confirmedNumber = internationalizedPhoneNumber;
    });
  }

  void togglelogin() {
    setState(() {
      _obscuredtextlogin_pass = !_obscuredtextlogin_pass;
    });
  }

  void togglelogin2() {
    setState(() {
      _obscuredtextlogin_cpass = !_obscuredtextlogin_cpass;
    });
  }

  Future userid(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString('logged_in_user_id', id);
  }

  Future validate() async {
    if (fname?.isEmpty ?? true) {
      return showDialog(
          context: myGlobals.scaffoldKey.currentContext,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Please input First Name"),
              actions: <Widget>[
                ElevatedButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    } else if (lname?.isEmpty ?? true) {
      return showDialog(
          context: myGlobals.scaffoldKey.currentContext,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Please input Last Name"),
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
    } else if (email?.isEmpty ?? true) {
      return showDialog(
          context: myGlobals.scaffoldKey.currentContext,
          barrierColor: Colors.blue,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Please input email"),
              actions: <Widget>[
                ElevatedButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    } else if (phoneNumber?.length != 10 || !phoneNumber.startsWith('0',0)) {
      return showDialog(
          context: myGlobals.scaffoldKey.currentContext,
          builder: (BuildContext context) {
            return AlertDialog(
              content:
                  Text("Please input a valid phone number. Begin with 07"),
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
          context: myGlobals.scaffoldKey.currentContext,
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
          context: myGlobals.scaffoldKey.currentContext,
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
    } else if (confirm?.isEmpty ?? true) {
      return showDialog(
          context: myGlobals.scaffoldKey.currentContext,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Please confirm password"),
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
    } else if (password.toString().trim() != confirm.toString().trim()) {
      return showDialog(
          context: myGlobals.scaffoldKey.currentContext,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Password do not match"),
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
      return showDialog(
          context: myGlobals.scaffoldKey.currentContext,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Please Confirm to sign up"),
              actions: <Widget>[
                ElevatedButton(
                  child: Text("CANCEL"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  child: Text("OK"),
                  onPressed: () async {
                    Navigator.pop(context);

                    try {
                      ProgressDialog pr = new ProgressDialog(context,
                          type: ProgressDialogType.Normal,
                          showLogs: true,
                          isDismissible: true);
                      pr.style(message: 'Please wait...');
                      pr.show();

                      String signin =
                          Definitions.api_url + Definitions.endpoint_register;
                      print('Request sent at ' + signin);

                      var response = await http.post(Uri.parse(signin), body: {
                        "fname": fname,
                        "lname": lname,
                        "email": email,
                        //"referrer_email": referrer_email,
                        'phone': phoneNumber,
                        "password": password
                      });

                      var jsonresponse = json.decode(response.body);

                      // print(response.body);

                      if (jsonresponse["user"] != null) {
                        if (jsonresponse['status'] == "1") {
                          userid(jsonresponse['user']['id'].toString());

                          pr.hide().whenComplete(() {
                            Fluttertoast.showToast(
                                msg: jsonresponse['message'],
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          });

                          Navigator.pushReplacement(
                              myGlobals.scaffoldKey.currentContext,
                              MaterialPageRoute(
                                  builder: (context) => SignIn()));
                        } else {
                          pr.hide().whenComplete(() {
                            Fluttertoast.showToast(
                                msg: jsonresponse['message'],
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          });
                        }
                      } else {
                        pr.hide().whenComplete(() {
                          Fluttertoast.showToast(
                              msg: jsonresponse['message'],
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        });
                      }
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: myGlobals.scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xffc70404),
        title: Text("SIGN UP", style: GoogleFonts.quicksand()),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Card(
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      fname = value;
                    },
                    decoration: InputDecoration(
                        labelStyle:
                            GoogleFonts.quicksand(color: Color(0xffc70404)),
                        labelText: "First Name"),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      lname = value;
                    },
                    decoration: InputDecoration(
                        labelStyle:
                            GoogleFonts.quicksand(color: Color(0xffc70404)),
                        labelText: "Last Name"),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: InternationalPhoneInput(
                    onPhoneNumberChange: onPhoneNumberChange,
                    initialPhoneNumber: phoneNumber,
                    initialSelection: phoneIsoCode,
                    enabledCountries: ['+254'],
                    labelText: "Phone Number (07...)",
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                        labelStyle:
                            GoogleFonts.quicksand(color: Color(0xffc70404)),
                        labelText: "Email"),
                  ),
                ),
/*
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      referrer_email = value;
                    },
                    decoration: InputDecoration(
                        labelStyle:
                            GoogleFonts.quicksand(color: Color(0xffc70404)),
                        labelText: "Referrer Email"),
                  ),
                ),
*/
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    obscureText: _obscuredtextlogin_pass,
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle:
                          GoogleFonts.quicksand(color: Color(0xffc70404)),
                      focusColor: Colors.red,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          togglelogin();
                        },
                        child: Icon(
                          _obscuredtextlogin_pass
                              ? FontAwesomeIcons.eyeSlash
                              : FontAwesomeIcons.eye,
                          size: 15.0,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    obscureText: _obscuredtextlogin_cpass,
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (value) {
                      confirm = value;
                    },
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      labelStyle:
                          GoogleFonts.quicksand(color: Color(0xffc70404)),
                      focusColor: Colors.red,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          togglelogin2();
                        },
                        child: Icon(
                          _obscuredtextlogin_cpass
                              ? FontAwesomeIcons.eyeSlash
                              : FontAwesomeIcons.eye,
                          size: 15.0,
                          color: Colors.red,
                        ),
                      ),
                    ),
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
                      style: ButtonStyle(

                      ),
                      onPressed: () {
                        validate();
                      },
                      child: Text("SIGN UP",
                          style: GoogleFonts.quicksand(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 120,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

MyGlobals myGlobals = new MyGlobals();

class MyGlobals {
  GlobalKey _scaffoldKey;

  MyGlobals() {
    _scaffoldKey = GlobalKey();
  }

  GlobalKey get scaffoldKey => _scaffoldKey;
}
