import 'package:flutter/material.dart';
import 'ad_2.dart';

class Ad_1 extends StatelessWidget {
  const Ad_1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
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
                  onPressed:() {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }),
            ),
            extendBodyBehindAppBar: true,
            body: Column(
                children: [
                  Container(
                    height: 90,
                  ),

                  //타이틀
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    width: (MediaQuery.of(context).size.width),
                    child:
                    Text('항우울제 치료',
                      style: TextStyle(fontSize: 37,
                          fontFamily: 'Inter', fontWeight: FontWeight.w800,
                          color: Colors.black
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),

                  //세부 타이틀
                  Container(
                    padding: EdgeInsets.only(left: 23),
                    width: (MediaQuery.of(context).size.width),
                    child:
                    Text('1. 항우울제 종류 알아보기',
                      style: TextStyle(fontSize: 21,
                          fontFamily: 'Inter', fontWeight: FontWeight.w800,
                          color: Color(0xFF6A9AA5)
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),

                  //텍스트
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text('항우울제의 종류는 다음과 같다.',
                      style: TextStyle(fontSize: 16,
                          fontFamily: 'Inter', fontWeight: FontWeight.w800,
                          color: Color(0xFF6A9AA5)
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  //삼환계
                  Container(
                      padding: EdgeInsets.only(left: 40, right: 40,top: 10, bottom: 10),
                      margin: EdgeInsets.only(left:15, right: 15, top: 15, bottom: 10),

                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 0.8,
                            color: Color(0xFF42727D)
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),

                      child: Center(
                        child: Text('삼환계 항우울제\n(Tricyclic Antidepressant, TCA)',
                          style: TextStyle(fontSize: 16,
                              fontFamily: 'Inter', fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      )
                  ),

                  //선택적
                  Container(
                      padding: EdgeInsets.only(left: 20, right: 20,top: 10, bottom: 10),
                      margin: EdgeInsets.only(left:15, right: 15, top: 5, bottom: 10),

                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 0.8,
                            color: Color(0xFF6A9AA5)
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),

                      child: Center(
                        child: Text('선택적 세로토닌 재흡수 억제제\n(Selective Serotonin Reuptake Inhibitors, SSRI)',
                          style: TextStyle(fontSize: 16,
                              fontFamily: 'Inter', fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      )
                  ),

                  //세로토닌
                  Container(
                      padding: EdgeInsets.only(left: 30, right: 30,top: 10, bottom: 10),
                      margin: EdgeInsets.only(left:15, right: 15, top: 5, bottom: 10),

                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 0.8,
                            color: Color(0xFF91B7BF)
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),

                      child: Center(
                        child: Text('세로토닌-노르에피네프린 재흡수 억제제\n(SNRI)',
                          style: TextStyle(fontSize: 16,
                              fontFamily: 'Inter', fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      )
                  ),

                  //모노아민
                  Container(
                      padding: EdgeInsets.only(left: 20, right: 20,top: 10, bottom: 10),
                      margin: EdgeInsets.only(left:15, right: 15, top: 5),

                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 0.8,
                            color: Color(0xFFB5D0D4)
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),

                      child: Center(
                        child: Text('모노아민 옥시다아제 억제제\n(Monoamine Oxidase Inhibitors, MAOI)',
                          style: TextStyle(fontSize: 16,
                              fontFamily: 'Inter', fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      )
                  ),

                  //텍스트
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text('등이 있다.',
                      style: TextStyle(fontSize: 16,
                          fontFamily: 'Inter', fontWeight: FontWeight.w800,
                          color: Color(0xFF6A9AA5)
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right:15, bottom: 40),
                      alignment: Alignment.bottomRight,
                      child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: ElevatedButton.icon(
                            onPressed: (){
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation1, animation2) => Ad_2(),
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.navigate_before,
                              color: Colors.white,
                              size: 30,
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF62B6B6),
                              fixedSize: const Size(95, 35),
                              padding: const EdgeInsets.fromLTRB(10,0,0,0),
                            ),
                            label: Text("Next     ",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white
                              ),
                            ),
                          )
                      ),
                    ),
                  )
                ]
            )
        )
    );
  }
}
