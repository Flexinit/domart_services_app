import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:soko/common/definitions.dart';


class CreditCard extends StatefulWidget {
  final String server_sid,server_amountBilled,server_acc_no,oid;
  CreditCard(this.server_sid,this.server_amountBilled,this.server_acc_no,this.oid);

  @override
  _CreditCardState createState() => _CreditCardState(this.server_sid,this.server_amountBilled,this.server_acc_no,this.oid);
}

class _CreditCardState extends State<CreditCard> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final String server_sid,server_amountBilled,server_acc_no,oid;

  String recipient_no, amount;
  String pmt_mode ;
  _CreditCardState(this.server_sid,this.server_amountBilled,this.server_acc_no,this.oid);
  @override
  Widget build(BuildContext context) {
    Future validate() async {
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
      } else if (recipient_no?.isEmpty ?? true) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("Please input recipient phone no"),
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
      } else if (pmt_mode?.isEmpty ?? true) {
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
      }
    }
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Credit Card",style:
        GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),),
      ),

      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          SizedBox(height: 30,),
          Container(
              padding: EdgeInsets.all(10),
              child: Stack(
                alignment: Alignment.centerRight,
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      recipient_no = value;
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1,color: Colors.red),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1,color: Colors.orange),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1,color: Colors.red),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1,)
                      ),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1,color: Colors.black)
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1,color: Colors.yellowAccent)
                      ),
                      hintText: "First Name",
                      helperText: "Enter card's first name",
                      helperStyle: GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),
                      hintStyle: GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),
                    ),
                  ),


                ],
              )
          ),


          SizedBox(height: 15,),


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
                  borderSide: BorderSide(width: 1,color: Colors.red),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1,color: Colors.orange),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1,color: Colors.red),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,)
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: Colors.black)
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: Colors.yellowAccent)
                ),
                hintText: "Last Name",
                helperText: "Enter card's last name",
                helperStyle: GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),
                hintStyle: GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),
              ),
            ),
          ),

          SizedBox(height: 15,),


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
                  borderSide: BorderSide(width: 1,color: Colors.red),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1,color: Colors.orange),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1,color: Colors.red),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,)
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: Colors.black)
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: Colors.yellowAccent)
                ),
                hintText: "CVV",
                helperText: "Enter card's cvv",
                helperStyle: GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),
                hintStyle: GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),
              ),
            ),
          ),

          SizedBox(height: 15,),


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
                  borderSide: BorderSide(width: 1,color: Colors.red),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1,color: Colors.orange),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1,color: Colors.red),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,)
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: Colors.black)
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: Colors.yellowAccent)
                ),
                hintText: "Card Number",
                helperText: "Enter card's number",
                helperStyle: GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),
                hintStyle: GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),
              ),
            ),
          ),

          SizedBox(height: 15,),


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
                  borderSide: BorderSide(width: 1,color: Colors.red),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1,color: Colors.orange),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1,color: Colors.red),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,)
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: Colors.black)
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: Colors.yellowAccent)
                ),
                hintText: "Expiry Month",
                helperText: "Enter card's expiry month",
                helperStyle: GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),
                hintStyle: GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),
              ),
            ),
          ),

          SizedBox(height: 15,),


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
                  borderSide: BorderSide(width: 1,color: Colors.red),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1,color: Colors.orange),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1,color: Colors.red),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,)
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: Colors.black)
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: Colors.yellowAccent)
                ),
                hintText: "Expiry Year",
                helperText: "Enter card's year of expiry",
                helperStyle: GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),
                hintStyle: GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),
              ),
            ),
          ),

          SizedBox(height: 15,),


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
                  borderSide: BorderSide(width: 1,color: Colors.red),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1,color: Colors.orange),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1,color: Colors.red),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,)
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: Colors.black)
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: Colors.yellowAccent)
                ),
                hintText: "Address",
                helperText: "Enter card's address",
                helperStyle: GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),
                hintStyle: GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),
              ),
            ),
          ),

          SizedBox(height: 15,),


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
                  borderSide: BorderSide(width: 1,color: Colors.red),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1,color: Colors.orange),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1,color: Colors.red),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,)
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: Colors.black)
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: Colors.yellowAccent)
                ),
                hintText: "Postcode",
                helperText: "Enter postal code",
                helperStyle: GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),
                hintStyle: GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),
              ),
            ),
          ),

          SizedBox(height: 15,),


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
                  borderSide: BorderSide(width: 1,color: Colors.red),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1,color: Colors.orange),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1,color: Colors.red),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,)
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: Colors.black)
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: Colors.yellowAccent)
                ),
                hintText: "City",
                helperText: "Enter city",
                helperStyle: GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),
                hintStyle: GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),
              ),
            ),
          ),

          SizedBox(height: 15,),


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
                  borderSide: BorderSide(width: 1,color: Colors.red),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1,color: Colors.orange),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1,color: Colors.red),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,)
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: Colors.black)
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: Colors.yellowAccent)
                ),
                hintText: "Country",
                helperText: "Enter country",
                helperStyle: GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),
                hintStyle: GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),
              ),
            ),
          ),

          SizedBox(height: 15,),


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
                  borderSide: BorderSide(width: 1,color: Colors.red),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1,color: Colors.orange),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1,color: Colors.red),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,)
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: Colors.black)
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: Colors.yellowAccent)
                ),
                hintText: "State/Province",
                helperText: "Enter state/province",
                helperStyle: GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),
                hintStyle: GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),
              ),
            ),
          ),

          SizedBox(height: 40,),

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
                child: Text("Complete payment",
                    style: GoogleFonts.quicksand(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    )),
              ),
            ),
          ),

        ],

      ),
    );
  }
}