import 'package:flutter/material.dart';
{import 'package:main/screens/main_screen.dart';} // 메인 홈
 
// 공황장애 의심 O 결과 페이지
class YesScreen extends StatelessWidget {
  const YesScreen ({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios, size: 30, color: Color.fromRGBO(151, 151, 151, 1)), onPressed:() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => {IntroScreen()}, // 홈 화면으로
              ),
            );
          }),
        ),

        body: Center(
          child: Column(
            children: [
              SizedBox(height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.10,),
              Container(
                height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.10,
                child: Text("Panic Disorder Self Diagnosis\nComplete", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold,)),
              ),
              SizedBox(height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.05,),

              //결과 칸
              Container(
                height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.60,
                width: (MediaQuery.of(context).size.width),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 193, 235, 229),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      spreadRadius: 0,
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                  ]
                ),
                child: Column(children: [
                  SizedBox(height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.05,),
                  Container(
                    height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.10,
                    width: (MediaQuery.of(context).size.width - MediaQuery.of(context).padding.left) * 0.20,
                    child: Image.asset({'assets/Exclamation_Triangel.png'}), // 경고 png
                  ),
                  SizedBox(height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.05,),
                  Container(
                    height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.35,
                    width: (MediaQuery.of(context).size.width - MediaQuery.of(context).padding.left) * 0.80,
                    child: Text.rich(
                      TextSpan(children: [
                        TextSpan(text: "공황장애가", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold, shadows:[
                      Shadow(color: Colors.grey, offset: Offset(1,2), blurRadius: 7)],),),
                        TextSpan(text: " 의심되니 전문가의 상담", style: TextStyle(color: Color(0xFFF82834), fontSize: 19, fontWeight: FontWeight.bold, shadows:[
                      Shadow(color: Colors.grey, offset: Offset(1,2), blurRadius: 7)],),),
                        TextSpan(text: "을\n받아보시기 바랍니다.\n\n심각한 스트레스를 받은 직후이거나, 불편한 장소, 긴장의 상태에서 중증 정도 증상을 빈번하게 겪고 계신다면, 빠른 시일 내에 전문가를 찾아주시기 바랍니다.", 
                        style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold, shadows:[
                      Shadow(color: Colors.grey, offset: Offset(1,2), blurRadius: 7)],),)
                      ]),
                    ), 
                  )
                  
                ],)
                
              )
            ],
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
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios, size: 30, color: Color.fromRGBO(151, 151, 151, 1)), onPressed:() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => {IntroScreen()}, // 홈 화면으로 이동
              ),
            );
          }),
        ),

        body: Center(
          child: Column(
            children: [
              SizedBox(height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.10,),
              Container(
                height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.10,
                child: Text("Panic Disorder Self Diagnosis\nComplete", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold,)),
              ),
              SizedBox(height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.05,),

              // 결과 칸 
              Container(
                height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.60,
                width: (MediaQuery.of(context).size.width),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 193, 235, 229),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      spreadRadius: 0,
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                  ]
                ),
                child: Column(children: [
                  SizedBox(height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.05,),
                  Container(
                    height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.10,
                    width: (MediaQuery.of(context).size.width - MediaQuery.of(context).padding.left) * 0.20,
                    child: Image.asset({'assets/Happy_and_Smile.png'}), // 스마일 png 
                  ),
                  SizedBox(height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.05,),
                  Container(
                    height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.35,
                    width: (MediaQuery.of(context).size.width - MediaQuery.of(context).padding.left) * 0.80,
                    child: Text.rich(
                      TextSpan(children: [
                        TextSpan(text: "정상수치", style: TextStyle(color: Color(0xFF1463FC), fontSize: 20, fontWeight: FontWeight.bold, shadows:[
                      Shadow(color: Colors.grey, offset: Offset(1,2), blurRadius: 7)],),),
                        TextSpan(text: "에 해당합니다.\n\n만약 동일 증상이 반복된다면, 다른 원인에 의한 것은 아닌지 검진이 필요할 수도 있겠으나, 심리적인 요인이 크다고 느껴진다면, 상담 전문가와 상의해 보실 것을 권해드립니다.", 
                        style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold, shadows:[
                      Shadow(color: Colors.grey, offset: Offset(1,2), blurRadius: 7)],),),
                      ]),
                    ), 
                  )
                ],)
              )
            ],
          )
        )
      )
    );
  }
}
