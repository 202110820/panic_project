import 'package:flutter/material.dart';

class Pd_sym_3 extends StatelessWidget {
  const Pd_sym_3({Key? key}) : super(key: key);

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
                    Text('2. 공황 발작의 여러가지 증상',
                      style: TextStyle(fontSize: 21,
                          fontFamily: 'Inter', fontWeight: FontWeight.w800,
                          color: Color(0xFF6A9AA5)
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),

                  //공황 발작 시.. 텍스트
                  Container(
                      padding: EdgeInsets.only(left: 13, right:13),
                      margin: EdgeInsets.only(left:15, right: 15, top: 40),

                      child: Center(
                        child: Text('※ 공황 발작 시에는 다음과 같은 증상 중 일부가 갑작스럽게 발생한다.\n',
                          style: TextStyle(fontSize: 16,
                              fontFamily: 'Inter', fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        )
                    ),
                  ),

                  //이미지
                  Container(
                      padding: EdgeInsets.only(left: 30, right:30,top: 20, bottom: 20),
                      margin: EdgeInsets.only(left:15, right: 15, bottom: 5),

                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 0.8,
                            color: Colors.grey
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                        child: Image.asset('assets/pds_3.png'),
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