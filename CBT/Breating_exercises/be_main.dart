import 'package:contact2/CBT/Breating_exercises/be_step_1.dart';
import 'package:flutter/material.dart';
import 'be_heart.dart';

class Be_main extends StatelessWidget {
  const Be_main({Key? key}) : super(key: key);

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
              leading:
              IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  iconSize: 30,
                  color: Color.fromRGBO(151, 151, 151, 1),
                  onPressed:() {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }
              ),
            ),
            extendBodyBehindAppBar: true,
            body: Column(
              children: [
                Container(
                  height: 120,
                ),

                //큰 타이틀
                Container(
                  padding: EdgeInsets.only(left: 20),
                  width: (MediaQuery.of(context).size.width),
                  child:
                  Center(
                    child: Text('호흡 훈련',
                      style: TextStyle(fontSize: 37,
                          fontFamily: 'Inter', fontWeight: FontWeight.w800,
                          color: Colors.black
                      ),
                      //textAlign: TextAlign.center,
                    ),
                  ),
                ),

                //세부 타이틀
                Container(
                  padding: EdgeInsets.only(left: 23),
                  width: (MediaQuery.of(context).size.width),
                  child:
                  Center(
                    child: Text('Breathing Exercises',
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
                    child: Image.asset('assets/bemain.png', width: 175,)
                ),

                //텍스트
                Container(
                    padding: EdgeInsets.only(left: 10, right: 10,top: 15, bottom: 0),
                    margin: EdgeInsets.only(left:15, right: 15, bottom: 0, top: 15),

                    child: Center(
                      child: Text('호흡 훈련의 목적은 공황 중에 때때로 발생하는\n급성 과호흡 증상을 감소시키고,\n과호흡의 취약성을 감소시키며,\n자기 조절 기법을 개발하는 것이다.',
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
                      Container(
                        margin: EdgeInsets.only(bottom: 30),
                        alignment: Alignment.center,
                        child: InkWell(
                          borderRadius: BorderRadius.all(
                              Radius.circular(5)
                          ),
                          onTap: (){
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation1, animation2) => Be_step_1(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          },
                          child: Container(
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
                                      blurRadius: 3,
                                      offset: Offset(0, 0),
                                      spreadRadius: 1,
                                    )
                                  ]
                              ),

                              child: Stack(
                                  children: [
                                    Center(
                                      child: Container(
                                        //margin: EdgeInsets.only(left: 15, top: 17),
                                        child: Text('Guide',
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
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 30),
                        alignment: Alignment.center,
                        child: InkWell(
                          borderRadius: BorderRadius.all(
                              Radius.circular(5)
                          ),
                          onTap: (){
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation1, animation2) => AnimatedSizeScreen(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          },
                          child: Container(
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
                                      blurRadius: 3,
                                      offset: Offset(0, 0),
                                      spreadRadius: 1,
                                    )
                                  ]
                              ),

                              child: Stack(
                                  children: [
                                    Center(
                                      child: Container(
                                        //margin: EdgeInsets.only(left: 15, top: 17),
                                        child: Text('Start',
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
                      ),
                    ],
                  ),
                )
              ],
            )
        )
    );
  }
}
