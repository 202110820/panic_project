import 'package:flutter/material.dart';
import 'pd_sym_3.dart';

class Pd_sym_2 extends StatelessWidget {
  const Pd_sym_2({Key? key}) : super(key: key);

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

                //큰 타이틀
                Container(
                  padding: EdgeInsets.only(left: 20),
                  width: (MediaQuery.of(context).size.width),
                  child:
                  Text('공황장애 증상',
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
                  Text('1. 공황 발작이란?',
                    style: TextStyle(fontSize: 21,
                        fontFamily: 'Inter', fontWeight: FontWeight.w800,
                        color: Color(0xFF6A9AA5)
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                //시계 이미지
                Container(
                    alignment: Alignment.bottomRight,
                    margin: EdgeInsets.only(right: 50),
                    child: Image.asset('assets/pds_2.png', width: 40)
                ),

                //공황 발작이란.. 텍스트
                Container(
                    padding: EdgeInsets.only(left: 30, right: 30,top: 10, bottom: 10),
                    margin: EdgeInsets.only(left:15, right: 15, bottom: 10),

                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.8,
                          color: Colors.grey
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),

                    child: Center(
                      child: Text('공황 발작(Panic attack)이란 어떤 외부의 위협이 없음에도 불구하고\n\n가슴 두근거림, 어지러움 등과 같은 다양한 신체 증상과 동반하여 심한 불안과 두려움을 느끼는 증상을 의미한다.',
                        style: TextStyle(fontSize: 16,
                            fontFamily: 'Inter', fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    )
                ),

                //공황 발작은.. 텍스트
                Container(
                    padding: EdgeInsets.only(left: 30, right:30 ,top: 10, bottom: 10),
                    margin: EdgeInsets.only(left:15, right: 15, top: 5, bottom: 5),

                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.8,
                          color: Colors.grey
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),

                    child: Center(
                      child: Text('공황 발작은 대게 짧은 시간 지속되며, 10분 이내에 증상이 최고조에 도달한다.\n\n증상은 일반적으로 20분~30분 이내에 소실되며, 1시간을 넘는 경우는 드물다.\n\n그러나, 발작이 한 번으로 끝나지 않고 수일 또는 수개월 뒤에 반복적으로 나타나는 경향이 있다.',
                        style: TextStyle(fontSize: 16,
                            fontFamily: 'Inter', fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,),
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
                                  MaterialPageRoute(builder: (_) => Pd_sym_3()),
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