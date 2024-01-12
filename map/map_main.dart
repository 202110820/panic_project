import 'package:contact2/database_service.dart';
import 'package:flutter/material.dart';
import 'google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:contact2/main.dart';
// Your api key storage.
import 'keys.dart';
import 'package:contact2/map/my_location.dart';
import 'package:contact2/map/google_map_place_picker.dart';

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
    return WillPopScope(
      onWillPop: ()  {
        return Future(() => false); //뒤로가기 막음
      },
      child: Scaffold(
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
            children: [
              Container(
                height:(MediaQuery.of(context).size.height)*0.04,
              ),
              //큰 타이틀
              Container(
                padding: EdgeInsets.only(left: 20),
                width: (MediaQuery.of(context).size.width),
                child:
                Center(
                  child: Text('마이 맵',
                    style: TextStyle(fontSize: 37,
                        fontFamily: 'Inter', fontWeight: FontWeight.w800,
                        color: Colors.black
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              //세부 타이틀
              Container(
                padding: EdgeInsets.only(left: 23),
                width: (MediaQuery.of(context).size.width),
                child:
                Center(
                  child: Text('My Map',
                    style: TextStyle(fontSize: 25,
                        fontFamily: 'Inter', fontWeight: FontWeight.w600,
                        color: Color(0xFF6A9AA5)
                    ),
                  ),
                ),
              ),

              //이미지
              Container(
                //alignment: Alignment.bottomRight,
                  margin: EdgeInsets.only(top: 25),
                  child: Image.asset('assets/Map.png', width: 210,)
              ),

              //텍스트
              Container(
                  //padding: EdgeInsets.only(left: 10, right: 10,top: 15, bottom: 0),
                  //margin: EdgeInsets.only(left:15, right: 15, bottom: 0, top: 15),

                  child: Center(
                    child: Text('\n\n공황이 일어났던 위치를\n저장하고 알림을 받아보세요 !',
                      style: TextStyle(fontSize: 16,
                          fontFamily: 'Inter', fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  )
              ),


              //Start 버튼
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Ink(
                      width: (MediaQuery.of(context).size.width)*0.36,
                      height:  (MediaQuery.of(context).size.height)*0.1,

                      decoration: ShapeDecoration(
                          color:Color(0xFF62B6B6),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)
                          ),
                          shadows: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10,
                              offset: Offset(0, 0),
                              spreadRadius: 1,
                            )
                          ]
                      ),
                      child: InkWell(
                          borderRadius: BorderRadius.all(
                              Radius.circular(25)
                          ),
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return PlacePicker(
                                    apiKey: APIKeys.apiKey,
                                    initialPosition: HomePage.kInitialPosition,
                                    useCurrentLocation: true,
                                    selectInitialPosition: true,
                                    usePlaceDetailSearch: true,
                                    onPlacePicked: (result) {
                                      selectedPlace = result;
                                      // firebase에 업로드
                                      addMyMap(result.geometry!.location.lat, result.geometry!.location.lng, result.formattedAddress.toString(), widget.email);
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                              ),
                            );
                          },
                          child: Stack(
                              children: [
                                Center(
                                  child: Container(
                                    //margin: EdgeInsets.only(left: 15, top: 17),
                                    child: Text('지도보기',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ]
                          )
                      ),

                    ),
                    Ink(
                      width: (MediaQuery.of(context).size.width)*0.36,
                      height:  (MediaQuery.of(context).size.height)*0.1,

                      decoration: ShapeDecoration(
                          color:Color(0xFF62B6B6),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)
                          ),
                          shadows: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10,
                              offset: Offset(0, 0),
                              spreadRadius: 1,
                            )
                          ]
                      ),
                      child: InkWell(
                          borderRadius: BorderRadius.all(
                              Radius.circular(25)
                          ),
                          onTap: (){
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation1, animation2) => MyLocation(email: widget.email),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          },
                          child: Stack(
                              children: [
                                Center(
                                  child: Container(
                                    //margin: EdgeInsets.only(left: 15, top: 17),
                                    child: Text('내 장소',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ]
                          )
                      ),

                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
