import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soko/common/AppConfig.dart';
import 'package:soko/pages/auth/signin.dart';
import 'package:soko/pages/groups/create_group.dart';
import 'package:http/http.dart' as http;
import 'package:soko/pages/groups/explore_groups.dart';
import 'package:soko/common/definitions.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String userid, kplc_meter, nai_meter, star_times, dstv_no, go_tv;
  String userid_s, kplc_meter_s, nai_meter_s, star_times_s, dstv_no_s, go_tv_s;

  String jtl,
      nhif,
      parking,
      businessPermit,
      landRates,
      kasneb,
      zuku_tv,
      zuku_fibre,
      kiwasco;
  static String jtl_s,
      nhif_s,
      parking_s,
      businessPermit_s,
      landRates_s,
      kasneb_s,
      zuku_tv_s,
      zuku_fibre_s,
      kiwasco_s;

  var userSettings, usersettingsjson;
  var userArrr, userjson;
  String gotv_test = "Accessible";
  final _controllerKplc = new TextEditingController();
  final _controllerNai = new TextEditingController();
  final _controllerGotv = new TextEditingController();
  final _controllerDstv = new TextEditingController();
  final _controllerStar = new TextEditingController();
  final _controllerJtl = new TextEditingController();
  final _controllerNhif = new TextEditingController();
  final _controllerParking = new TextEditingController();
  final _controllerBusinessPermit = new TextEditingController();
  final _controllerLandRates = new TextEditingController();
  final _controllerKasneb = new TextEditingController();
  final _controllerZuku_tv = new TextEditingController();
  final _controllerZuku_fibre = new TextEditingController();
  final _controllerKiwasco = new TextEditingController();

  // String nai_meter,kplc_meter,star_times,dstv_no,go_tv;
  Future getnai() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nai_meter_s = preferences.getString('user_naiwater');
      _controllerNai.text = nai_meter_s;
    });
  }

  Future getkplc() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      kplc_meter_s = preferences.getString('user_kplc');
      _controllerKplc.text = kplc_meter_s;
    });
  }

  Future getdstv() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      dstv_no_s = preferences.getString('user_dstv');
      _controllerDstv.text = dstv_no_s;
    });
  }

  Future getstar() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      star_times_s = preferences.getString('user_startimes');
      _controllerStar.text = star_times_s;
    });
  }

  Future getgotv() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      go_tv_s = preferences.getString('user_gotv');
      _controllerGotv.text = go_tv_s;
    });
  }

  Future getjtl() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      jtl_s = preferences.getString('jtl');
      _controllerJtl.text = jtl_s;
    });
  }

  Future getKiwasco() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      kiwasco_s = preferences.getString('kiwasco_meter');
      _controllerKiwasco.text = kiwasco_s;
    });
  }

  Future getZukuTv() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      zuku_tv_s = preferences.getString('zuku_tv');
      _controllerZuku_tv.text = zuku_tv_s;
    });
  }

  Future getZukuFibre() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      zuku_fibre_s = preferences.getString('zuku_fibre');
      _controllerZuku_fibre.text = zuku_fibre_s;
    });
  }

  Future getnhif() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nhif_s = preferences.getString('nhif');
      _controllerNhif.text = nhif_s;
    });
  }

  Future getparking() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      parking_s = preferences.getString('parking');
      _controllerParking.text = parking_s;
    });
  }

  Future getbusiness_permit() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      businessPermit_s = preferences.getString('business_permit');
      _controllerBusinessPermit.text = businessPermit_s;
    });
  }

  Future getland_rates() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      landRates_s = preferences.getString('land_rates');
      _controllerLandRates.text = landRates_s;
    });
  }

  Future getkasneb() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      kasneb_s = preferences.getString('kasneb');
      _controllerKasneb.text = kasneb_s;
    });
  }

  Future getuserid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userid_a = await preferences.getString('userdata');
    return userid_a;
  }

  @override
  void initState() {
    super.initState();

    getuserid().then((value) => setState(() {
          userjson = value;
          userArrr = json.decode(userjson);
        }));
    getuserid();
    getdstv();
    getgotv();
    getstar();
    getnai();
    getKiwasco();
    getkplc();
    getjtl();
    getZukuTv();
    getZukuFibre();
    getnhif();
    getparking();
    getbusiness_permit();
    getland_rates();
    getkasneb();

    _controllerKplc.addListener(() {
      _controllerKplc.value = _controllerKplc.value.copyWith(
        selection: TextSelection(
            baseOffset: _controllerKplc.text.length,
            extentOffset: _controllerKplc.text.length),
        composing: TextRange.empty,
      );
    });

    _controllerDstv.addListener(() {
      _controllerDstv.value = _controllerDstv.value.copyWith(
        selection: TextSelection(
            baseOffset: _controllerDstv.text.length,
            extentOffset: _controllerDstv.text.length),
        composing: TextRange.empty,
      );
    });

    _controllerNai.addListener(() {
      _controllerNai.value = _controllerNai.value.copyWith(
        selection: TextSelection(
            baseOffset: _controllerNai.text.length,
            extentOffset: _controllerNai.text.length),
        composing: TextRange.empty,
      );
    });
    _controllerKiwasco.addListener(() {
      _controllerKiwasco.value = _controllerKiwasco.value.copyWith(
        selection: TextSelection(
            baseOffset: _controllerKiwasco.text.length,
            extentOffset: _controllerKiwasco.text.length),
        composing: TextRange.empty,
      );
    });

    _controllerGotv.addListener(() {
      _controllerGotv.value = _controllerGotv.value.copyWith(
        selection: TextSelection(
            baseOffset: _controllerGotv.text.length,
            extentOffset: _controllerGotv.text.length),
        composing: TextRange.empty,
      );
    });

    _controllerStar.addListener(() {
      _controllerStar.value = _controllerStar.value.copyWith(
        selection: TextSelection(
            baseOffset: _controllerStar.text.length,
            extentOffset: _controllerStar.text.length),
        composing: TextRange.empty,
      );
    });
    _controllerJtl.addListener(() {
      _controllerJtl.value = _controllerJtl.value.copyWith(
        selection: TextSelection(
            baseOffset: _controllerJtl.text.length,
            extentOffset: _controllerJtl.text.length),
        composing: TextRange.empty,
      );
    });
    _controllerNhif.addListener(() {
      _controllerNhif.value = _controllerNhif.value.copyWith(
        selection: TextSelection(
            baseOffset: _controllerNhif.text.length,
            extentOffset: _controllerNhif.text.length),
        composing: TextRange.empty,
      );
    });
    _controllerParking.addListener(() {
      _controllerParking.value = _controllerParking.value.copyWith(
        selection: TextSelection(
            baseOffset: _controllerParking.text.length,
            extentOffset: _controllerParking.text.length),
        composing: TextRange.empty,
      );
    });
    _controllerBusinessPermit.addListener(() {
      _controllerBusinessPermit.value =
          _controllerBusinessPermit.value.copyWith(
        selection: TextSelection(
            baseOffset: _controllerBusinessPermit.text.length,
            extentOffset: _controllerBusinessPermit.text.length),
        composing: TextRange.empty,
      );
    });
    _controllerLandRates.addListener(() {
      _controllerLandRates.value = _controllerLandRates.value.copyWith(
        selection: TextSelection(
            baseOffset: _controllerLandRates.text.length,
            extentOffset: _controllerLandRates.text.length),
        composing: TextRange.empty,
      );
    });
    _controllerKasneb.addListener(() {
      _controllerKasneb.value = _controllerKasneb.value.copyWith(
        selection: TextSelection(
            baseOffset: _controllerKasneb.text.length,
            extentOffset: _controllerKasneb.text.length),
        composing: TextRange.empty,
      );
    });
    _controllerZuku_tv.addListener(() {
      _controllerZuku_tv.value = _controllerZuku_tv.value.copyWith(
        selection: TextSelection(
            baseOffset: _controllerZuku_tv.text.length,
            extentOffset: _controllerZuku_tv.text.length),
        composing: TextRange.empty,
      );
    });
    _controllerZuku_fibre.addListener(() {
      _controllerZuku_fibre.value = _controllerZuku_fibre.value.copyWith(
        selection: TextSelection(
            baseOffset: _controllerZuku_fibre.text.length,
            extentOffset: _controllerZuku_fibre.text.length),
        composing: TextRange.empty,
      );
    });
  }

  Future getSettings() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      usersettingsjson = preferences.getString('user_settings');
    });
  }

  Future setSettings(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString('user_settings', id);
  }

  void dispose() {
    _controllerKplc.dispose();
    _controllerStar.dispose();
    _controllerGotv.dispose();
    _controllerNai.dispose();
    _controllerDstv.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future validate() async {
      try {
        ProgressDialog pr = new ProgressDialog(context,
            type: ProgressDialogType.Normal,
            showLogs: true,
            isDismissible: true);
        pr.style(message: 'Please wait...');
        pr.show();

        kplc_meter = _controllerKplc.text;
        nai_meter = _controllerNai.text;
        kiwasco = _controllerKiwasco.text;
        star_times = _controllerStar.text;
        dstv_no = _controllerDstv.text;
        go_tv = _controllerGotv.text;
        jtl = _controllerJtl.text;
        nhif = _controllerNhif.text;
        parking = _controllerParking.text;
        businessPermit = _controllerBusinessPermit.text;
        landRates = _controllerLandRates.text;
        kasneb = _controllerKasneb.text;
        zuku_tv = _controllerZuku_tv.text;
        zuku_fibre = _controllerZuku_fibre.text;

        String loginurl = Definitions.api_url + Definitions.endpoint_add_config;

        var data = {
          'app_token': Definitions.app_token,
          "user_id": userArrr['id'],
          "kplc_meter": kplc_meter,
          "kiwasco_meter": kiwasco,
          "nai_meter": nai_meter,
          "star_times": star_times,
          "jtl": jtl,
          "zuku_tv": zuku_tv,
          "zuku_fibre": zuku_fibre,
          "nhif": nhif,
          "parking": parking,
          "business_permit": businessPermit,
          "land_rates": landRates,
          "kasneb": kasneb,
          "dstv_no": dstv_no,
          "go_tv": go_tv
        };

        print(data);

        var response = await http.post(Uri.parse(loginurl), body: json.encode(data));
        var jsonresponse = json.decode(response.body);

        print("++++++++++++++++SERVER RESPONSE+++SETTINGS+++" + response.body);

        //pr.hide().whenComplete(() {
        //  logout(context);
        // });

        if (jsonresponse["status"] != null) {
          setSettings(json.encode(jsonresponse['settings']));

          AppConfig.saveConfigsToSharedPrefs(jsonresponse['settings']);

          pr.hide().whenComplete(() {
            Fluttertoast.showToast(
                msg: jsonresponse['message'],
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);

            logout(context);
          });
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
            logout(context);

          });
        }
      } catch (e) {}
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment Settings",
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
            color: Colors.purple
          ),

        ),
        backgroundColor: Colors.purple[50],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                kplc_meter = value;
                setState(() {
                  _controllerKplc.text = value;
                });
              },
              controller: _controllerKplc,
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
                hintText: "KPLC Meter",
                helperText: "Enter KPLC meter no",
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
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                nai_meter = value;
                setState(() {
                  _controllerNai.text = value;
                });
              },
              controller: _controllerNai,
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
                hintText: "Nairobi water meter",
                helperText: "Enter Nairobi Water meter no",
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
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                kiwasco = value;
                setState(() {
                  _controllerKiwasco.text = value;
                });
              },
              controller: _controllerKiwasco,
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
                hintText: "Kisumu Water Meter no",
                helperText: "Enter KIWASCO Water Meter no",
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
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                go_tv = value;
                setState(() {
                  _controllerGotv.text = value;
                });
              },
              controller: _controllerGotv,
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
                hintText: "GoTv Card No",
                helperText: "Enter GoTv Card No",
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
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                dstv_no = value;
                setState(() {
                  _controllerDstv.text = value;
                });
              },
              controller: _controllerDstv,
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
                hintText: "DSTV Card no",
                helperText: "Enter DSTV Card no",
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
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                star_times = value;
                setState(() {
                  _controllerStar.text = value;
                });
              },
              controller: _controllerStar,
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
                hintText: "StarTimes card no",
                helperText: "Enter StarTimes card no",
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
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                jtl = value;
                setState(() {
                  _controllerJtl.text = value;
                });
              },
              controller: _controllerJtl,
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
                hintText: "Jamii Telcom Fibre",
                helperText: "Enter Jamii Telcom Fibre Account",
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
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                nhif = value;
                setState(() {
                  _controllerNhif.text = value;
                });
              },
              controller: _controllerNhif,
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
                hintText: "NHIF no.",
                helperText: "Enter NHIF card no",
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
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                parking = value;
                setState(() {
                  _controllerParking.text = value;
                });
              },
              controller: _controllerParking,
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
                hintText: "Parking no",
                helperText: "Enter Parking Account no",
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
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                businessPermit = value;
                setState(() {
                  _controllerBusinessPermit.text = value;
                });
              },
              controller: _controllerBusinessPermit,
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
                hintText: "Business Permit no.",
                helperText: "Enter Business Permit no",
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
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                landRates = value;
                setState(() {
                  _controllerLandRates.text = value;
                });
              },
              controller: _controllerLandRates,
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
                hintText: "Land Rates no.",
                helperText: "Enter Land Rates no",
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
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                kasneb = value;
                setState(() {
                  _controllerKasneb.text = value;
                });
              },
              controller: _controllerKasneb,
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
                hintText: "KASNEB",
                helperText: "Enter KASNEB no",
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
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                zuku_tv = value;
                setState(() {
                  _controllerZuku_tv.text = value;
                });
              },
              controller: _controllerZuku_tv,
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
                hintText: "Zuku TV card no",
                helperText: "Enter Zuku TV card no",
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
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                zuku_fibre = value;
                setState(() {
                  _controllerZuku_fibre.text = value;
                });
              },
              controller: _controllerZuku_fibre,
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
                hintText: "Zuku Fibre card no",
                helperText: "Enter ZUku Fibre card no",
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
                child: Text("SUBMIT",
                    style: GoogleFonts.quicksand(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void logout(BuildContext context) {
    AppConfig.removeFromSharedPrefs("logged_in_user_id");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignIn()));

    Fluttertoast.showToast(
        msg: "Login to continue",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
