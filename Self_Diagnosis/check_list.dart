import 'package:flutter/material.dart';
import 'package:main/screens/main_screen.dart';
import 'package:main/screens/SelfDiagnosis/check_result_screen.dart' as result; //자가진단 결과 페이지 

enum Answer { yes, no }

// 체크 리스트 위젯
class CheckList extends StatefulWidget {
  final Map<int, Answer?> answerVals; 
  final List<String> Quesets;
  //const CheckList({Key? key}) : super(key: key);

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
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          //scrolledUnderElevation: 0,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios, size: 30, color: Color.fromRGBO(151, 151, 151, 1)), onPressed:() {
            Navigator.pop(
              context,
              MaterialPageRoute(
                builder: (context) => IntroScreen(), // 홈 화면으로 이동
              ),
            );
          }),
        ),
        extendBodyBehindAppBar: true,
        body: Column(children: [   
            Container(height: 100,),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(0),
              //color:Colors.yellow,
              child: Text("Self Diagnosis\nComplete !", 
              style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                ),textAlign: TextAlign.center)
            ),
          
            // 체크 리스트
            ListView.builder(
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
            // Container(
            //   height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.65,
            //   width: double.infinity,
            //   child: ListView.builder(
            //     padding: EdgeInsets.zero,
            //     itemCount: widget.answerVals.length,
            //     itemBuilder: (context, index){
            //       print(widget.Quesets[0]);
            //       final answer = widget.answerVals[index];
            //       final isYes = (answer == Answer.yes);
            //       return ListTile(
            //         leading: isYes ? Icon(Icons.circle, color: Color.fromRGBO(98, 183, 183, 1), size: 30,) : Icon(Icons.circle_outlined, color: Colors.grey, size: 30,),
            //         title: Text("나는 " + removeNewlines(widget.Quesets[index]),
            //         style: TextStyle(
            //             fontSize: 11,
            //             fontFamily: 'Inter',
            //             fontWeight: FontWeight.w600,
            //             color: Colors.black,
            //         )),
            //       );
            //     },
            //   ),
            // ),
            

            //SizedBox(height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.04,),

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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => result.YesScreen()));
                    } else{
                      Navigator.push(context, MaterialPageRoute(builder: (context) => result.NoScreen()));
                    }
                    
                  },
                  child: Text("Check the results", style: TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'Inter', fontWeight: FontWeight.w700),
                  ),
                ),
              )
            )
            
          ],)
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