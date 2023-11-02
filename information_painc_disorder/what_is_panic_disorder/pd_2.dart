import 'package:flutter/material.dart';
import '../info.dart';
import 'pd_1.dart';
import '../main.dart';

class Pd_2 extends StatelessWidget {
  const Pd_2({Key? key}) : super(key: key);

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
                //뒤로가기랑 텍스트 빈 공간
                Container(
                  height: 100,
                ),

                //공황장애
                Container(
                  padding: EdgeInsets.only(left: 20),
                  width: (MediaQuery.of(context).size.width),
                  child:
                      Text('공황장애',
                        style: TextStyle(fontSize: 37,
                            fontFamily: 'Inter', fontWeight: FontWeight.w900,
                          color: Color(0xFF6A9AA5)
                        ),
                        textAlign: TextAlign.left,
                  ),
                ),

                //얼마나 흔한 병
                Container(
                  padding: EdgeInsets.only(left: 23),
                  width: (MediaQuery.of(context).size.width),
                  child:
                  Text('얼마나 흔한 병인가요?',
                    style: TextStyle(fontSize: 21,
                        fontFamily: 'Inter', fontWeight: FontWeight.w900,
                        color: Colors.black
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                //이미지
                Container(
                  margin: EdgeInsets.only(top:10),
                    child: Image.asset('assets/pd2.png')
                ),

                //1번째 텍스트
                Container(
                    padding: EdgeInsets.only(left: 40, right: 40,top: 15, bottom: 15),
                    margin: EdgeInsets.only(left:15, right: 15, top: 5, bottom: 5),

                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.8,
                          color: Colors.grey
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),

                    child: Center(
                      child: Text('전체 인구의 1.5~5%가 일생에 한번은 공황장애 진단을 받습니다.\n\n즉, 우리나라에만 약 70만명 정도의공황장애 환자가 있는 셈입니다.',
                        style: TextStyle(fontSize: 17,
                            fontFamily: 'Inter', fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,),
                    )
                ),

                //2번째 텍스트
                Container(
                    padding: EdgeInsets.only(left: 37, right: 37,top: 15, bottom: 15),
                    margin: EdgeInsets.only(left:15, right: 15, top: 5, bottom: 5),

                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.8,
                          color: Colors.grey
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),

                    child: Center(
                      child: Text('여성이 남성에 비해 2~3배 정도 발병률이 더 높으며 대개 20~30대 사이의 연령층에서 가장 흔히 발생합니다.',
                        style: TextStyle(fontSize: 17,
                            fontFamily: 'Inter', fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    )
                ),

                //back 버튼
                Expanded(
                  child: Container(
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
                )
              ],
            )
        )
    );
  }
}