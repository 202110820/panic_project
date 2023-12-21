import 'package:flutter/material.dart';
import 'aa_2.dart';

class Aa_1 extends StatelessWidget {
  const Aa_1({Key? key}) : super(key: key);

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
                    Text('항불안제 치료',
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
                    Text('1. 항불안제 종류 알아보기',
                      style: TextStyle(fontSize: 21,
                          fontFamily: 'Inter', fontWeight: FontWeight.w800,
                          color: Color(0xFF6A9AA5)
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),

                  //텍스트
                  Container(
                    margin: EdgeInsets.only(top: 60),
                    child: Text('항불안제의 종류는 다음과 같다.',
                      style: TextStyle(fontSize: 16,
                          fontFamily: 'Inter', fontWeight: FontWeight.w800,
                          color: Color(0xFF6A9AA5)
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  //벤조디아
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
                        child: Text('벤조디아제핀\n(Benzodiazepines)\n계열의 항불안제 약물',
                          style: TextStyle(fontSize: 16,
                              fontFamily: 'Inter', fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      )
                  ),

                  //알프라
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
                        child: Text('알프라졸람\n(Alprazolam)',
                          style: TextStyle(fontSize: 16,
                              fontFamily: 'Inter', fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      )
                  ),

                  //클로나제팜
                  Container(
                      padding: EdgeInsets.only(left: 40, right: 40,top: 10, bottom: 10),
                      margin: EdgeInsets.only(left:15, right: 15, top: 5),

                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 0.8,
                            color: Color(0xFF91B7BF)
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),

                      child: Center(
                        child: Text('클로나제팜\n(Clonazepam)',
                          style: TextStyle(fontSize: 16,
                              fontFamily: 'Inter', fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      )
                  ),

                  //텍스트
                  Container(
                    margin: EdgeInsets.only(top: 15),
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
                                  pageBuilder: (context, animation1, animation2) => Aa_2(),
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
