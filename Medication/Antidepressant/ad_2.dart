import 'package:flutter/material.dart';
import 'ad_3.dart';

class Ad_2 extends StatelessWidget {
  const Ad_2({Key? key}) : super(key: key);

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
                    Row(
                      children: [
                        Column(
                          children: [
                            Text('항우울제 치료',
                              style: TextStyle(fontSize: 37,
                                  fontFamily: 'Inter', fontWeight: FontWeight.w800,
                                  color: Colors.black
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text('2. 항우울제 치료의 장점',
                              style: TextStyle(fontSize: 21,
                                  fontFamily: 'Inter', fontWeight: FontWeight.w800,
                                  color: Color(0xFF6A9AA5)
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 20, top:40),
                            child: Image.asset('assets/am_2.png'),)
                      ],
                    ),
                  ),

                  //장점 텍스트
                  Container(
                    margin: EdgeInsets.only(top: 60),
                    child: Text('항우울제의 장점 (Advantage)',
                      style: TextStyle(fontSize: 20,
                          fontFamily: 'Inter', fontWeight: FontWeight.w800,
                          color: Color(0xFF6A9AA5)
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  //박스
                  Container(
                      padding: EdgeInsets.only(left: 30, right:30,top: 15, bottom: 15),
                      margin: EdgeInsets.only(left:15, right: 15, bottom: 5, top: 25),

                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 0.8,
                            color: Colors.grey
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        //첫번째 줄
                        Container(
                          margin: EdgeInsets.only(top:10, bottom: 10),
                          child: Row(
                            children: [
                              Icon(Icons.circle, size: 25, color: Color(0xCC134F5C),),
                              Text('   치료효과가 비교적 오래 유지된다.',
                                style: TextStyle(fontSize: 16,
                                    fontFamily: 'Inter', fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),

                        //두번째 줄
                        Container(
                          margin: EdgeInsets.only(top:10, bottom: 10),
                          child: Row(
                            children: [
                              Icon(Icons.circle, size: 25, color:Color(0xCC45818E),),
                              Text('   공황발작의 예방효과가 있다.',
                                style: TextStyle(fontSize: 16,
                                    fontFamily: 'Inter', fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),

                        //세번째 줄
                        Container(
                          margin: EdgeInsets.only(top:10, bottom: 10),
                          child: Row(
                            children: [
                              Icon(Icons.circle, size: 25, color: Color(0xCC76A5AF),),
                              Text('   약물의 의존성 유발이 비교적 낮다.',
                                style: TextStyle(fontSize: 16,
                                    fontFamily: 'Inter', fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),

                        //네번쨰 줄
                        Container(
                          margin: EdgeInsets.only(top:10, bottom: 10),
                          child: Row(
                            children: [
                              Icon(Icons.circle, size: 25, color: Color(0xCCA2C4C9)),
                              Text('   졸릴 가능성이 낮다.',
                                style: TextStyle(fontSize: 16,
                                    fontFamily: 'Inter', fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
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
                                    MaterialPageRoute(builder: (_) => Ad_3()),
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
                ]
            )
        )
    );
  }
}