import 'package:flutter/material.dart';
import 'package:snap/Constant/Dimens.dart';
import 'package:snap/Screen/LoadingTest.dart';

import 'Screen/MapScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        elevatedButtonTheme: 
           ElevatedButtonThemeData(
            style: ButtonStyle(
              splashFactory: NoSplash.splashFactory,
              animationDuration: const Duration(seconds: 2),
              fixedSize: 
              const MaterialStatePropertyAll(Size(double.infinity , 58)),
              shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.medium))),
              elevation: const MaterialStatePropertyAll(0.08),
              backgroundColor: MaterialStateProperty.resolveWith((states){
                if(states.contains(MaterialState.pressed)){
                  return const Color.fromARGB(255, 19, 107, 34);
                }
                return const Color.fromARGB(255, 16, 171, 37);
              })
            )
          )
      ),
      debugShowCheckedModeBanner: false,
      home:  Testscreen(),
    );
  }
}


