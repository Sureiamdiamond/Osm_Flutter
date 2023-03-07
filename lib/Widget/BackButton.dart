import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constant/Dimens.dart';



class Backbbutton extends StatelessWidget {

 Function()  onPpressed;
 Backbbutton({required this.onPpressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: Dimens.medium,
      left: Dimens.medium,
      child: Container(
        height: 45,
        width: 45,
        decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow:[
              BoxShadow(
                  color: Colors.black26,
                  offset: Offset(1.5,1.5),
                  blurRadius: 3.5
              ),
            ]
        ),
        child: IconButton(
          onPressed: onPpressed,
          icon: const Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}