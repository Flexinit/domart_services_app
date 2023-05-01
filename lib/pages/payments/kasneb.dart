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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
 class Kasneb extends StatefulWidget {
   final String service;
   Kasneb(this.service);

 
   @override
   _KasnebState createState() => _KasnebState(this.service);
 }
 
 class _KasnebState extends State<Kasneb> {
   // access preferences
   String userid;
   Future getuserid()async{
     SharedPreferences preferences=await SharedPreferences.getInstance();
     setState(() {
       userid=preferences.getString('userdata');
     });
   }
   String meter_no, amount,pmt_mode;
    final String service;
   _KasnebState(this.service);
   @override
   Widget build(BuildContext context) {
     getuserid();
     var userArrr = json.decode(userid);
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
       }else{
         // prepare the payment
         try {
           ProgressDialog pr = new ProgressDialog(context,
               type: ProgressDialogType.Normal, showLogs: true,isDismissible: false);
           pr.style(message: 'Please wait...');
           pr.show();

           String url = Definitions.api_url+Definitions.endpoint_initiate_pmt;
           var timestamp = new DateTime.now().millisecondsSinceEpoch;
           String oid = userArrr['id'] + timestamp;

           var response = await http.post(Uri.parse(url),
               body: json.encode({"email": userArrr["email"], "oid": oid,"inv" : oid, "tel" : userArrr["phone"], "amount" : amount, "app_token" : Definitions.app_token, "fname" : userArrr["fname"], "lname" : userArrr["lname"],"user_id" : userArrr["id"]}));

           var jsonresponse = json.decode(response.body);

           if (jsonresponse["status"] != null) {
             var status = jsonresponse["status"];
             if(status == '00'){
               pr.hide();
               var data = jsonresponse["data"];
               var misc = jsonresponse['misc'];
               var payto = misc['payment_to'];
               var paygrp = misc['payment_grp'];
               var accno = misc['account'];
               var sid = data['sid'];
               var amountBilled = data['amount'];
               var acc_no = data['account'];

               switch(pmt_mode){

                 case "MPESA":
                   Navigator.push(context, MaterialPageRoute(
                       builder: (context)=>Mpesa(sid,amountBilled,acc_no,oid,'0',payto,paygrp,accno)));
                   break;
                 case "AIRTELMONEY":
                   Navigator.push(context, MaterialPageRoute(
                       builder: (context)=>AirtelMoney(sid,amountBilled,acc_no,oid,payto,paygrp,accno)));
                   break;
                 case "CREDITCARD":
                   Navigator.push(context, MaterialPageRoute(
                       builder: (context)=>CreditCard(sid,amountBilled,acc_no,oid)));
                   break;
                 case "T-KASH":
                   Navigator.push(context, MaterialPageRoute(
                       builder: (context)=>T_kash(sid,amountBilled,acc_no,oid,payto,paygrp,accno)));
                   break;
               }

             } else {
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
             }

           }
         } catch (e) {}

       }
     }

     return Scaffold(

       appBar: AppBar(
         title: Text("Kasneb Bill",style:
                      GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),),
       ),

       body: ListView(
         children: <Widget>[

           SizedBox(height: 20,),

              Container(
                alignment: Alignment.center,
                child:   Text(service,style: 
              GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),),
              ),
           Container(
             padding: EdgeInsets.all(10),
             child: TextField(
               keyboardType: TextInputType.phone,
               onChanged: (value){
                 amount=value;
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
                 hintText: "Amount",
                 helperText: "Enter amount",
                 helperStyle: GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),
                 hintStyle: GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),
               ),
             )
           ),

           SizedBox(height: 15,),
           Container(
             padding: EdgeInsets.all(10),
             child: RadioButtonGroup(
               orientation: GroupedButtonsOrientation.HORIZONTAL,
//               margin: const EdgeInsets.only(left: 12.0),

               onSelected: (String selected) => setState((){
                 pmt_mode = selected.replaceAll(' ','');
               }),
               labels: <String>["     MPESA     ","     AIRTEL MONEY     ","     T-KASH     "],
//               picked: pmt_mode,
               itemBuilder: (Radio rb,Text txt,int i){
                 return Column(
                   children: <Widget>[rb,txt,],
                 );
               },
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
                  child: Text("Pay",
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