import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:soko/common/definitions.dart';

class ExploreGroups extends StatefulWidget {
  @override
  _ExploreGroupsState createState() => _ExploreGroupsState();
}

class _ExploreGroupsState extends State<ExploreGroups> {

    String userid;

     @override
    void initState() {
    super.initState();
    getuserid();
   
     }  


    Future getuserid()async{
      SharedPreferences preferences=await SharedPreferences.getInstance();

      setState(() {

        userid=preferences.getString('logged_in_user_id');
        
      });
    }


     Future groups()async{

      var response=await 
      http.post(Uri.parse(Definitions.api_url+Definitions.endpoint_explore_groups),
      body: {
        'id':userid
      },
      headers: {
      'Accept': 'application/json',
      },);

      var jsonresponse=json.decode(response.body);

      return jsonresponse['groups'];


    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Explore Groups"),
      ),
         body: FutureBuilder(
      future: groups(),
      builder: (context,snapshot){
        if (snapshot.data==null) {
           return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
              ),
            );
          
        } else {

         return ListView.separated(
            itemBuilder: (context,index){
              return ListTile(
                onTap: (){

                  showBottomSheet(
                    context: context,
                     builder: (context)=>Container(
                       child: Column(
                         children: <Widget>[
                           SizedBox(height: 20,),
                           Text("Pay contribution to "+snapshot.data[index]['name'],
                           style: GoogleFonts.quicksand(),),
                           SizedBox(height: 20,),
                           Container(
                             padding: EdgeInsets.all(10),
                             child: TextField(
                               keyboardType: TextInputType.number,
                               decoration: InputDecoration(
                                 labelText: "Enter amount",
                                 border: OutlineInputBorder(                                   
                                    borderSide: new BorderSide(
                                      color:  Theme.of(context).primaryColor
                                    )

                                 )
                               ),
                             )    ,

                           ),
                           SizedBox(height: 30,),
                           Text("Select payment option",
                           style: GoogleFonts.quicksand(),),
                           ListView(
                             children: <Widget>[
                               GestureDetector(
                                 child: Image.asset("assets/mpesalogo.png",height: 100,width: 100,),
                                 onTap: (){

                                 },

                               ),



                             ],
                           ),
                           SizedBox(height: 20,),
                           Padding(
                            padding: EdgeInsets.only(left: 30, right: 30),
                            child: ButtonTheme(
                              height: 40,
                              minWidth: 300,
                              child: ElevatedButton(
                                //color: Color(0xffc70404),
                                onPressed: () {               
                                  
                                },
                                child: Text("MAKE PAYMENT",
                                    style: GoogleFonts.quicksand(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                    )),
                              ),
                            ),
                          ),
                           
                         ],
                       ),

                     ));

                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                  snapshot.data[index]['image'],
                   
                ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                trailing: Icon(Icons.arrow_right,size: 14,),
                title: Text(snapshot.data[index]['name'],style: GoogleFonts.quicksand(),),
                subtitle: Text(snapshot.data[index]['description'],style: GoogleFonts.quicksand(),),
              );
            },
             separatorBuilder: (context,index){
               return Divider();
             },
            itemCount: snapshot.data.length);
        }
      }),
      
      
    );
  }
}