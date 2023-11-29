import 'package:contact2/database_service.dart';
import 'package:flutter/material.dart';
import 'google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:contact2/main.dart';
// Your api key storage.
import 'keys.dart';
import 'package:contact2/map/my_location.dart';


//void main() => runApp(MyMap());

class MyMap extends StatefulWidget{
  final String email;
  MyMap({required this.email});

  @override
  _MyMapState createState() => _MyMapState();
}
class _MyMapState extends State<MyMap> {

  // Light Theme
  final ThemeData lightTheme = ThemeData.light().copyWith(
    // Background color of the FloatingCard
    cardColor: Colors.white,
    buttonTheme: ButtonThemeData(
      // Select here's button color
      buttonColor: Colors.black,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  // Dark Theme
  final ThemeData darkTheme = ThemeData.dark().copyWith(
    // Background color of the FloatingCard
    cardColor: Colors.grey,
    buttonTheme: ButtonThemeData(
      // Select here's button color
      buttonColor: Colors.yellow,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Map Place Picker Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      home: HomePage(email: widget.email),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  final String email;
  HomePage({required this.email});

  static final kInitialPosition = LatLng(37.60282, 126.9552);
  @override
  _HomePageState createState() => _HomePageState();

}


class _HomePageState extends State<HomePage> {
  //late PickResult selectedPlace;
  PickResult? selectedPlace;
  //List<Location> locations = locationFromAddress[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios, size: 30, color: Color.fromRGBO(151, 151, 151, 1)), onPressed:() {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MyApp(), //메인 화면으로 이동
              ),
            );
          }),
        ),
        body: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 35,
            ),
            //큰 타이틀
            SizedBox(
              //padding: EdgeInsets.only(left: 20),
              width: (MediaQuery.of(context).size.width),
              child:
              Text('My Map',
                style: TextStyle(fontSize: 37,
                    fontFamily: 'Inter', fontWeight: FontWeight.w800,
                    color: Colors.black
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 15,),
            Container(
              width: (MediaQuery.of(context).size.width)*0.6,
              padding: EdgeInsets.zero,
              margin: EdgeInsets.only(top:10, bottom: 20),
              child: Image.asset('assets/Map.png',),
              //color: Colors.red
            ),
            SizedBox(height: 15,),
            //세부 타이틀
            SizedBox(
              //padding: EdgeInsets.only(left: 23),
              width: (MediaQuery.of(context).size.width),
              child:
              Center(
                child: Text('공황이 일어났던 위치를 저장하고\n알림을 받아보세요',
                  style: TextStyle(fontSize: 18,
                      fontFamily: 'Inter', fontWeight: FontWeight.w600,
                      color: Color(0xFF6A9AA5)
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 30,),
            ElevatedButton(
              child: Text("Load Google Map", style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Inter')),
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
                        initialPosition: HomePage.kInitialPosition,
                        useCurrentLocation: true,
                        selectInitialPosition: true,
                        usePlaceDetailSearch: true,
                        onPlacePicked: (result) {
                          selectedPlace = result;
                          print('-----------');
                          //print(result.adrAddress);
                          print(result.geometry!.location.lng);
                          print(result.geometry!.location.lat);

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
            SizedBox(height: 10,),

            ElevatedButton(
              child: Text("My Location", style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Inter')),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200,30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                backgroundColor: Color(0xFF62B6B6),
                padding: EdgeInsets.only(top: 10, bottom:10, right: 20, left: 20),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyLocation(email: widget.email)));
              },
            ),
            //selectedPlace == null
             //  ? Container()
               // : Text(selectedPlace!.formattedAddress ?? ""),
          ],
        ));
  }
}