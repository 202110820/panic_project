import 'package:flutter/material.dart';
import '../main.dart';

// 공황장애 의심 O 결과 페이지
class YesScreen extends StatelessWidget {
  const YesScreen ({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white, useMaterial3: true,),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios, size: 30, color: Color.fromRGBO(151, 151, 151, 1)), onPressed:() {
                Navigator.of(context).popUntil((route) => route.isFirst);
              }),
        ),
        extendBodyBehindAppBar: true,
        body: Center(
          child: Column(
            children: [
              SizedBox(height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.20,),

              // 주의 사진
              Container(
                height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.30,
                width: (MediaQuery.of(context).size.width - MediaQuery.of(context).padding.left) * 0.45,
                child: Image.asset('assets/SelfDiagnosis/Exclamation_Triangle.png'),
              ),

              //결과 칸
              Container(
                height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.37,
                width: (MediaQuery.of(context).size.width - MediaQuery.of(context).padding.left) * 0.70,
                child: Text.rich(
                  TextSpan(children: [
                    TextSpan(text: "공황장애가\n", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Inter'),),
                    TextSpan(text: "의심되니 전문가의 상담", style: TextStyle(color: Color(0xFFF82834), fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Inter'),),
                    TextSpan(text: "을\n받아보시기 바랍니다.\n\n심각한 스트레스를 받은 직후이거나,\n불편한 장소, 긴장의 상태에서 중증\n정도 증상을 빈번하게 겪고 계신다면,\n\n빠른 시일 내에 전문가를\n찾아주시기 바랍니다.", 
                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Inter'),)
                  ]),textAlign: TextAlign.center
                ), 
              ),

              SizedBox(height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.05,),
              //Next 버튼
              Expanded(
                child: Column(children: [
                  Container(
                    alignment: Alignment.bottomRight,
                    child: Text('공황장애에 대해 더 알아보기      ', style: TextStyle(color: Color.fromRGBO(138, 138, 136, 1), fontSize: 14, fontFamily: 'Inter', fontWeight: FontWeight.w400))
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
                              MaterialPageRoute(
                                builder: (context) => IntroScreen(), // Pd_1() 공황장애 설명 페이지로 이동
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
                          label: Text("Click     ",
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                color: Colors.white
                            ),textAlign: TextAlign.center
                          ),
                        )
                    ),
                  ),
                ],)
                
              )
            ]
          )
        )
      )
    );
  }
}

// 공황장애 의심 X 결과 페이지
class NoScreen extends StatelessWidget {
  const NoScreen ({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white, useMaterial3: true,),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios, size: 30, color: Color.fromRGBO(151, 151, 151, 1)), onPressed:() {
                Navigator.of(context).popUntil((route) => route.isFirst);
              }),
        ),

        body: Center(
          child: Column(
            children: [
              SizedBox(height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.10,),

              // 스마일 사진
              Container(
                height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.25,
                width: (MediaQuery.of(context).size.width - MediaQuery.of(context).padding.left) * 0.45,
                child: Image.asset('assets/SelfDiagnosis/Happy_and_Smile.png'),
              ),

              SizedBox(height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.05,),

              //결과 칸
              Container(
                height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.35,
                width: (MediaQuery.of(context).size.width - MediaQuery.of(context).padding.left) * 0.70,
                child: Text.rich(
                  TextSpan(children: [
                    TextSpan(text: "정상수치", style: TextStyle(color: Color(0xFF1463FC), fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter'),),
                    TextSpan(text: "에 해당합니다.\n\n만약 동일 증상이 반복된다면,\n다른 원인에 의한 것은 아닌지 검진이 필요할 수도 있겠으나,\n\n심리적인 요인이 크다고 느껴진다면,\n상담 전문가와 상의해 보실 것을\n권해드립니다.", 
                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter'),),
                  ]),textAlign: TextAlign.center,
                ), 
              ),

              SizedBox(height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.05,),
              //Next 버튼
              Expanded(
                child: Column(children: [
                  Container(
                    alignment: Alignment.bottomRight,
                    child: Text('공황장애에 대해 더 알아보기      ', style: TextStyle(color: Color.fromRGBO(138, 138, 136, 1), fontSize: 14, fontFamily: 'Inter', fontWeight: FontWeight.w400))
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
                              MaterialPageRoute(
                                builder: (context) => IntroScreen(), // Pd_1() 공황장애 설명 페이지로 이동
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
                          label: Text("Click     ",
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
                ],)
                
              )
            ]
          )
        )
      )
    );
  }
}
