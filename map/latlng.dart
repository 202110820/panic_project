// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class Maptest extends StatefulWidget{
//
//   @override
//   State<Maptest> createState() => _MaptestState();
// }
//
// class _MaptestState extends State<Maptest> {
//   String? email; // email 저장할 변수
//   List<Map<String, dynamic>> latlngList = []; // 위도 경도 저장할 리스트
//
//   // 로그인된 사용자의 이메일을 가져오는 함수
//   Future<String> getEmail() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool isLogin = prefs.getBool('isLogin') ?? false;
//
//     if (isLogin) {
//       String? userEmail = prefs.getString('email'); // 'email' 키로 저장된 값을 불러옴
//       if (userEmail != null) {
//         setState(() {
//           email = userEmail;
//         });
//       } else {
//         null;
//         // 로그인이 되어 있지만 이메일 정보가 없는 경우의 처리
//         print('No documents found for the given email.');
//       }
//     }
//     else {
//       print('No documents found for the given email.');
//     }
//   }
//
//   Future<void> getLocations() async {
//     try {
//       await getEmail();
//       print('사용자 이메일: ${email}');
//
//       // Firebase에서 위치 데이터 가져오기
//       QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
//           .instance.collection('Mymap').where("email", isEqualTo: email).get();
//
//       if (snapshot.docs.isNotEmpty) {
//         // documents가 비어있지 않은 경우에만 처리
//         latlngList = snapshot.docs.map<Map<String, dynamic>>((
//             DocumentSnapshot<Map<String, dynamic>> document) {
//           // 'lat' 및 'lng' 필드의 존재 여부 확인 후 값 읽어오기
//           String address = document.data()!['address'] ?? '';
//           double lat = document.data()!['lat'] ?? 0.0;
//           double lng = document.data()!['lng'] ?? 0.0;
//           return {'address': address, 'lat': lat, 'lng': lng};
//         }).toList();
//
//         setState(() {
//           latlngList = latlngList;
//         });
//
//         print('위도 경도 리스트: ${latlngList}');
//       }
//     } catch (e) {
//       print('오류 발생: $e');
//     }
//   }
//
//
//   @override
//   void initState() {
//     super.initState();
//     getLocations();
//   }
// }