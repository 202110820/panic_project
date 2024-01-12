import 'package:flutter/material.dart';
import 'mr_step_2.dart';

class Mr_step_1 extends StatelessWidget {
  const Mr_step_1({Key? key}) : super(key: key);

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
                    height: 100
                ),
                //첫번째 텍스트
                Container(
                  alignment: Alignment.center,
                  //padding: EdgeInsets.only(left: 18),
                  //height: 100,
                  width: (MediaQuery.of(context).size.width),
                  child: Text('Step 1',
                    style: TextStyle(fontSize: 37,
                        fontFamily: 'Inter', fontWeight: FontWeight.w600,
                        color: Color(0xFF6A9AA5)
                    ),
                  ),
                ),

                //이미지
                Container(
                  margin: EdgeInsets.only(top:80),
                  child: Image.asset('assets/mstep1.png'),
                  //color: Colors.red
                ),

                // 텍스트
                Container(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                    margin: EdgeInsets.only(left:15, right: 15, top: 80,bottom: 10),

                    child: Center(
                      child: Text('주의의 방해를 받지않는 조용한 공간에서\n몸의 긴장을 빼고,\n\n편안하게 눕거나\n머리와 전신을 받쳐주는 의자에 앉습니다.',
                        style: TextStyle(fontSize: 16,
                            fontFamily: 'Inter', fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    )
                ),

                //Next 버튼
                //Back, Next 버튼
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //back
                      Container(
                        margin: EdgeInsets.only(left:15, bottom: 40),
                        alignment: Alignment.bottomLeft,
                        child: ElevatedButton.icon(
                            onPressed: (){
                              Navigator.pop(
                                context,
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
                              padding: const EdgeInsets.fromLTRB(0,0,10,0),
                            ),
                            label: Text("Back     ",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white
                              ),
                            )
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right:15, bottom: 40),
                        alignment: Alignment.bottomRight,
                        child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: ElevatedButton.icon(
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation1, animation2) => Mr_step_2(),
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
                    ],
                  ),
                )
              ],
            )
        )
    );
  }
}
