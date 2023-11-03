import 'package:flutter/material.dart';
import '../../main.dart';


class Medication extends StatelessWidget {
  const Medication({Key? key}) : super(key: key);

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

                  //타이틀
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    width: (MediaQuery.of(context).size.width),
                    child:
                    Text('약물치료란?',
                      style: TextStyle(fontSize: 37,
                          fontFamily: 'Inter', fontWeight: FontWeight.w900,
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
                    Text('약물치료 특성',
                      style: TextStyle(fontSize: 21,
                          fontFamily: 'Inter', fontWeight: FontWeight.w900,
                          color: Color(0xFF6A9AA5)
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),

                  //텍스트 + 이미지 + 텍스트
                  Container(
                      padding: EdgeInsets.only(left: 30, right:30,top: 15, bottom: 15),
                      margin: EdgeInsets.only(left:15, right: 15, bottom: 5, top: 40),

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
                            Text('공황 장애에 사용되는 약물에는 항우울제와 항불안제가.. 더보기\n',
                              style: TextStyle(fontSize: 16,
                                  fontFamily: 'Inter', fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                  ),
                ]
            )
        )
    );
  }
}