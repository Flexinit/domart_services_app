import 'dart:convert';
import 'dart:io';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soko/common/definitions.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {

  File groupimage;
    DateTime dateTime = new DateTime.now();
  String name,description,grouptypeid,purpose,goal,end,userid;
  String accesslevel="Public";

  var list = new List<dynamic>();

   @override
  void initState() {
    super.initState();
    fetchgrouptypes();
    getuserid();
  }



  Future getimage() async {
   // File imagefile = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
     // groupimage = imagefile;
    });
  }

    Future fetchgrouptypes() async {
    String grouptypesurl = Definitions.api_url+Definitions.endpoint_get_types;

    var response = await http.get(
     Uri.parse(grouptypesurl) ,
      headers: {
        'Accept': 'application/json',
      },
    );

    var jsonresponse = json.decode(response.body);

    this.setState(() {
      list = jsonresponse["types"];
    });
  }

    Future getuserid() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userid = sharedPreferences.getString("logged_in_user_id") ?? "";
    });
   
  }


 Future createfundraising() async{

          return showDialog(
          context: myGlobals.scaffoldKey.currentContext,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Confirm to create group"),
              actions: <Widget>[
                ElevatedButton(
                  child: Text("OK",),
                  onPressed: () async {
                    Navigator.pop(context);

                    try {

                        ProgressDialog pr = new ProgressDialog(context,
                            type: ProgressDialogType.Download, showLogs: true);
                        pr.style(message: 'Please wait...');
                        pr.show();
                        Map<String, String> field = {
                          "name": name,
                          "description": description,
                          "type_id": grouptypeid,
                          "visibility": accesslevel,
                          "end_date": end,
                          "purpose": purpose,
                          'goal_amount':goal,
                          'user_id':userid,
                        };
                        Map<String, String> headers = {
                          "Accept": 'application/json',
                        };
                        String group =
                            Definitions.api_url+Definitions.endpoint_create_group;
                        final postUri = Uri.parse(group);
                        http.MultipartRequest request =
                            http.MultipartRequest('POST', postUri);
                        http.MultipartFile multipartFile =
                            http.MultipartFile.fromBytes(
                                'image', groupimage.readAsBytesSync(),
                                filename: basename(groupimage.path));

                        request.fields.addAll(field);

                        request.files.add(multipartFile);
                        request.headers.addAll(headers);
                        var response = await request.send().then((result) {
                          print(result);
                          http.Response.fromStream(result).then((onValue) {
                            var jsonresponse = json.decode(onValue.body);

                            if (jsonresponse["group"] != null) {
                              pr.hide().whenComplete(() async {

                                 Fluttertoast.showToast(
                                  msg: "Successfull group creation",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                                  );
                                                        
                              });
                            }
                            else{

                               pr.hide().whenComplete(() async {

                                  Fluttertoast.showToast(
                                  msg: "An error occured",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                                  );
                                       
                                
                              });

                            }
                          });
                        });
                        print(response);
                      
                    } catch (e) {
                    }
                  },
                )
              ],
            );
          });  

 }

  Future createothers() async{

          return showDialog(
          context: myGlobals.scaffoldKey.currentContext,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Confirm to create group"),
              actions: <Widget>[
                ElevatedButton(
                  child: Text("OK",),
                  onPressed: () async {
                    Navigator.pop(context);

                    try {

                        ProgressDialog pr = new ProgressDialog(context,
                            type: ProgressDialogType.Download, showLogs: true);
                        pr.style(message: 'Please wait...');
                        pr.show();
                        Map<String, String> field = {
                          "name": name,
                          "description": description,
                          "type_id": grouptypeid,
                          "visibility": accesslevel,
                          "end_date": end,
                          'goal_amount':goal,
                          'user_id':userid,
                        };
                        Map<String, String> headers = {
                          "Accept": 'application/json',
                        };
                        String group =
                            Definitions.api_url+Definitions.endpoint_create_group;
                        final postUri = Uri.parse(group);
                        http.MultipartRequest request =
                            http.MultipartRequest('POST', postUri);
                        http.MultipartFile multipartFile =
                            http.MultipartFile.fromBytes(
                                'image', groupimage.readAsBytesSync(),
                                filename: basename(groupimage.path));

                        request.fields.addAll(field);

                        request.files.add(multipartFile);
                        request.headers.addAll(headers);
                        var response = await request.send().then((result) {
                          print(result);
                          http.Response.fromStream(result).then((onValue) {
                            var jsonresponse = json.decode(onValue.body);

                            if (jsonresponse["group"] != null) {
                              pr.hide().whenComplete(() async {

                                 Fluttertoast.showToast(
                                  msg: "Successfull group creation",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                                  );
                                                        
                              });
                            }
                            else{

                               pr.hide().whenComplete(() async {

                                  Fluttertoast.showToast(
                                  msg: "An error occured",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                                  );
                                       
                                
                              });

                            }
                          });
                        });
                        print(response);
                      
                    } catch (e) {
                    }
                  },
                )
              ],
            );
          });  

 }
  

  Future validate()async{
    
    if (grouptypeid?.isEmpty??true) {
         return showDialog(
            context: myGlobals.scaffoldKey.currentContext,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Please select group type"),
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

    else if (name?.isEmpty??true) {
       return showDialog(
            context: myGlobals.scaffoldKey.currentContext,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Please input name"),
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
    else if (description?.isEmpty??true) {
 return showDialog(
           context: myGlobals.scaffoldKey.currentContext,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Please input description"),
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
    else if (groupimage==null) {

       return showDialog(
           context: myGlobals.scaffoldKey.currentContext,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Please select image"),
              actions: <Widget>[
                ElevatedButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                    getimage();
                  },
                )
              ],
            );
          });  
      
    }
   
    else if (accesslevel?.isEmpty??true) {

       return showDialog(
           context: myGlobals.scaffoldKey.currentContext,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Please select access level"),
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
    else if (end?.isEmpty??true) {

       return showDialog(
          context: myGlobals.scaffoldKey.currentContext,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Please select end date"),
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
    else if (goal?.isEmpty??true) {

       return showDialog(
           context: myGlobals.scaffoldKey.currentContext,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Please input target amount"),
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
     else if(grouptypeid=="2"){

       if (purpose?.isEmpty??true) {
          return showDialog(
           context: myGlobals.scaffoldKey.currentContext,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Please input purpose for fundraising"),
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
       else {

         createfundraising();

       }

      

    }
    else{

      createothers();

    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       key: myGlobals.scaffoldKey,
      appBar: AppBar(
        title: Text("Create group"),
      ),

      body: ListView(
        children: <Widget>[

           SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                getimage();
              },
              child: CircleAvatar(
                radius: 50,
                child: groupimage == null
                    ? CircleAvatar(
                        radius: 50,
                        backgroundColor: Color(0XFFd3d3d3),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      )
                    : ClipOval(
                        child: SizedBox(
                            height: 150.0,
                            width: 100.0,
                            child: Image.file(groupimage, fit: BoxFit.fill)),
                      ),
              ),
            ),
          SizedBox(height: 10,),

            Padding(
              padding:
                  EdgeInsets.only(left: 15, right: 15, top: 10.0, bottom: 10.0),
              child: DropdownButton(
                hint: Text("Group type"),
                isExpanded: true,
                items: list?.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(item['name']),
                        value: item['id'].toString(),
                      );
                    })?.toList() ??
                    [],
                onChanged: (newVal) {
                  setState(() {
                    grouptypeid = newVal;
                  });
                },
                value: grouptypeid,
              ),
            ),

          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
            keyboardType: TextInputType.text,
            onChanged: (value){
              name=value;
            },
             decoration: InputDecoration(
                labelStyle: GoogleFonts.quicksand( color:Color(0xffc70404)),
               labelText: "Name"
             ),
          ),
          ),

           SizedBox(height: 10,),

          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            onChanged: (value){
              description=value;
            },
             decoration: InputDecoration(
                labelStyle: GoogleFonts.quicksand( color:Color(0xffc70404)),
               labelText: "Description"
             ),
          ),
          ),

          Container(
            padding: EdgeInsets.all(10),
            child: grouptypeid=="2"?
            TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            onChanged: (value){
              purpose=value;
            },
             decoration: InputDecoration(
                labelStyle: GoogleFonts.quicksand( color:Color(0xffc70404)),
               labelText: "Purpose of fundraiser"
             ),
          ):Container(height: 0,),
          ),

          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value){
              goal=value;
            },
             decoration: InputDecoration(
                labelStyle: GoogleFonts.quicksand( color:Color(0xffc70404)),
               labelText: "Target Amount"
             ),
          ),
          ),

          Container(
            child: ListTile(
              title: Text("End Date"),
              subtitle: end?.isEmpty??true?Text(dateTime.toString()):Text(end),
              onTap: () async {
                  DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(1963, 3, 5),
                              maxTime: DateTime(2030, 6, 7), onChanged: (date) {
                            setState(() {
                              end=date.toString();
                            });                             
                           
                          }, onConfirm: (date) {

                            setState(() {
                              end=date.toString();
                            });
                             
                          }, currentTime: DateTime.now(), locale: LocaleType.en);


                
              },
            ),
          ),

             ListTile(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        child: Wrap(
                          children: <Widget>[
                            ListTile(
                              onTap: () {
                                setState(() {
                                  accesslevel = "Private";
                                  Navigator.pop(context);
                                });
                              },
                              title: Text("Private"),
                            ),
                            ListTile(
                              title: Text("Public"),
                              onTap: () {
                                setState(() {
                                  accesslevel = "Public";
                                  Navigator.pop(context);
                                });
                              },
                            )
                          ],
                        ),
                      );
                    });
              },
              title: Text("Access Level"),
              trailing: Text(
                accesslevel,
                style: TextStyle(fontSize: 14),
              ),
            ),


             SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: ButtonTheme(
                height: 40,
                minWidth: 40,
                child: ElevatedButton(
                //  color: Theme.of(context).primaryColor,
                  onPressed: () {

                    validate();
                  },
                  child: Text("CREATE GROUP",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            SizedBox(height: 20),




        ],
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
