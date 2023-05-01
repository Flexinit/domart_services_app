import 'dart:async';

import 'package:flutter/material.dart';

class PaymentTimer extends StatefulWidget {
  @override
  _PaymentTimerState createState() => _PaymentTimerState();
}

class _PaymentTimerState extends State<PaymentTimer> {
  final interval = const Duration(seconds: 1);

  final int timerMaxSeconds = 60;

  int currentSeconds = 0;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  startTimeout([int milliseconds]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      setState(() {
        print(timer.tick);
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) timer.cancel();
      });
    });
  }

  @override
  void initState() {
    startTimeout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Container(
        color: Colors.white,
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.timer),
              SizedBox(
                width: 5,
              ),
              Text(timerText)
            ],
          ),
        ),
      ),
    );
  }
}