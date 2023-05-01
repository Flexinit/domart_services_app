import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ToursAndTravelController extends GetxController {
  DateTime selectedDate = DateTime.now();

  DateTime selectDate(BuildContext context)  {
    final DateTime picked =  showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101)) as DateTime;
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      return selectedDate;
    }

    return DateTime.now();
  }
}
