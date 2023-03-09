
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:snap/Constant/Dimens.dart';
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
  String distance = "درحال محاسبه ی فاصله";
  String disAdress = "درحال بدست اوردن مقصد";
  String originAdress = "درحال بدست اوردن مبدا";
  //Avalin index list
  List currentWidgetList = [currentWidgetState.stateSelectMabda];
//markers
  Widget MaghsadMarker = SvgPicture.asset(Assets.icons.origin , height: 100, width: 48);
  Widget MabdaMarker = SvgPicture.asset(Assets.icons.destination , height: 100, width: 48);
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
               initZoom: 15,
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

               switch(currentWidgetList.last){

                 case currentWidgetState.stateSelectMabda :

                   break;

                 case currentWidgetState.stateSelectMaghsad :
                     geoPoint.removeLast();
                     MarkeerIcon = MabdaMarker;

                   break;

                 case currentWidgetState.stateREQdriver :
                   mapController.advancedPositionPicker();
                   mapController.removeMarker(geoPoint.last);
                   geoPoint.removeLast();
                   MarkeerIcon = MaghsadMarker;
                   break;
               }

               setState(() {
                 currentWidgetList.removeLast();
               });

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
                  MarkeerIcon = MabdaMarker;
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
                onPressed: ()async{

                  await mapController.getCurrentPositionAdvancedPositionPicker().then((value) {
                    geoPoint.add(value);
                  });
                  mapController.cancelAdvancedPositionPicker();

                  await mapController.addMarker(geoPoint.first ,
                      markerIcon: MarkerIcon(iconWidget:MaghsadMarker));

                  await mapController.addMarker(geoPoint.last ,
                      markerIcon: MarkerIcon(iconWidget:MabdaMarker));

                  setState(() {
                    currentWidgetList.add(currentWidgetState.stateREQdriver);
                  });

                  await distance2point(geoPoint.first, geoPoint.last).then((value){

                    setState(() {
                      if(value<=1000){
                        distance = "فاصله ی مبدا تا مقصد ${value.toInt()} متر";
                      } else{
                        distance = "فاصله ی مبدا تا مقصد ${value~/1000} کیلومتر";
                      }
                    });
                  });
                  getAdress();

                },
                child: Text("انتخاب مقصد" , style: MyTextStyle.button)
            ),
          );
  }
  Widget reqDriver() {
    mapController.zoomOut();
    return Positioned(
            bottom: 18,
            right: 20,
            left: 20,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimens.medium),
                    color: Color(0xe47a8a7a),

                  ),
                  child: Center(child: Text(distance , style: MyTextStyle.button1 )),
                ),
                const SizedBox(height: Dimens.small,),
                Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimens.medium),
                    color: Colors.white,

                  ),
                  child: Center(child: Text("Origin : $originAdress")),
                ),
                const SizedBox(height: Dimens.small,),
                Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimens.medium),
                    color: Colors.white,

                  ),
                  child: Center(child: Text("Destination : $disAdress")),
                ),
                const SizedBox(height: Dimens.small),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: (){
                        mapController.init();

                      },

                      child: Text("درخواست راننده" , style: MyTextStyle.button),
                  ),
                ),
              ],
            ),
          );
  }
 getAdress()async{

    try{
      //maghsad
      await placemarkFromCoordinates(geoPoint.last.latitude, geoPoint.last.longitude).then((List <Placemark> plist){
        setState(() {
          disAdress = " ${plist.first.thoroughfare} ${plist[2].name}";
        });
      });
      //mabda
      await placemarkFromCoordinates(geoPoint.first.latitude, geoPoint.first.longitude).then((List <Placemark> plist){
        setState(() {
          originAdress = " ${plist.first.thoroughfare} ${plist[2].name}";
        });
      });
    } catch(e){
      originAdress = "Server Error";
      disAdress = "Server Error";
    }

 }
}

