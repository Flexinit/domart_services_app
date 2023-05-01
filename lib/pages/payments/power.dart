import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soko/common/AppConfig.dart';
import 'package:soko/common/definitions.dart';
import 'package:soko/pages/payments/powergetbill.dart';

class Power extends StatefulWidget {
  Power({Key key}) : super(key: key);

  @override
  _PowerState createState() => _PowerState();
}

class _PowerState extends State<Power> {
  String nai_meter,kplc_meter,star_times,dstv_no,go_tv;

  Future getkplc()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    setState(() {
      kplc_meter=preferences.getString('user_kplc');

    });
  }

  @override
  Widget build(BuildContext context) {
    getkplc();

    return Scaffold(

       appBar: AppBar(
         title: Text("Power",style: 
                      GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),),
       ),

       body: ListView(
         children: <Widget>[
           SizedBox(height: 30,),
           Card(
            child: ListTile(
              onTap: (){
                AppConfig.commandId = Definitions.VOUCHER_FLEXI;
                AppConfig.providerID = Definitions.KPLC;
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Powerbill("kplc_prepaid",kplc_meter)));
                
            },
            leading: Image.asset("assets/kplc.png",height:50,width:50),
            title: Text("KPLC Prepaid",
             style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),),
             subtitle: Text("Prepaid (Buy tokens)",
             style: GoogleFonts.quicksand(),),
             ),
           ),

           Card(
            child: ListTile(
              onTap: (){
                AppConfig.commandId = Definitions.BILL_PAY;
                AppConfig.providerID = Definitions.KPLC;
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Powerbill("kplc_postpaid",kplc_meter)));

                
              },
            leading: Image.asset("assets/kplc.png",height:50,width:50),
            title: Text("KPLC Postpaid",
             style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),),
             subtitle: Text("Postpaid (Pay Bill)",
             style: GoogleFonts.quicksand( ),),
             ),
           ),
         ],
       ),


    );
  }
}