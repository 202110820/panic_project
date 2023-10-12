import 'package:flutter/material.dart';
import 'package:main/screens/diagnosis_check.dart'; // 자가진단 페이지
{import 'package:main/screens/main_screen.dart';} // 메인홈


class SelfDiagnosis extends StatelessWidget {
  const SelfDiagnosis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFFC3E9E4)),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFC3E9E4),
          centerTitle: true,
          title: Text("Self Diagnosis", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700, shadows:[
                  Shadow(color: Colors.black, offset: Offset(1,2), blurRadius: 10)
                ],)),
          toolbarHeight: 100,
          elevation: 0,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios, size: 30, color: Color.fromRGBO(151, 151, 151, 1)), onPressed:() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => {IntroScreen()}, // 메인 홈 페이지로 이동
              ),
            );
          }),
        ),
        
        body: Center(
          child: Column(
            children: [
              SizedBox(height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.05,),
              Container(
                child: Container(
                  child: Image.asset({'assets/doctor.png'}), // 의사 사진 추가
                  height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.45,
                  width: (MediaQuery.of(context).size.width - MediaQuery.of(context).padding.left) * 0.75,
                ),
              ),
              SizedBox(height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.03,),
              Expanded(
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    SizedBox(height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.03,),
                    Container(
                      height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.10,
                      child: Text("Let's test\nIf You have Panic Disorder",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 27, color: Colors.black, fontWeight: FontWeight.bold)
                      ),
                    ),
                    SizedBox(height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.05,),
                    Container(
                      height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.05,
                      child: Text("Press the button when you're ready", textAlign: TextAlign.center, style: TextStyle(fontSize: 18, color: Colors.grey)),
                    ),
                    Container(
                      height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.12,
                      width: (MediaQuery.of(context).size.width - MediaQuery.of(context).padding.left) * 0.80,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(98, 183, 183, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PageDiagnosis())); // 자가 진단 페이지로 이동
                        },
                        child: Text("Start", style: TextStyle(fontSize: 25, shadows:[
                          Shadow(color: Colors.grey, offset: Offset(1,2), blurRadius: 5)],),
                        ),
                      ),
                    ),
                  ])
              ),),
            ])
        )
      )
    );
  }
}
