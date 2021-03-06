import 'dart:async';
import 'dart:convert';

import 'package:bexindia/Helper/PrefsHelper.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class LocateMe extends StatefulWidget {
  @override
  _LocateMeState createState() => _LocateMeState();
}

class _LocateMeState extends State<LocateMe> {
  Completer<GoogleMapController> _controller = Completer();
  static LatLng pinPosition = LatLng(37.3797536, -122.1017334);
  final CameraPosition _kGooglePlex = CameraPosition(
    target: pinPosition,
    zoom: 14.4746,
  );
  Set<Marker> _markers = new Set();
  bool tip = true, mark =false;
  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    reqPermission();


  }
  @override
  Widget build(BuildContext context) {
    myLocation();
    return Stack(
      children: <Widget>[
        GoogleMap(
          markers: _markers,
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: pinPosition,
            zoom: 14.4746,
          ),
          onMapCreated: (GoogleMapController controller) async {
            _controller.complete(controller);
            // print("on map created");


//            controller.animateCamera(
//              CameraUpdate.newCameraPosition(
//                CameraPosition(target: pinPosition, zoom: 14),
//              ),
//            );
          },
        ),
        tip ? Positioned(
          top: 20,
          left: 10,
          right: 10,
          child: SizedBox(
              height: 40,
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.yellow.withOpacity(0.4),
                    borderRadius: BorderRadius.all(Radius.circular(30)),

                  ),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Center(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.location_on,),
                          SizedBox(width: 5,),
                          Text("Press and Hold the marker to Drag",style: TextStyle(fontSize: 12),),
                          SizedBox(width: 20,),
                          InkWell(child: Icon(Icons.close,color: Colors.deepOrange,),onTap: (){tip = false;},)
                        ],
                      )))),
        ):Container(),

        Positioned(
          bottom: 10,
          left: 10,
          child: SizedBox(
            width: 100,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.grey,spreadRadius: 2,blurRadius: 6)]
                ),

                child : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                  ],
                )
            ),
          ),
        )
      ],
    );
  }

  Future<void> myLocation() async {
    if(!mark){

      Position position = await Geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      pinPosition = LatLng(position.latitude, position.longitude);}

    //print(position.latitude.toString());
    setState(() {
      mark=true;
      _markers.add(Marker(
          markerId: MarkerId("ID"),
          position: pinPosition,
          draggable: true,
          onDragEnd: ((value) {
            PrefsHelper.setLocation(jsonEncode({"latitude" : value.latitude,"longitude" :value.longitude}));

            print(value.latitude);
            print(value.longitude);
          })));

    });
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: pinPosition, zoom: 14),
      ),
    );

  }

  void reqPermission() async{
    LocationPermission permission = await Geolocator.requestPermission();
  }


}
