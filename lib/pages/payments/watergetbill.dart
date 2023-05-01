import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:soko/common/definitions.dart';
import 'package:soko/pages/payments/payment_modes/airtel_money.dart';
import 'package:soko/pages/payments/payment_modes/credit_card.dart';
import 'package:soko/pages/payments/payment_modes/mpesa.dart';
import 'package:soko/pages/payments/payment_modes/tkash.dart';
import 'package:soko/pages/payments/waterpaybill.dart';


 class WaterGetBill extends StatefulWidget {
   final String service;
   WaterGetBill(this.service);
 
   @override
   _WaterGetBillState createState() => _WaterGetBillState(this.service);
 }
 
 class _WaterGetBillState extends State<WaterGetBill> {
   String meter_no,pmt_mode;
    final String service;
   _WaterGetBillState(this.service);
   @override
   Widget build(BuildContext context) {
     Future validate() async {
      if (meter_no?.isEmpty ?? true) {
         return showDialog(
             context: context,
             builder: (BuildContext context) {
               return AlertDialog(
                 content: Text("Please input meter no"),
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
       } else{
       // Navigator.push(context, MaterialPageRoute(builder: (context)=>WaterPayBill("")));

       }
     }

     return Scaffold(

       appBar: AppBar(
         title: Text("Water Bill",style:
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

          SizedBox(height: 30,),

            Container(
             padding: EdgeInsets.all(10),
             child: TextField(
               keyboardType: TextInputType.phone,
               onChanged: (value){
                 meter_no=value;

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
                 hintText: "Meter Number",
                 helperText: "Enter meter",
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
                  //color: Color(0xffc70404),
                  onPressed: () {               
                    validate();
                  },
                  child: Text("Get Bill",
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