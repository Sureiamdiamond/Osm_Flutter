import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:snap/Screen/MapScreen.dart';

import '../Constant/Textstyles.dart';

class Splash extends StatefulWidget{
  const Splash({super.key});

  
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1700), () {
      Navigator.pushReplacement(context,MaterialPageRoute(builder:
      (context) =>  const MyHomePage()));

    });
    const MyHomePage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("پ", style:MyTextStyle.button2,),
            const SizedBox(height: 3,),
            const Text('OSM Flutter App'),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                SizedBox(
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