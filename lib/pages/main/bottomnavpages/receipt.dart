import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soko/common/AppConfig.dart';
import 'package:soko/common/definitions.dart';

class Receipt extends StatefulWidget {
  @override
  _ReceiptState createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  int itemCountBills = AppConfig.completedPayments.length;
  String billPaymentsJsonStr;

  String airtimeJsonStr;

  @override
  void initState() {
    super.initState();
    AppConfig.getReceiptData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Receipts (Total: ${AppConfig.calculateTotalAmount(AppConfig.completedPayments)} )',
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.bold,
              color: Colors.purple
            ),

          ),
          backgroundColor: Colors.purple[50],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: AppConfig.completedPayments.length,
             shrinkWrap: false,
            itemBuilder: (context, index) {
              return Card(
                //
                child: ListTile(
                  leading: Icon(
                    Icons.receipt,
                    color: Color(0xffc70404),
                  ),
                  title: Text(
                    '${AppConfig.completedPayments[index].created_at.substring(0,20).replaceAll('T', '     ')}',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    //  'Amount: ${AppConfig.completedPayments[index].amount_billed} Status: ${AppConfig.getPaymentStatus(AppConfig.completedPayments[index].status.toString())}  Channel: ${AppConfig.completedPayments[index].channel} \n Details. : ${AppConfig.completedPayments[index].message}'),
                     'Amount: ${AppConfig.completedPayments[index].amount_billed}   Channel: ${AppConfig.completedPayments[index].channel} \n Details.  ${AppConfig.completedPayments[index].message ?? ''}'),
                ),
              );
            },
            //    : Center(child: const Text('No items')),
          ),
        )
    );
  }


}
