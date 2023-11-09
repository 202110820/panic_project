import 'package:flutter/material.dart';
import '../main.dart';
import 'check_result_screen.dart' as result; // 자가진단 결과 페이지

enum Answer { yes, no }

class PageDiagnosis extends StatefulWidget{
  const PageDiagnosis({Key? key}) : super(key: key);

  @override
  _PageDiagnosisState createState() => _PageDiagnosisState();
}

class _PageDiagnosisState extends State<PageDiagnosis> {
  //PageController _pageController = PageController(initialPage: 0);
  int currentPage = 1;
  int totalPages = 13;

  // 답변 저장할 딕셔너리 변수
  Map<int, Answer?> answerVal = {};


  bool isYesPressed = false; // Yes 버튼 상태
  bool isNoPressed = false;  // No 버튼 상태
  // 체크박스 초기화
  IconData Yescheckbox = Icons.circle_outlined;
  IconData Nocheckbox = Icons.circle_outlined;
  Color YescheckColor = Colors.grey;
  Color NocheckColor = Colors.grey;

  // 진단 질문 리스트
  List<String> Queset = ["맥박이 빨라지거나 심장 박동이 심하게 느껴진다.", "현기증을 느끼거나 머리가 띵하다.", "땀이 많이 난다.", "떨리고 전율감이 느껴진다.",
  "오한이 나거나 얼굴이 화끈 달아오른다.", "질식할 것 같다.", "토할 것 같거나 복부 불편감이 있다.", "가슴이 답답하거나 통증을 느낀다.", "자제력을 잃게 되거나 미쳐버릴까봐 두렵다.",
  "죽을 것 같아 두렵다.", "A feeling that you are\ncrazy or losing control?", "비현실감이나 내가 아닌 다른 사람이 된 것 같은 느낌이 든다.", "숨이 가빠지거나 숨이 막히는 것 같은 느낌이 든다."];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFFC3E9E4)),
      home: Scaffold(
        appBar: AppBar(
          title: RichText(
          text: TextSpan(
            //style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                text: "$currentPage",
                style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold,),
              ),
              TextSpan(
                text: " of $totalPages",
                style: TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold,),
              ),
            ],
          ),
        ),
        backgroundColor: Color(0xFFC3E9E4),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios, size: 30, color: Color.fromRGBO(151, 151, 151, 1)),
            onPressed:() {
              Navigator.of(context).popUntil((route) => route.isFirst);
              //Navigator.pop(context);
            }),
        ),

        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.08,),
              Container(child: Row(children: [
                SizedBox(width: (MediaQuery.of(context).size.width -  MediaQuery.of(context).padding.left) * 0.65,),
                Container(
                  height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.15,
                  width: (MediaQuery.of(context).size.width -  MediaQuery.of(context).padding.left) * 0.35,
                  child:Image(image: AssetImage('assets/icon_Exam_Multiple_Choice.png'))// 사진 첨부(노트 사진?)
                ),
              ],)),
              SizedBox(height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.01,),

              // 질문 컨테이너
              Container(
                height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.15,
                width: (MediaQuery.of(context).size.width -  MediaQuery.of(context).padding.left) * 0.90,
                child: Text(Queset[currentPage-1], style: TextStyle(fontSize: 27, color: Colors.black, fontWeight: FontWeight.bold),)
              ),

              // 선택 부분
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(children: <Widget>[

                    SizedBox(height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.07,),
                    // Yes 버튼
                    Container(
                      height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.12,
                      width: (MediaQuery.of(context).size.width -  MediaQuery.of(context).padding.left) * 0.90,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                          foregroundColor: MaterialStateProperty.all(Colors.black,),
                          shadowColor: MaterialStateProperty.all(Colors.grey,),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                          ),
                          side: MaterialStateProperty.all(
                            isYesPressed ? BorderSide(color: Color.fromRGBO(98, 183, 183, 1), width: 2.5) : BorderSide(color: Colors.grey, width: 2.5),
                          ),
                        ),
                        onPressed: () {
                          setYesPressed(true);
                          setNoPressed(false); // No 버튼을 눌렀을 때 상태 변경
                          answerVal[currentPage-1] = Answer.yes;
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Text("Yes.", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
                          SizedBox(width: (MediaQuery.of(context).size.width -  MediaQuery.of(context).padding.left) * 0.40),
                          Icon(Yescheckbox, color: YescheckColor, size: 50),
                        ],)

                      )
                    ),

                    SizedBox(height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.07,),
                    // No 버튼
                    Container(
                      height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.12,
                      width: (MediaQuery.of(context).size.width -  MediaQuery.of(context).padding.left) * 0.90,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                          foregroundColor: MaterialStateProperty.all(Colors.black,),
                          shadowColor: MaterialStateProperty.all(Colors.grey,),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                          ),
                          side: MaterialStateProperty.all(
                            isNoPressed ? BorderSide(color: Color.fromRGBO(98, 183, 183, 1), width: 2.5) : BorderSide(color: Colors.grey, width: 2.5),
                          ),
                        ),
                        onPressed: () {
                          setYesPressed(false);
                          setNoPressed(true); // No 버튼을 눌렀을 때 상태 변경
                          answerVal[currentPage-1] = Answer.no;
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Text("No.", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
                          SizedBox(width: (MediaQuery.of(context).size.width -  MediaQuery.of(context).padding.left) * 0.42),
                          Icon(Nocheckbox, color: NocheckColor, size: 50),
                        ],)
                      )
                    ),

                    SizedBox(height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.09,),

                    Container(
                      child: Row(children: [
                        SizedBox(width: (MediaQuery.of(context).size.width - MediaQuery.of(context).padding.left) * 0.03,),

                        // Back 버튼
                        Container(
                          height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.09,
                          width: (MediaQuery.of(context).size.width -  MediaQuery.of(context).padding.left) * 0.35,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(98, 183, 183, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              if(currentPage != 1){
                                setState((){
                                  currentPage--;
                                  isYesPressed = false;
                                  isNoPressed = false;
                                  Yescheckbox = Icons.circle_outlined;
                                  Nocheckbox = Icons.circle_outlined;
                                  YescheckColor = Colors.grey;
                                  NocheckColor = Colors.grey;
                                });
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(image: AssetImage('assets/icon_chevron_circle_left.png')), // 왼쪽 화살표 png
                                SizedBox(width: (MediaQuery.of(context).size.width - MediaQuery.of(context).padding.left) * 0.02,),
                                Text(
                                  "Back",
                                  style: TextStyle(
                                    fontSize: 25, shadows:[
                                    Shadow(color: Colors.grey, offset: Offset(1,2), blurRadius: 7)],
                                  )
                                ),
                            ],)

                          ),
                        ),
                        SizedBox(width: (MediaQuery.of(context).size.width - MediaQuery.of(context).padding.left) * 0.24,),

                        // Next 버튼
                        Container(
                          height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.09,
                          width: (MediaQuery.of(context).size.width -  MediaQuery.of(context).padding.left) * 0.35,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(98, 183, 183, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              if(isYesPressed || isNoPressed){
                                setState((){
                                  if (currentPage <= totalPages - 1){
                                    currentPage++;
                                    isYesPressed = false;
                                    isNoPressed = false;
                                    Yescheckbox = Icons.circle_outlined;
                                    Nocheckbox = Icons.circle_outlined;
                                    YescheckColor = Colors.grey;
                                    NocheckColor = Colors.grey;
                                  } else{ // 마지막 페이지인 경우
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CheckList(answerVals: answerVal, Quesets: Queset), // 전체 체크 리스트 확인 창으로 이동
                                      ),
                                    );
                                  }
                                });
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Next",
                                  style: TextStyle(
                                    fontSize: 25, shadows:[
                                    Shadow(color: Colors.grey, offset: Offset(1,2), blurRadius: 7)],
                                  )
                                ),
                                SizedBox(width: (MediaQuery.of(context).size.width - MediaQuery.of(context).padding.left) * 0.02,),
                                Image(image: AssetImage('assets/icon_chevron_circle_right.png')) // 오른쪽 화살표 png
                            ],)
                          ),
                        ),
                        SizedBox(width: (MediaQuery.of(context).size.width - MediaQuery.of(context).padding.left) * 0.03,),
                      ],)
                    ),
                  ],)
                )
              )
            ],
          ),
        ),
      ),
    );
  }
  // Yes 버튼 눌렀을 때 상태 변경
  void setYesPressed(bool value) {
    setState(() {
      isYesPressed = value;
      if(value == true){
        Yescheckbox = Icons.check_circle;
        YescheckColor = Color.fromRGBO(98, 183, 183, 1);
        Nocheckbox = Icons.circle_outlined;
        NocheckColor = Colors.grey;
      }
    });
  }

  // No 버튼 눌렀을 때 상태 변경
  void setNoPressed(bool value) {
    setState(() {
      isNoPressed = value;
      if(value == true){
        Nocheckbox = Icons.check_circle;
        NocheckColor = Color.fromRGBO(98, 183, 183, 1);
        Yescheckbox = Icons.circle_outlined;
        YescheckColor = Colors.grey;
      }
    });
  }
}


//##################################################################################################################################


// 전체 체크 리스트 페이지
class CheckList extends StatefulWidget {
  final Map<int, Answer?> answerVals;
  final List<String> Quesets;
  //const CheckList({Key? key}) : super(key: key);

  const CheckList({required this.answerVals, required this.Quesets});

  @override
  _CheckListState createState() => _CheckListState();
}

class _CheckListState extends State<CheckList>{

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
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          }),
        ),

        body: Center(
          child: Column(children: [
            SizedBox(height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.05),
            Container(
              child: Text("Self Diagnosis Complete !",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold,),)
            ),
            SizedBox(height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.09,),
            // 체크 리스트
            Container(
              height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.65,
              width: double.infinity,
              child: ListView.builder(
                itemCount: widget.answerVals.length,
                itemBuilder: (context, index){
                  final answer = widget.answerVals[index];
                  final isYes = (answer == Answer.yes);
                  return ListTile(
                    leading: isYes ? Icon(Icons.check_box, color: Colors.red,) : Icon(Icons.check_box_outline_blank, color: Colors.black,),
                    title: Text("나는 " + widget.Quesets[index], style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold)),
                  );
                },
              ),

            ),
            SizedBox(height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.04,),

            // 결과 확인 버튼
            Container(
              height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top) * 0.09,
              width: (MediaQuery.of(context).size.width - MediaQuery.of(context).padding.left) * 0.80,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(98, 183, 183, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  if(resultCount(widget.answerVals) >= 4){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => result.YesScreen())); // 결과 페이지로 이동
                  } else{
                    Navigator.push(context, MaterialPageRoute(builder: (context) => result.NoScreen())); // 결과 페이지로 이동
                  }

                },
                child: Text("Check the results", style: TextStyle(fontSize: 25, shadows:[
                  Shadow(color: Colors.grey, offset: Offset(1,2), blurRadius: 7)],),
                ),
              ),
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