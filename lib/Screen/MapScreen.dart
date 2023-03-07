
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:snap/Constant/Textstyles.dart';
import 'package:snap/Widget/BackButton.dart';
import 'package:snap/gen/assets.gen.dart';

class currentWidgetState{
   currentWidgetState._();
   static const stateSelectMabda = 0;
   static const stateSelectMaghsad = 1;
   static const stateREQdriver = 2;
}

class MyHomePage extends StatefulWidget{
  const MyHomePage({super.key});
  @override
  State<StatefulWidget> createState() => MyHomePageState();
  }


  class MyHomePageState extends State<MyHomePage>{

  List<GeoPoint> geoPoint = [];
  
  //Avalin index list
  List currentWidgetList = [currentWidgetState.stateSelectMabda];

  //Icon
  Widget MarkeerIcon = SvgPicture.asset(Assets.icons.origin , height: 100, width: 40);

  //MapController
  MapController mapController = MapController(
    initMapWithUserPosition: true,
    // initPosition: GeoPoint(latitude: 35.7367516373 ,longitude:51.2911096718)
  );
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body:Stack(
          children: [

            //OSM
           SizedBox.expand(
             child: OSMFlutter(
               controller: mapController,
               trackMyPosition: false,
               initZoom: 16.5,
               isPicker: true,
               mapIsLoading: const SpinKitRing(color:Color.fromARGB(255, 16, 171, 37)),
               minZoomLevel: 6,
               maxZoomLevel: 19,
               stepZoom: 1,
               markerOption: MarkerOption(advancedPickerMarker: MarkerIcon(iconWidget: MarkeerIcon)),



             ),
           ),

            //CurrentWidget
            cuurentWidget(),

            //BackButton
             Backbbutton(onPpressed: (){
               if(geoPoint.isNotEmpty){
                 geoPoint.removeLast();
                 MarkeerIcon = SvgPicture.asset(Assets.icons.origin
                   , height: 100, width: 48,);
               }
               if(currentWidgetList.length>1){
                 setState(() {
                   currentWidgetList.removeLast();
                 });
               }

               mapController.init();
             }),
          ],
        ),
      ),
    );
  }

  Widget cuurentWidget(){

    Widget widget = mabda();

    switch(currentWidgetList.last){
      case currentWidgetState.stateSelectMabda :
        widget = mabda();
        break;
      case currentWidgetState.stateSelectMaghsad :
        widget = maghsad();
        break;
       case currentWidgetState.stateREQdriver :
         widget = reqDriver();
        break;

    }
    return widget;
  }
  Widget mabda() {
    return Positioned(
            bottom: 18,
            right: 20,
            left: 20,
            child: ElevatedButton(
                onPressed: () async{
                  GeoPoint geopointMabda = await mapController.getCurrentPositionAdvancedPositionPicker();
                  geoPoint.add(geopointMabda);
                  log("latitude ==> ${geopointMabda.latitude}\nlongitude ==> ${geopointMabda.longitude}");
                  MarkeerIcon = SvgPicture.asset(Assets.icons.destination , height: 100, width: 48);
                  setState(() {
                    currentWidgetList.add(currentWidgetState.stateSelectMaghsad);
                  });
                  mapController.init();
                },
                child: Text("انتخاب مبدا" , style: MyTextStyle.button)
            ),
          );
  }
  Widget maghsad() {
    return Positioned(
            bottom: 18,
            right: 20,
            left: 20,
            child: ElevatedButton(
                onPressed: (){
                  setState(() {
                    currentWidgetList.add(currentWidgetState.stateREQdriver);
                  });
                  mapController.init();
                },
                child: Text("انتخاب مقصد" , style: MyTextStyle.button)
            ),
          );
  }
  Widget reqDriver() {
    return Positioned(
            bottom: 18,
            right: 20,
            left: 20,
            child: ElevatedButton(
                onPressed: (){},
                child: Text("درخواست راننده" , style: MyTextStyle.button)
            ),
          );
  }

}

