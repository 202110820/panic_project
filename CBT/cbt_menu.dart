import 'package:flutter/material.dart';
import 'Cognitive_restructuring/Overrated/over_1.dart';
import 'Cognitive_restructuring/Catastrophizing/pc_1.dart';

class Cbt_menu extends StatelessWidget {
  const Cbt_menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  iconSize: 30,
                  color: Color.fromRGBO(151, 151, 151, 1),
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }),
            ),
            extendBodyBehindAppBar: true,
            body: Column(
              children: [
                //뒤로가기랑 텍스트 빈 공간
                Container(
                    height: 90
                ),

                //첫번째 텍스트
                Container(
                  padding: EdgeInsets.only(left: 18),
                  height: 100,
                  width: (MediaQuery.of(context).size.width),
                  child: Text('인지 재구성 훈련',
                    style: TextStyle(fontSize: 37,
                        fontFamily: 'Inter', fontWeight: FontWeight.w800
                    ),
                  ),
                ),

                //과대평가 다루기 텍스트
                Container(
                  padding: EdgeInsets.only(left: 30, bottom:10),
                  alignment: Alignment.centerLeft,
                  child: Text('과대평가 다루기',
                    style: TextStyle(fontSize: 16,
                        fontFamily: 'Inter', fontWeight: FontWeight.w800,
                        color: Color(0xFF6A9AA5)
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),

                //첫줄 버튼
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //과대평가란? 버튼
                    InkWell(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5)
                      ),
                      onTap: (){
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => Over_1()),
                          );
                        }
                      },
                      child: Container(
                        width: (MediaQuery.of(context).size.width)*0.4,
                        height:  (MediaQuery.of(context).size.height)*0.135,

                        decoration: ShapeDecoration(
                            color:Color(0xFFD9E6E9),
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

                        child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 15, top: 17),
                              child: Text('과대평가란?',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 80, top: 45),
                              child: Image(image: AssetImage('assets/cbt_1.png'),
                                  width: 70),
                            )
                          ]
                        )
                      ),
                    ),
                    //과대평가 극복 Tip 버튼
                    InkWell(
                      borderRadius: BorderRadius.all(
                          Radius.circular(5)
                      ),
                      onTap: (){

                      },
                      child: Container(
                        //padding: EdgeInsets.only(left:30),
                        // margin: EdgeInsets.only(top: 10),
                        width: (MediaQuery.of(context).size.width)*0.4,
                        height:  (MediaQuery.of(context).size.height)*0.135,

                        decoration: ShapeDecoration(
                            color:Color(0xFFD9E6E9),
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

                          child: Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 15, top: 17),
                                  child: Text('과대평가\n극복 Tip',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 80, top: 45),
                                  child: Image(image: AssetImage('assets/cbt_2.png'),
                                      width: 70),
                                )
                              ]
                          )
                      ),
                    ),
                  ],
                ),

                //재앙화 사고 다루기 텍스트
                Container(
                  padding: EdgeInsets.only(top: 30, left: 30, bottom:10),
                  alignment: Alignment.centerLeft,
                  child: Text('재앙화 사고 다루기',
                    style: TextStyle(fontSize: 16,
                        fontFamily: 'Inter', fontWeight: FontWeight.w800,
                        color: Color(0xFF6A9AA5)
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),

                //2번째 줄 버튼
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //재앙화 사고란? 버튼
                    InkWell(
                      borderRadius: BorderRadius.all(
                          Radius.circular(5)
                      ),
                      onTap: (){
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => Pc_1()),
                          );
                        }
                      },
                      child: Container(
                          width: (MediaQuery.of(context).size.width)*0.4,
                          height:  (MediaQuery.of(context).size.height)*0.13,

                          decoration: ShapeDecoration(
                              color:Color(0xFFB5D0D4),
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

                          child: Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 15, top: 17),
                                  child: Text('재앙화\n사고란?',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 80, top: 45),
                                  child: Image(image: AssetImage('assets/cbt_3.png'),
                                      width: 70),
                                )
                              ]
                          )
                      ),

                    ),
                    //재앙화 사고 극복 Tip 버튼
                    InkWell(
                      borderRadius: BorderRadius.all(
                          Radius.circular(5)
                      ),
                      onTap: (){},
                      child: Container(
                        //padding: EdgeInsets.only(left:30),
                        // margin: EdgeInsets.only(top: 10),
                          width: (MediaQuery.of(context).size.width)*0.4,
                          height:  (MediaQuery.of(context).size.height)*0.135,

                          decoration: ShapeDecoration(
                              color:Color(0xFFB5D0D4),
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

                          child: Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 15, top: 17),
                                  child: Text('재앙화 사고\n극복 Tip',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 80, top: 45),
                                  child: Image(image: AssetImage('assets/cbt_2.png'),
                                      width: 70),
                                )
                              ]
                          )
                      ),
                    ),
                  ],
                ),

                //역기능적 사고 기록기 텍스트
                Container(
                  padding: EdgeInsets.only(top: 30, left: 30, bottom:10),
                  alignment: Alignment.centerLeft,
                  child: Text('역기능적 사고 기록기',
                    style: TextStyle(fontSize: 16,
                        fontFamily: 'Inter', fontWeight: FontWeight.w800,
                        color: Color(0xFF6A9AA5)
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),

                //3번째 줄 버튼
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //역기능 버튼
                    InkWell(
                      borderRadius: BorderRadius.all(
                          Radius.circular(5)
                      ),
                      onTap: (){},
                      child: Container(
                          width: (MediaQuery.of(context).size.width)*0.4,
                          height:  (MediaQuery.of(context).size.height)*0.135,

                          decoration: ShapeDecoration(
                              color:Color(0xFF91B7BF),
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

                          child: Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 15, top: 17),
                                  child: Text('역기능적 사고\n기록기',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 80, top: 45),
                                  child: Image(image: AssetImage('assets/cbt_4.png'),
                                      width: 70),
                                )
                              ]
                          )
                      ),
                    ),
                    //재앙화 사고 극복 Tip 버튼
                    Container(
                          width: (MediaQuery.of(context).size.width)*0.4,
                          height:  (MediaQuery.of(context).size.height)*0.135,
                          color: Colors.transparent,
                      ),
                  ],
                ),
              ],
            )
        )
    );
  }
}