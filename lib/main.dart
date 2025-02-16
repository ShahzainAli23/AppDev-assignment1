import 'package:flutter/material.dart';
import 'myProfile.dart'; // Import the first screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      home: myProfile(),
    );
  }
}
