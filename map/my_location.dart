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

List<String> locationList  = []; // 저장한 장소 리스트 선언

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
                      color: Color(0xFF62B6B6),
                    ),textAlign: TextAlign.center)
            ),

            // Map 리스트
            Expanded(
              child: Container(
                padding: EdgeInsets.zero,
                child: StreamBuilder<QuerySnapshot>(
                    stream: getMyMap(widget.email),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        // 저장된 장소가 하나도 없을 때
                        return Center(
                          child: Container(
                              //alignment: Alignment.bottomCenter,
                              //margin: EdgeInsets.only(bottom: 100),
                              child: Image.asset('assets/mylocation.png')
                          ),
                        );
                      }
                      //저장된 장소가 있을 때
                      else{
                        final documents = snapshot.data!.docs;
                        //locationList.clear(); //리스트 초기화
                        locationList = documents.map((DocumentSnapshot document){
                          // 각 문서에서 address 필드를 가져와 리스트에 추가
                          return document['address'].toString();
                        }).toList();

                        print('리스트: ${locationList}'); // 확인용
                        print('리스트 num: ${locationList.length}'); // 확인용

                        return Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: locationList.length,
                            itemBuilder: (context, index){
                              return Column(
                                children: [
                                  Dismissible(
                                    key: UniqueKey(), //Key(item[index]),
                                    child: ListTile(
                                      //leading: Icon(Icons.circle, color: Color.fromRGBO(98, 183, 183, 1), size: 30,),
                                      title: Text(
                                        '${locationList[index]}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          //fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    direction: DismissDirection.endToStart, // swipe 방향
                                    background: Container(
                                      color: Color(0xFF62B6B6),
                                      alignment: Alignment.centerRight,
                                      child: const Icon(
                                        Icons.delete,
                                        size: 36,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onDismissed: (direction) async{
                                      // 해당 삭제할 문서 찾아서
                                      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
                                          .collection('Mymap')
                                          .where('email', isEqualTo: widget.email)
                                          .where('address', isEqualTo: locationList[index])
                                          .get();

                                      // 제거
                                      querySnapshot.docs.forEach((doc) async {
                                        await doc.reference.delete();
                                      });
                                    },
                                    confirmDismiss: (direction) {
                                      return showDialog(
                                        context: context,
                                        builder: (ctx) {
                                          return AlertDialog(
                                            backgroundColor: Colors.white,
                                            title: const Text('Are you sure?',style: TextStyle(
                                                fontSize: 25,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xFF6A9AA5)
                                            ),textAlign: TextAlign.center,),
                                            content: Text("${locationList[index]}",style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            actions: <Widget>[
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(ctx).pop(false);
                                                    },
                                                    child: const Text('CANCEL',style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.white
                                                     ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    style: ElevatedButton.styleFrom(
                                                      primary: Color(0xFF62B6B6),
                                                      fixedSize: const Size(95, 35),
                                                      //padding: const EdgeInsets.fromLTRB(0,0,10,0),
                                                    ),
                                                  ),
                                              //Container(width: 35,),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(ctx).pop(true);
                                                },
                                                child: const Text('DELETE',style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  primary: Color(0xFF62B6B6),
                                                  fixedSize: const Size(95, 35),
                                                  //padding: const EdgeInsets.fromLTRB(0,0,10,0),
                                                ),
                                              ),
                                          ]
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  Div(),
                                ],
                              );
                            },
                          ),
                        );
                      }
                    }
                ),
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