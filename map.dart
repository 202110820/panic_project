import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'main.dart';
//import 'package:http/http.dart' as http;
//import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:location/location.dart' as locator;
import 'dart:math';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Completer<GoogleMapController> _controller = Completer();
  late Position position;
  late GoogleMapController _controller;

  @override
  void initState() {
    super.initState();
    _setInitialPostion();
  }

  final List<Marker> markers = [];
  addMarker(cordinate){
    int id = Random().nextInt(100);
    setState((){
      markers.add(Marker(position: cordinate, markerId: MarkerId(id.toString())));
    });
  }

  _setInitialPostion() async {
    position = await Geolocator.getCurrentPosition();
    setState(() {});
  }

  @override
  Widget build(BuildContext context){

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color(0xFFC3E9E4),
          elevation: 0.0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                iconSize: 30,
                color: Color.fromRGBO(151, 151, 151, 1),
                onPressed:() {
                  Navigator.of(context).pop();
                }),
          title: Text('My location', style: TextStyle(color: Colors.black),)
        ),
        body: SafeArea(
          child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      GoogleMap(
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(position.latitude, position.longitude),
                          zoom: 18
                        ),
                        onMapCreated: (controller){
                          setState(() {
                            _controller = controller;
                          });
                        },
                        markers: markers.toSet(),
                        onTap: (cordinate) {
                          _controller.animateCamera(CameraUpdate.newLatLng(cordinate));
                          addMarker(cordinate);
                        },
                      ),
                    ],
                  ),
                ),
              ),
        ),
      )
    );
  }
}