import 'package:flutter/material.dart';
import 'package:soko/pages/auth/signin.dart';
import 'package:soko/pages/main/mainpage.dart';

import 'common/service_locator.dart';

void main() => runApp(MyApp(
    setupLocator()

));

class MyApp extends StatelessWidget {
  MyApp(void setupLocator);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Domart',

      theme: ThemeData(
          primaryColor: Color(0xffCEF28E),
          secondaryHeaderColor: Color(0xffFBFBDB) ,
          bottomAppBarColor: Color(0xffFCFCE2),
          accentColor: Color(0xffFDFDEE),
          textTheme: TextTheme(),
          inputDecorationTheme: InputDecorationTheme(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff81A632))))),
      debugShowCheckedModeBanner: false,
      home: SignIn(),

    );
  }
}
