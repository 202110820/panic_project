import 'package:flutter/material.dart';
import 'pd_2.dart';

class Panicdisorder extends StatelessWidget {
  const Panicdisorder({Key? key}) : super(key: key);

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
                Navigator.of(context).pop();
              }),
        ),
          extendBodyBehindAppBar: true,
        body: Column(
          children: [
            //뒤로가기랑 텍스트 빈 공간
            Container(
              height: (MediaQuery.of(context).size.height)*0.1,
            ),


            //첫번째 텍스트
            Container(
              padding: EdgeInsets.only(left: 20),
              height: (MediaQuery.of(context).size.height)*0.14,
              width: (MediaQuery.of(context).size.width),
              child: Row(
                children: [
                  Text('공황장애란?   ',
                    style: TextStyle(fontSize: 35,
                        fontFamily: 'Inter', fontWeight: FontWeight.w900
                        ),
                    textAlign: TextAlign.left,
                  ),
                  Container(
                    margin: EdgeInsets.only(top:40),
                      child: Image.asset('assets/pd1.png'))
                ],
              ),
            ),

            //두번째 텍스트
            Container(
                padding: EdgeInsets.only(left: 40, right: 40),
                height: (MediaQuery.of(context).size.height)*0.15,
                margin: EdgeInsets.only(left:10, right: 10, top: 30, bottom: 5),

                decoration: BoxDecoration(
                  border: Border.all(
                      width: 0.8,
                      color: Colors.grey
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),

              child: Center(
                child: Text(' 공황장애(Panic disorder)는 불안장애(Anxiety disorder) 종류의 하나로서 분류된다.',
                style: TextStyle(fontSize: 17,
                fontFamily: 'Inter', fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              )
            ),

            //세번째 텍스트
            Container(
                padding: EdgeInsets.only(left: 40, right: 40),
                height: (MediaQuery.of(context).size.height)*0.12,
                margin: EdgeInsets.only(left:10, right: 10, top: 5, bottom: 5),

              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.8,
                  color: Colors.grey
                ),
                borderRadius: BorderRadius.circular(30),
              ),

              child: Center(
                child: Text('공황장애는 공황발작(Panic attack)이 반복적으로 발생하는 것을 의미한다.',
                  style: TextStyle(fontSize: 17,
                      fontFamily: 'Inter', fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,),
              )
            ),

            //4번째 텍스트
            Container(
                padding: EdgeInsets.only(left: 40, right: 40),
                height: (MediaQuery.of(context).size.height)*0.27,
                margin: EdgeInsets.only(left:10, right: 10, top: 5, bottom: 5),

                decoration: BoxDecoration(
                  border: Border.all(
                      width: 0.8,
                      color: Colors.grey
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),

              child: Center(
                child: Text('공황발작은 강렬하고 극심한 공포가 갑자기 밀려오는 것을 말하며, \n\n심장이 빨리 뛰거나 가슴이 답답하고 호흡곤란 등의 신체증상이 동반되어 죽음에 이를 것 같은 공포를 느끼는 불안증상을 말한다.',
                  style: TextStyle(fontSize: 17,
                      fontFamily: 'Inter', fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,),
              )
            ),

            //Next 버튼
            Container(
              margin: EdgeInsets.only(right:10, top: 15),
              alignment: Alignment.bottomRight,
              child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: ElevatedButton.icon(
                    onPressed: () {},
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
            )
          ],
        )
      )
    );
  }
}