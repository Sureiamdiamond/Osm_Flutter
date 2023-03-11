import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:snap/Screen/MapScreen.dart';

import '../Constant/Textstyles.dart';

class Testscreen extends StatefulWidget{
  
  @override
  State<Testscreen> createState() => _TestscreenState();
}

class _TestscreenState extends State<Testscreen> {
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 1700), () {
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
            Text("پ", style:MyTextStyle.button2,),
            SizedBox(height: 3,),
            Text('OSM Flutter App'),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 70,
                  width: 20,
                ),

                SpinKitFadingGrid(color:Color.fromARGB(255, 16, 171, 37 ,), size:25 ),
              ],
            )



          ],
        ),
      ),
    );
  }
}