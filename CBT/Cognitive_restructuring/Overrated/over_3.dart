import 'package:flutter/material.dart';
import 'over_4.dart';

class Over_3 extends StatelessWidget {
  const Over_3({Key? key}) : super(key: key);

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
                  padding: EdgeInsets.only(left: 18),
                  height: 70,
                  width: (MediaQuery.of(context).size.width),
                  child: Text('과대평가 예시 - 1',
                    style: TextStyle(fontSize: 37,
                        fontFamily: 'Inter', fontWeight: FontWeight.w800,
                        color: Color(0xFF6A9AA5)
                    ),
                  ),
                ),

                //이미지 + 텍스트
                Stack(
                  children:[
                    Container(
                      width: (MediaQuery.of(context).size.width),
                      // padding: EdgeInsets.all(0),
                      child: Image.asset('assets/o_3.png', height: 270,),
                      //color:Colors.red
                    ),

                    Center(
                      child: Text('\n\n\n\n회사동료들과 같이 지하철을 타고 가다가\n 동료들이 내가 매우 불안해하거나 공황을 겪는 걸\n알게 되면 어떡하지. 너무나 끔찍해.\n그러면 나는 회사를 다니지 못할거야.',
                        style: TextStyle(fontSize: 13,
                            fontFamily: 'Inter', fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),

                Container(
                  // width: (MediaQuery.of(context).size.width),
                  padding: EdgeInsets.all(0),
                  child: Image.asset('assets/o_4.png'),
                  alignment: Alignment.bottomLeft,
                  //color: Colors.red
                ),

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
                                    pageBuilder: (context, animation1, animation2) => Over_4(),
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