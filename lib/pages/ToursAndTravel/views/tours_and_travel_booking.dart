import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:soko/common/timer.dart';
import 'package:soko/pages/ToursAndTravel/Controllers/tours_travel_controller.dart';
import 'package:http/http.dart' as http;


import '../../../common/definitions.dart';

class ToursAndTravel extends StatefulWidget {
  @override
  _ToursAndTravelState createState() => _ToursAndTravelState();
}

class _ToursAndTravelState extends State<ToursAndTravel> {
  final toursAndTravelController = Get.put(ToursAndTravelController());
  DateTime selectedDate = DateTime.now();
  DateTime departureDate = DateTime.now();
  DateTime returnDate = DateTime.now();

  TextEditingController townOfDepartureController = new TextEditingController();
  TextEditingController townOfDestinationController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController dateOfDepartureController = new TextEditingController();
  TextEditingController dateOfReturnController = new TextEditingController();
  TextEditingController fullNameController = new TextEditingController();
  TextEditingController idNumberController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController emergencyContactNameController = new TextEditingController();
  TextEditingController emergencyIdNumberController = new TextEditingController();


/*
  Future<void> _selectDepartureDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: departureDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != departureDate) {
      setState(() {
        departureDate = picked;
      });
    }
  }
*/

/*
  Future<void> _selectReturnDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: returnDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != returnDate) {
      setState(() {
        returnDate = picked;
      });
    }
  }
*/

  Future validate() async {
    if (townOfDepartureController.text?.isEmpty ?? true) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Please Input Town of Departure"),
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
    } else if (townOfDestinationController.text?.isEmpty ?? true) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Please input Destination Town"),
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
    } else if (emailController.text?.isEmpty ?? true) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Please input a valid email address"),
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
    } /*else if (dateOfDepartureController.text?.isEmpty ?? true) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Please input Date of Departure"),
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
    } else if (dateOfReturnController.text?.isEmpty ?? true) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Please input Date of Departure"),
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
    }*/ else if (fullNameController.text?.isEmpty ?? true) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Please input your Full Name"),
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
    } else if (idNumberController.text?.isEmpty ?? true) {
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
    } else if (phoneNumberController.text?.isEmpty ?? true) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Please a valid Phone Number"),
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
    } else if (emergencyContactNameController.text?.isEmpty ?? true) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Please input emergency Contact Name"),
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
    } else if (emergencyIdNumberController.text?.isEmpty ?? true) {
      //GetUtils.isNullOrBlank(value)
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Please input emergency contact ID"),
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
              content: Text("CONFIRM to Book your Ticket"),
              backgroundColor: Colors.green,
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

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PaymentTimer()));
                    submitBusBookingDetails();
                  },
                )
              ],
            );
          });
    }
  }

  Future submitBusBookingDetails() async {
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, showLogs: true);
    pr.style(message: 'Please wait...');
    pr.show();

    String url = Definitions.api_url + Definitions.book_ticket;

    var response = await http.post(
      Uri.parse(url),
      body: json.encode({
        "departure_town": townOfDepartureController.text,
        "destination_town": townOfDestinationController.text,
        "email": emailController.text,
        "departure_date": "2022-01-01",
        "return_date": "2022-01-01",
        "full_name": fullNameController.text,
        "id_no": idNumberController.text,
        "phone_no": phoneNumberController.text,
        "emergency_contact_name": emergencyIdNumberController.text,
        "emergency_contact_id": emergencyIdNumberController.text
      }),
      headers: {
        'Accept': 'application/json',
      },
    );


    var jsonresponse = json.decode(response.body);
//print('RESPONSE: $jsonresponse');

    if (jsonresponse['ResultDesc'] != null) {
      pr.hide().whenComplete(() {
        Fluttertoast.showToast(
            msg: "${jsonresponse['ResultDesc']}",
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
            msg: "${jsonresponse['ResultDesc']}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tours and Travels'),
          backgroundColor: Colors.purple,
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.location_city),
                  title: TextField(
                    controller: townOfDepartureController,
                    decoration:
                    InputDecoration(hintText: 'City/ Town of Departure'),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.location_city),
                  title: TextField(
                    controller: townOfDestinationController ,
                    decoration:
                    InputDecoration(hintText: 'City/ Town of Destination'),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.calendar_today_outlined),
                  title: Text("${departureDate.toLocal()}".split(' ')[0]),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                 //   color: Colors.purple,
                    onPressed: () {
                      //_selectDepartureDate(context);
                    },
                    child: Text(
                      'Select Date of Departure',
                      style: TextStyle(color: Colors.white),
                    )
                ),
                ListTile(
                  leading: Icon(Icons.calendar_view_day),
                  title: Text("${returnDate.toLocal()}".split(' ')[0]),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                   // color: Colors.purple,
                    onPressed: () {
                      //_selectReturnDate(context);
                    },
                    child: Text(
                      'Select Date of Return',
                      style: TextStyle(color: Colors.white),
                    )),
                ListTile(
                  leading: Icon(Icons.person),
                  title: TextField(
                    decoration: InputDecoration(hintText: 'Full Name'),
                    controller: fullNameController,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.perm_identity),
                  title: TextField(
                    controller: idNumberController,
                    decoration: InputDecoration(hintText: 'ID Number'),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: TextField(
                    controller: phoneNumberController,
                    decoration: InputDecoration(hintText: 'Phone Number'),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.alternate_email),
                  title: TextField(
                    controller: emailController,
                    decoration: InputDecoration(hintText: 'Email Address'),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.emergency),
                  title: TextField(
                    controller: emergencyContactNameController,
                    decoration:
                    InputDecoration(hintText: 'Emergency Contact Name'),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.document_scanner),
                  title: TextField(
                    controller: emergencyIdNumberController,

                    decoration:
                    InputDecoration(hintText: 'Emergency Contact ID Number'),
                  ),
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  style: ButtonStyle(
                  ),
                  onPressed:() {
                    validate();
                  },
                  child: Wrap(
                    children: <Widget>[
                      Icon(
                        Icons.cloud_done,
                        color: Colors.white,
                        size: 24.0,
                      ),
                      SizedBox(
                        width:10,
                      ),
                      Text("Submit Booking Details", style:TextStyle(fontSize:20)),
                    ],
                  ),
                ),
              ],

            ),

          ),
        ),
      ),
    );
  }
}
