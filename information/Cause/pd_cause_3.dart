import 'package:flutter/material.dart';

class Pd_cause_3 extends StatelessWidget {
  const Pd_cause_3({Key? key}) : super(key: key);

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
                  Text('공황장애 원인',
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
                  Text('3. 유전적 요인',
                    style: TextStyle(fontSize: 21,
                        fontFamily: 'Inter', fontWeight: FontWeight.w800,
                        color: Color(0xFF6A9AA5)
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                //텍스트 + 이미지 + 텍스트
                Container(
                    padding: EdgeInsets.only(left: 30, right:30,top: 15, bottom: 15),
                    margin: EdgeInsets.only(left:15, right: 15, bottom: 5, top: 30),

                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.8,
                          color: Colors.grey
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),

                    child: Center(
                      child: Column(
                        children: [
                          Text('공황장애의 유전적 원인론과 관련된 연구는 많지 않지만,유전적 요인이 영향을 줄 수 있다고 알려져 있다.\n',
                            style: TextStyle(fontSize: 16,
                                fontFamily: 'Inter', fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),

                          Container(
                              margin: EdgeInsets.only(top:10),
                              child: Image.asset('assets/pdc_3.png')
                          ),

                          Text('\n예를 들어, 공황장애 환자의 친척 중에서는 다른 질환을 가진 환자의 친척들에 비해\n\n공황장애 발생률이 4~8배 정도 더 높으며, 일반인구에 비하여 10배 정도 더 높은 것으로 알려져 있다.',
                            style: TextStyle(fontSize: 16,
                                fontFamily: 'Inter', fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                ),

                //Back
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
                ),
          ]
            )
        )
    );
  }
}