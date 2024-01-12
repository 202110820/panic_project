import 'package:flutter/material.dart';
import 'pd_cause_2.dart';

class Pd_cause_1 extends StatelessWidget {
  const Pd_cause_1({Key? key}) : super(key: key);

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

                //공황장애
                Container(
                  padding: EdgeInsets.only(left: 20),
                  width: (MediaQuery.of(context).size.width),
                  child:
                  Text('공황장애 원인',
                    style: TextStyle(fontSize: 37,
                        fontFamily: 'Inter', fontWeight: FontWeight.w800,
                        color: Colors.black
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                //1.
                Container(
                  padding: EdgeInsets.only(left: 23),
                  width: (MediaQuery.of(context).size.width),
                  child:
                  Text('1. 정신분석적 요인',
                    style: TextStyle(fontSize: 21,
                        fontFamily: 'Inter', fontWeight: FontWeight.w800,
                        color: Color(0xFF6A9AA5)
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                //이미지
                Container(
                    alignment: Alignment.bottomRight,
                    margin: EdgeInsets.only(right: 50),
                    child: Image.asset('assets/pdc_1.png', width: 90,)
                ),

                //우리.. 텍스트
                Container(
                    padding: EdgeInsets.only(left: 40, right: 40,top: 10, bottom: 10),
                    margin: EdgeInsets.only(left:15, right: 15, bottom: 10),

                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.8,
                          color: Colors.grey
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),

                    child: Center(
                      child: Text('우리 마음속의 무의식적인 내용들이 의식적으로 터져 나오게 되는데 이럴 때 불안, 공황발작이 발생할 수 있다.',
                        style: TextStyle(fontSize: 16,
                            fontFamily: 'Inter', fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    )
                ),

                //어릴 때.. 텍스트
                Container(
                    padding: EdgeInsets.only(left: 40, right: 40,top: 10, bottom: 10),
                    margin: EdgeInsets.only(left:15, right: 15, top: 5, bottom: 10),

                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.8,
                          color: Colors.grey
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),

                    child: Center(
                      child: Text('어릴 때 겪었던 분리불안의 경험은 나중에 공황발작이 나타나는데 주요한 역할을 한다고 알려져있다.',
                        style: TextStyle(fontSize: 16,
                            fontFamily: 'Inter', fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,),
                    )
                ),

                //실제로.. 텍스트
                Container(
                    padding: EdgeInsets.only(left: 40, right: 40,top: 10, bottom: 10),
                    margin: EdgeInsets.only(left:15, right: 15, top: 5, bottom: 5),

                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.8,
                          color: Colors.grey
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),

                    child: Center(
                      child: Text('실제로 많은환자들이 공황발작이 처음으로 나타나기 전에 가까운 사람과 헤어지는 경험을 하거나 심각한 정신적 스트레스를 겪는 경우가 다수이다.',
                        style: TextStyle(fontSize: 16,
                            fontFamily: 'Inter', fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,),
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
                                pageBuilder: (context, animation1, animation2) => Pd_cause_2(),
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
