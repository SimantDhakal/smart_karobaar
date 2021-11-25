import 'package:flutter/material.dart';
import 'package:law_dairy/screen/init/login.dart';
import 'screen/module/dashboard_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Karobaar',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Poppins'
      ),
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}