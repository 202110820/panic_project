import 'package:flutter/material.dart';

import 'package:main/screens/model/model_auth.dart';

import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:main/database_service.dart';
import 'package:intl/intl.dart';

import 'package:main/screens/main_screen.dart';
import 'package:main/screens/Mypage/login_test.dart';
import 'package:main/screens/Mypage/EditProfile_screen.dart';

class Myprofile extends StatefulWidget{
  final String email;

  Myprofile({required this.email});

  @override 
  State<Myprofile> createState() => _MyprofileState();
}

String formatSelectedDay(Timestamp selectedDay) {
  Timestamp timestamp = selectedDay; // Firestore에서 Timestamp 필드 가져오기
  DateTime dateTime = timestamp.toDate(); // Timestamp를 DateTime으로 변환

  return DateFormat('yyyy/MM/dd').format(dateTime);
}

class _MyprofileState extends State<Myprofile> {

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white, useMaterial3: true,),
      home: Scaffold(
        resizeToAvoidBottomInset : false, //키보드 bottom overflow 방지
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios, size: 30, color: Color.fromRGBO(151, 151, 151, 1)), onPressed:() {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => IntroScreen(), //홈 화면으로 이동
              ),
            );
            //Navigator.of(context).popUntil((route) => route.isFirst); //홈 화면으로 이동
          }),
        ),
        extendBodyBehindAppBar: true,
        body: Center(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.10,),
              Title(),
              UserInformation(email: widget.email),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
              EditButton(email: widget.email),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
              LogoutButton(),
            ]
          )
        )
      )
    );
  }
}

// My Page
class Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.09,
      width: MediaQuery.of(context).size.width * 0.40,
      child: Text('My Page', style: TextStyle(
        color: Color.fromRGBO(106, 154, 165, 1),
        fontSize: 35,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
      ),textAlign: TextAlign.center,),
    );
  }
}

// 정보들
class UserInformation extends StatefulWidget{
  final String email;

  UserInformation({required this.email});

  @override 
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getMyPage(widget.email),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty){
          return CircularProgressIndicator(); 
        }

        // 개인 정보들 표시
        else{
          final documents = snapshot.data!.docs;
          final widgets = documents.map((DocumentSnapshot document) {
            String sex = document['sex'].toString().toLowerCase();
            return Column(
              children: [

                //사진 아이콘(편하게 남자/여자 로 나눴음..)
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width * 0.60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(255, 255, 255, 0.98), // 배경 색상
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey, // 그림자 색상
                        offset: Offset(0, 3), // 그림자의 위치 (수평, 수직)
                        blurRadius: 6, // 그림자의 흐릿한 정도
                        spreadRadius: 5, // 그림자의 확산 정도
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/MyPage/${sex}.png',
                      fit: BoxFit.none,
                    ),
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

                // 닉네임
                Container(
                  child: Text('${document['userID']}', textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 40, fontFamily: 'Inter', fontWeight: FontWeight.w800),),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.03,),

                //Profile
                Container(
                  color: Color.fromRGBO(246, 246, 246, 1),
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Text('Profile', textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w600,),),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

                Container(
                  child: Column(children: [

                    // 성별
                    Container(
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Text(
                            'Sex',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: Text(
                            '${document['sex']}',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],)
                    ),

                    // 생년월일
                    Container(
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Text(
                            'Date of birth',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: Text(
                            '${formatSelectedDay(document['birth_date'])}',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],)
                    ),

                    // 이메일
                    Container(
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Text(
                            'E-mail',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: Text(
                            '${document['email']}',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],)
                    ),
                  ],)
                )
              ]
            );
          }).toList();
          return Column(children: widgets,);
        }
      },
    );
  }
}

//Edit 버튼
class EditButton extends StatefulWidget{
  final String email;

  EditButton({required this.email});

  @override 
  State<EditButton> createState() => _EditButtonState();
}

class _EditButtonState extends State<EditButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromRGBO(98, 183, 183, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        maximumSize: Size(MediaQuery.of(context).size.width * 0.80, MediaQuery.of(context).size.height * 0.06),
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage(email: widget.email))); // 프로필 수정 페이지로 이동
      },
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Edit',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
            Image.asset('assets/MyPage/pencil.png'),
          ],
        ),
      ),
    );
  }
}

//로그아웃 버튼
class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authClient = Provider.of<UserAuthProvider>(context, listen: false);
    return TextButton(
      onPressed: () async {
        await authClient.logout();
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text('logout!')));
        Navigator.pushReplacement( //스택 제거 후 이동
          context,
          MaterialPageRoute(
            builder: (context) => Login(), // 로그인 화면으로 이동
          ),
        );
      },
      child: Text('LOGOUT', style: TextStyle(color: Colors.red, fontSize: 18, fontFamily: 'Inter', fontWeight: FontWeight.w400), textAlign: TextAlign.center,)
    );
  }
}

              