import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:contact2/Mypage/login_screen.dart';
import 'package:contact2/map/map_main.dart';

//로그인 여부 체크 화면
class LoginMapScreen extends StatefulWidget{

  @override
  _LoginMapScreenState createState (){
    return _LoginMapScreenState();
  }
}

class _LoginMapScreenState extends State<LoginMapScreen>{
  late SharedPreferences prefs;

  Future<bool> checkLogin() async {
    prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool('isLogin') ?? false;
    return isLogin;
  }

  void moveScreen() async {
    await checkLogin().then((isLogin){
      if(isLogin){
        String? userEmail = prefs.getString('email'); // 'email' 키로 저장된 값을 불러옴
        if (userEmail != null) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyMap(email: userEmail))); // 캘린더 이동
        } else { null;
        // 로그인이 되어 있지만 이메일 정보가 없는 경우의 처리
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login())); //로그인 창으로
        }
      }
      else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login())); //로그인 창으로
      }
    });
  }

  @override
  void initState(){
    super.initState();
    Timer(Duration(milliseconds: 1000), (){
      moveScreen();
    });
  }

  @override
  Widget build(BuildContext context){
    return const Scaffold(
      appBar: null,
      body: Center(child: CircularProgressIndicator(backgroundColor: Colors.black, color: Colors.white),),
    );
  }
}