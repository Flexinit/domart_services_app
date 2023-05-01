import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soko/common/definitions.dart';
import 'package:soko/pages/auth/signin.dart';

class Eeditprofile extends StatefulWidget {
  @override
  _EeditprofileState createState() => _EeditprofileState();
}

class _EeditprofileState extends State<Eeditprofile> {
  String email, name, password, confirm, userid;

  bool _obscuredtextlogin = true;

  final fnameController = new TextEditingController();
  final lnameController = new TextEditingController();
  final emailController = new TextEditingController();
  final passController = new TextEditingController();
  final phoneController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    getuserid();
    getprofile();
  }

  Future getuserid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      userid = preferences.getString('logged_in_user_id');
    });
  }

  Future validate() async {
    if (emailController.text?.isEmpty ?? true) {
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
    } else if (fnameController.text?.isEmpty ?? true) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Please input first name"),
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
    } else if (lnameController.text?.isEmpty ?? true) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Please input last name"),
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
    } else if (phoneController.text?.isEmpty || !phoneController.text?.startsWith('0',0) || phoneController.text?.length != 10 ??
        true) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Please input phone number. Begin with 07"),
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
    } else if (!EmailValidator.validate(emailController.text)) {
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
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Confirm to update profile"),
              actions: <Widget>[
                ElevatedButton(
                  child: Text("CANCEL"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                    update();
                  },
                )
              ],
            );
          });
    }
  }

  Future update() async {
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, showLogs: true);
    pr.style(message: 'Please wait...');
    pr.show();

    String url = Definitions.api_url + Definitions.endpoint_update;

    var response = await http.post(
      Uri.parse(url),
      body: {
        "id": userid,
        "fname": fnameController.text,
        "lname": lnameController.text,
        "email": emailController.text,
        "password": password,
        "phone": phoneController.text
      },
      headers: {
        'Accept': 'application/json',
      },
    );

    var jsonresponse = json.decode(response.body);

    if (jsonresponse['message']) {
      pr.hide().whenComplete(() {
        Fluttertoast.showToast(
            msg: "Profile updated",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    } else {
      pr.hide().whenComplete(() {
        Fluttertoast.showToast(
            msg: "Profile not updated",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    }
  }

  Future getprofile() async {
    String url = Definitions.api_url + Definitions.endpoint_profile;

    var response = await http.post(
      Uri.parse(url),
      body: {"id": userid},
      headers: {
        'Accept': 'application/json',
      },
    );

    var jsonresponse = json.decode(response.body);
    setState(() {
      fnameController.text = jsonresponse["message"]['fname'];
      lnameController.text = jsonresponse["message"]['lname'];
      emailController.text = jsonresponse["message"]['email'];
      phoneController.text = jsonresponse["message"]['phone'];
    });
  }

  void togglelogin() {
    setState(() {
      _obscuredtextlogin = !_obscuredtextlogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffc70404),
        title: Text("Edit profile", style: GoogleFonts.quicksand()),
      ),
      body: Container(
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
                    controller: fnameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelStyle:
                            GoogleFonts.quicksand(color: Color(0xffc70404)),
                        labelText: "First Name"),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: lnameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelStyle:
                            GoogleFonts.quicksand(color: Color(0xffc70404)),
                        labelText: "Last Name"),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: emailController,
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
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
//                onChanged: (value){
//
//                  phone = value;
//
//                },
                    decoration: InputDecoration(
                        labelStyle:
                            GoogleFonts.quicksand(color: Color(0xffc70404)),
                        labelText: "Phone number (07...)"),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
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
                          _obscuredtextlogin
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          size: 15.0,
                          color: Colors.black,
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
                      //color: Color(0xffc70404),
                      onPressed: () {
                        validate();
                      },
                      child: Text("EDIT",
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
