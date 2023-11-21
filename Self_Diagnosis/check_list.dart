import 'package:flutter/material.dart';
import 'package:main/screens/main_screen.dart'; //메인 페이지
import 'package:main/screens/SelfDiagnosis/check_result_screen.dart' as result; //자가진단 결과 페이지 

enum Answer { yes, no }

// 자가진단 체크 현황 리스트
class CheckList extends StatefulWidget {
  final Map<int, Answer?> answerVals; 
  final List<String> Quesets;

  const CheckList({required this.answerVals, required this.Quesets});

  @override
  _CheckListState createState() => _CheckListState();
}

class _CheckListState extends State<CheckList>{
  String removeNewlines(String input) {
    return input.replaceAll('\n', '');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white, useMaterial3: true,),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          //scrolledUnderElevation: 0,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios, size: 30, color: Color.fromRGBO(151, 151, 151, 1)), onPressed:() {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => IntroScreen(), // 메인 화면으로 이동
              ),
            );
          }),
        ),
        extendBodyBehindAppBar: true,
        body: Center(
          child: Column(children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.13,),

            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.15,
              child: Text("Self Diagnosis\nComplete !", 
              style: TextStyle(
                    fontSize: 27,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                ),textAlign: TextAlign.center)
            ),
          
            // 체크 현황 리스트
            Container(
              height: MediaQuery.of(context).size.height * 0.55,
              child: Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: widget.answerVals.length,
                  itemBuilder: (context, index){
                    final answer = widget.answerVals[index];
                    final isYes = (answer == Answer.yes);
                    return ListTile(
                      leading: isYes ? Icon(Icons.circle, color: Color.fromRGBO(98, 183, 183, 1), size: 30,) : Icon(Icons.circle_outlined, color: Colors.grey, size: 30,),
                      title: Text("나는 " + removeNewlines(widget.Quesets[index]),
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                      )),
                    );
                  },
                ),
              ),
            ),

            // 결과 확인 버튼
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(98, 183, 183, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    if(resultCount(widget.answerVals) >= 4){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const result.YesScreen())); //Yes 답변이 4개 이상이면, 공황장애 의심 페이지로 이동
                    } else{
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const result.NoScreen())); // 공황장애 미의심 페이지로 이동
                    }
                    
                  },
                  child: Text("Check the results", style: TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'Inter', fontWeight: FontWeight.w700),
                  ),
                ),
              )
            )
          ],)
        )
      )
    );
  }
  int resultCount(answerVal){
    int yesCount = 0;

    answerVal.forEach((key, value) {
      if (value == Answer.yes) {
        yesCount++;
      }
    });

    return yesCount;
  }
}
