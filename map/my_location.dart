import 'package:flutter/material.dart';
import 'package:contact2/main.dart';
import 'package:contact2/model/model_auth.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact2/database_service.dart';
import 'google_maps_place_picker.dart';
// Your api key storage.
import 'keys.dart';

class MyLocation extends StatefulWidget{
  final String email;

  MyLocation({required this.email});

  @override
  State<MyLocation> createState() => _MyLocationState();
}

Widget Div(){
  return const Divider(
    height: 1,
    thickness: 0.4,
    indent: 0,
    endIndent: 0,
    color: Color(0xFFC9C9C9),
  );
}

class _MyLocationState extends State<MyLocation> {
  PickResult? selectedPlace;

  //static final kInitialPosition = LatLng(37.60282, 126.9552);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white, useMaterial3: true,),
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0.0,
            leading: IconButton(icon: Icon(Icons.arrow_back_ios, size: 30,
                color: Color.fromRGBO(151, 151, 151, 1)), onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyApp(), //메인 화면으로 이동
                ),
              );
            }),
          ),
          extendBodyBehindAppBar: true,
          body: Column(children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.13,),
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Text("My Location",
                    style: TextStyle(
                      fontSize: 37,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),textAlign: TextAlign.center)
            ),

            // Map 리스트
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    padding: EdgeInsets.zero,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: getMyMap(widget.email),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                            return CircularProgressIndicator();
                          }
                          else{
                            final documents = snapshot.data!.docs;
                            final widgets = documents.map((DocumentSnapshot document){
                              //print('------------');
                              //print(documents);
                              return SingleChildScrollView(
                                  child: Column(children: [
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                    Text("${document['address']}", style: TextStyle(fontSize: 15),textAlign: TextAlign.center),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                    Div(),
                                  ],)
                              );
                            }).toList();
                            return Column(children: widgets,);
                          }
                        }
                    ),
                  ),
                ],
              ),
            ),

            // Load google map 버튼
            Container(
              margin: EdgeInsets.only(bottom: 30, top: 20),
              alignment: Alignment.center,
              child: ElevatedButton(
                child: Text("Load Google Map", style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Inter', ),textAlign: TextAlign.center,),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200,30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  backgroundColor: Color(0xFF62B6B6),
                  padding: EdgeInsets.only(top: 10, bottom:10, right: 20, left: 20),

                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PlacePicker(
                          apiKey: APIKeys.apiKey,
                          //'AIzaSyC2kycO-3FBE0dNBhVbDrdHa3XYMUV7EXI',
                          initialPosition: LatLng(37.60282, 126.9552),
                          useCurrentLocation: true,
                          selectInitialPosition: true,
                          usePlaceDetailSearch: true,
                          onPlacePicked: (result) {
                            selectedPlace = result;
                            //print('-----------');
                            //print(result.adrAddress);
                            //print(result.geometry!.location.lng);
                            //print(result.geometry!.location.lat);

                            // firebase에 업로드
                            addMyMap(result.geometry!.location.lat, result.geometry!.location.lng, result.formattedAddress.toString(), widget.email);
                            //print(result.formattedAddress);

                            //print(result.addressComponents);
                            // print(result.);
                            //print(result.initial);
                            //List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
                            Navigator.of(context).pop();
                            //setState(() {});
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            )
          ],)
      ),
    );
  }
}
