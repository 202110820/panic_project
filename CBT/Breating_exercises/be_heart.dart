import 'package:flutter/material.dart';

class Be_heart extends StatelessWidget {
  const Be_heart({Key? key}) : super(key: key);

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
                    height: 130
                ),
                //첫번째 텍스트
                Container(
                  alignment: Alignment.center,
                  //padding: EdgeInsets.only(left: 18),
                  //height: 100,
                  width: (MediaQuery.of(context).size.width),
                  child: Text('Breath with\nthis heart',
                    style: TextStyle(fontSize: 37,
                        fontFamily: 'Inter', fontWeight: FontWeight.w600,
                        color: Color(0xFF6A9AA5)
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                //이미지
                Container(
                  margin: EdgeInsets.only(top: 100),
                  //width: (MediaQuery.of(context).size.width),
                  padding: EdgeInsets.all(0),
                  child: Image.asset('assets/bheart.png'),
                  //color: Colors.red
                ),

                // 텍스트
                Container(
                    padding: EdgeInsets.only(left: 20, right: 20,top: 15, bottom: 15),
                    margin: EdgeInsets.only(left:15, right: 15, top: 80, bottom: 10),

                    child: Center(
                      child: Text('Step 1~3에 따라 복식호흡 훈련을\n5~10분 정도 반복해보자.',
                        style: TextStyle(fontSize: 16,
                            fontFamily: 'Inter', fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    )
                ),

                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 60),
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                        onPressed: (){
                          Navigator.pop(
                            context,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF62B6B6),
                          fixedSize: const Size(95, 35),
                          padding: const EdgeInsets.fromLTRB(0,0,10,0),
                          minimumSize: Size(200, 50)
                        ),
                        child: Text("Restart",
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
              ]
            )
        )
    );
  }
}