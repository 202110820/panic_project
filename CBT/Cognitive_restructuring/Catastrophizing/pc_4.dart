import 'package:flutter/material.dart';
//import 'over_3.dart';

class Pc_4 extends StatelessWidget {
  const Pc_4({Key? key}) : super(key: key);

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
                //뒤로가기랑 텍스트 빈 공간
                Container(
                    height: 90
                ),

                //첫번째 텍스트
                Container(
                  padding: EdgeInsets.only(left: 18),
                  height: 70,
                  width: (MediaQuery.of(context).size.width),
                  child: Text('과대평가 예시 - 2',
                    style: TextStyle(fontSize: 37,
                        fontFamily: 'Inter', fontWeight: FontWeight.w800,
                        color: Color(0xFF6A9AA5)
                    ),
                  ),
                ),

                //이미지 + 텍스트
                Stack(
                    children: [
                      Container(
                        width: (MediaQuery.of(context).size.width),
                        padding: EdgeInsets.all(0),
                        child: Image.asset('assets/o_5.png', height: 270),
                        //color: Colors.red
                      ),

                      Center(
                        child: Text('\n\n\n지하철 안에서\n공황이 오면 어떻게 하지?\n\n만약 정신을 읽고 쓰러진다면\n너무 비참해질거야.',
                          style: TextStyle(fontSize: 13,
                              fontFamily: 'Inter', fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]
                ),

                //이미지
                Container(
                  // width: (MediaQuery.of(context).size.width),
                  padding: EdgeInsets.all(0),
                  child: Image.asset('assets/o_6.png'),
                  alignment: Alignment.bottomRight,
                  //color: Colors.red
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
