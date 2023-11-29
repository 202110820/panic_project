import 'package:contact2/CBT/Muscle_relaxation/mr_link.dart';
import 'package:flutter/material.dart';
import 'mr_step_1.dart';
import 'mr_link.dart';

class Mr_main extends StatelessWidget {
  const Mr_main({Key? key}) : super(key: key);

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
              leading:
              IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  iconSize: 30,
                  color: Color.fromRGBO(151, 151, 151, 1),
                  onPressed:() {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }
              ),
              actions: [
                IconButton(
                    icon: Icon(Icons.question_mark),
                    iconSize: 30,
                    color: Color.fromRGBO(151, 151, 151, 1),
                    onPressed:() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => Mr_step_1()),
                      );
                    }
                ),
              ],
            ),
            extendBodyBehindAppBar: true,
            body: Column(
              children: [
                Container(
                  height: 120,
                ),

                //큰 타이틀
                Container(
                  padding: EdgeInsets.only(left: 20),
                  width: (MediaQuery.of(context).size.width),
                  child:
                  Center(
                    child: Text('이완 훈련',
                      style: TextStyle(fontSize: 37,
                          fontFamily: 'Inter', fontWeight: FontWeight.w800,
                          color: Colors.black
                      ),
                      //textAlign: TextAlign.center,
                    ),
                  ),
                ),

                //세부 타이틀
                Container(
                  padding: EdgeInsets.only(left: 23),
                  width: (MediaQuery.of(context).size.width),
                  child:
                  Center(
                    child: Text('Muscle relaxation',
                      style: TextStyle(fontSize: 25,
                          fontFamily: 'Inter', fontWeight: FontWeight.w600,
                          color: Color(0xFF6A9AA5)
                      ),
                    ),
                  ),
                ),

                //이미지
                Container(
                  //alignment: Alignment.bottomRight,
                    margin: EdgeInsets.only(top: 25),
                    child: Image.asset('assets/mrmain.png')
                ),

                //텍스트
                Container(
                    padding: EdgeInsets.only(left: 20, right: 20,top: 15, bottom: 15),
                    margin: EdgeInsets.only(left:15, right: 15, bottom: 10, top: 20),

                    child: Center(
                      child: Text('점진적 이완법은 몸의 각 근육들을\n7~10초간 긴장시킨 후\n20초 가량 풀고 이완하는 방법이다.',
                        style: TextStyle(fontSize: 16,
                            fontFamily: 'Inter', fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    )
                ),


                //Start 버튼
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 60),
                    alignment: Alignment.center,
                    child: InkWell(
                      borderRadius: BorderRadius.all(
                          Radius.circular(5)
                      ),
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => Mr_link()),
                        );
                      },
                      child: Container(
                          width: (MediaQuery.of(context).size.width)*0.8,
                          height:  (MediaQuery.of(context).size.height)*0.1,

                          decoration: ShapeDecoration(
                              color:Color(0xFF62B6B6),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)
                              ),
                              shadows: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5,
                                  offset: Offset(0, 0),
                                  spreadRadius: 1,
                                )
                              ]
                          ),

                          child: Stack(
                              children: [
                                Center(
                                  child: Container(
                                    //margin: EdgeInsets.only(left: 15, top: 17),
                                    child: Text('Start',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ]
                          )
                      ),
                    ),
                  ),
                )
              ],
            )
        )
    );
  }
}