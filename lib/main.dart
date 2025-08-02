import 'package:flutter/material.dart';
import 'package:password/passwordChecker/passwordCheck.dart';


void main() {
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyHome());
  }
}

class MyHome extends StatefulWidget  {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
           debugShowCheckedModeBanner: false,
          home: Passwordcheck(),
      );
  }
}