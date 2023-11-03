import 'package:flutter/material.dart';
import '../info.dart';
import '../main.dart';
import 'pd_cause_3.dart';

class Pd_cause_2 extends StatelessWidget {
  const Pd_cause_2({Key? key}) : super(key: key);

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
                  height: 100,
                ),

                //공황장애
                Container(
                  padding: EdgeInsets.only(left: 20),
                  width: (MediaQuery.of(context).size.width),
                  child:
                  Text('공황장애 원인',
                    style: TextStyle(fontSize: 37,
                        fontFamily: 'Inter', fontWeight: FontWeight.w900,
                        color: Colors.black
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                //얼마나 흔한 병
                Container(
                  padding: EdgeInsets.only(left: 23),
                  width: (MediaQuery.of(context).size.width),
                  child:
                  Text('2. 행동주의적 요인',
                    style: TextStyle(fontSize: 21,
                        fontFamily: 'Inter', fontWeight: FontWeight.w900,
                        color: Color(0xFF6A9AA5)
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                //이미지
                Container(
                    alignment: Alignment.bottomRight,
                    margin: EdgeInsets.only(right: 50),
                    child: Image.asset('assets/pdc_2.png', width: 50)
                ),

                //부모.. 텍스트
                Container(
                    padding: EdgeInsets.only(left: 24, right: 24,top: 15, bottom: 15),
                    margin: EdgeInsets.only(left:15, right: 15, bottom: 5),

                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.8,
                          color: Colors.grey
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),

                    child: Center(
                      child: Text('부모의 행동을 학습하거나, 전형적인 조건화 반응을 통해 나타날 수 있다.\n\n예를 들어, 사람이 붐비는 지하철 속에서 처음으로 공황발작을 경험한 사람의 경우, 그 다음부터는 지하철을 타면 이전에 겪었던 공황발작을 떠올리게 되어 쉽게 불안해진다.',
                        style: TextStyle(fontSize: 17,
                            fontFamily: 'Inter', fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    )
                ),

                //또한.. 텍스트
                Container(
                    padding: EdgeInsets.only(left: 22, right: 22,top: 15, bottom: 15),
                    margin: EdgeInsets.only(left:15, right: 15, top: 5, bottom: 5),

                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.8,
                          color: Colors.grey
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),

                    child: Center(
                      child: Text('또한, 사소한 신체감각의 변화에도 지극히 민감한 반응을 보이며 최악의 상황을 걱정한다.\n\n예를 들어, 불안으로 인한 심장 박동이 빨라지고 흉부 불편감이 있을 시, 이것을 심장마비 증상으로 오해하는 경우가 있다.',
                        style: TextStyle(fontSize: 17,
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
                                  MaterialPageRoute(builder: (_) => Pd_cause_3()),
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