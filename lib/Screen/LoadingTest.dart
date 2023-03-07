import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:snap/Screen/MapScreen.dart';

class Testscreen extends StatefulWidget{
  
  @override
  State<Testscreen> createState() => _TestscreenState();
}

class _TestscreenState extends State<Testscreen> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      Navigator.pushReplacement(context,MaterialPageRoute(builder:
      (context) =>  MyHomePage()));

    });
    MyHomePage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Parsa", style: TextStyle(fontSize: 44),),
            SpinKitRing(color: Colors.black,),
          ],
        ),
      ),
    );
  }
}