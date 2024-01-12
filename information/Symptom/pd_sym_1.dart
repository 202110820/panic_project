import 'package:flutter/material.dart';
import 'pd_sym_2.dart';

class Pd_sym extends StatelessWidget {
  const Pd_sym({Key? key}) : super(key: key);

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
                //뒤로가기랑 텍스트 빈 공간
                Container(
                    height: 90
                ),

                //첫번째 텍스트
                Container(
                  padding: EdgeInsets.only(left: 20),
                  width: (MediaQuery.of(context).size.width),
                  child: Text('공황장애란?   ',
                    style: TextStyle(fontSize: 37,
                        fontFamily: 'Inter', fontWeight: FontWeight.w800
                    ),
                  ),
                ),

                //당황 사람 이미지
                Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.only(right: 65),
                    child: Image.asset('assets/pds_1.png', width: 40)
                ),

                //공황 사람 이미지
                Container(
                    child: Image.asset('assets/pdsym.png', width: 250,)
                ),

                //텍스트
                Container(
                    padding: EdgeInsets.only(left: 40, right: 40,top: 15, bottom: 15),
                    margin: EdgeInsets.only(left:15, right: 15, top: 20, bottom: 5),
                    child: Center(
                      child: Text('공황 장애(Panic disorder)란,\n 공황 발작(Panic attack)이\n반복적으로 발생하는 것을 말한다.',
                        style: TextStyle(fontSize: 17,
                            fontFamily: 'Inter', fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    )
                ),

                //Next 버튼
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
                                pageBuilder: (context, animation1, animation2) => Pd_sym_2(),
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
              ],
            )
        )
    );
  }
}
