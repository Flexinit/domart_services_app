import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soko/pages/payments/addtvbill.dart';

class Paytv extends StatefulWidget {
  Paytv({Key key}) : super(key: key);

  @override
  _PaytvState createState() => _PaytvState();
}

class _PaytvState extends State<Paytv> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text("Pay TV",style: 
                      GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),),
       ),

       body: ListView(
         children: <Widget>[
           SizedBox(height: 30,),

           Card(
            child: ListTile(
              onTap: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context)=>Adddtvbill("KWESE", "assets/kwese.png")));
              },
            leading: Image.asset("assets/kwese.png",height:50,width:50),
            title: Text("Kwese",
             style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),),
             subtitle: Text("Pay for Kwese services",
             style: GoogleFonts.quicksand( ),),
             ),
           ),
            Card(
            child: ListTile(
                onTap: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context)=>Adddtvbill("Dstv", "assets/dstv.png")));
              },
            leading: Image.asset("assets/dstv.png",height:50,width:50),
            title: Text("Dstv",
             style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),),
             subtitle: Text("Pay for Dstv services",
             style: GoogleFonts.quicksand( ),),
             ),
           ),
            Card(
            child: ListTile(
              onTap: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context)=>Adddtvbill("GoTv", "assets/gotv.jpg")));
              },
            leading: Image.asset("assets/gotv.jpg",height:50,width:50),
            title: Text("GoTv",
             style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),),
             subtitle: Text("Pay for GoTv services",
             style: GoogleFonts.quicksand( ),),
             ),
           ),

            Card(
            child: ListTile(
               onTap: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context)=>Adddtvbill("Zuku", "assets/zukulogo.jpg")));
              },
            leading: Image.asset("assets/zukulogo.jpg",height:50,width:50),
            title: Text("Zuku",
             style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),),
             subtitle: Text("Pay for zuku services",
             style: GoogleFonts.quicksand( ),),
             ),
           ),

              Card(
            child: ListTile(
              onTap: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context)=>Adddtvbill("StarTimes", "assets/star.jpg")));
              },
            leading: Image.asset("assets/star.jpg",height:50,width:50),
            title: Text("StarTimes",
             style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, ),),
             subtitle: Text("Pay for StarTimes services",
             style: GoogleFonts.quicksand( ),),
             ),
           ),

           

         ],
       ),

    );
  }
}