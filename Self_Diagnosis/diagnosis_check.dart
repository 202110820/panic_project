import 'package:flutter/material.dart';
import 'check_list.dart'; //자가진단 체크 현황 리스트 페이지

// 상태에 따른 UI 변화 - StatefulWidget
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
  List<String> Queset = ["맥박이 빨라지거나\n 심장 박동이 심하게 느껴진다.", "현기증을 느끼거나\n 머리가 띵하다.", "땀이 많이 난다.", "떨리고\n 전율감이 느껴진다.",
    "오한이 나거나\n 얼굴이 화끈 달아오른다.", "질식할 것 같다.", "토할 것 같거나\n 복부 불편감이 있다.", "가슴이 답답하거나\n 통증을 느낀다.", "자제력을 잃게 되거나\n 미쳐버릴까봐 두렵다.",
    "죽을 것 같아 두렵다.", "마비감이나 손발이 찌릿한\n 느낌 등 감각 이상이 있다.", "비현실감이나 내가 아닌\n 다른 사람이 된 것 같은\n 느낌이 든다.", "숨이 가빠지거나\n 숨이 막히는 것 같은 느낌이 든다."];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white, useMaterial3: true,),
      home: Scaffold(
        appBar: AppBar(
          title: RichText(

            text: TextSpan(
              //style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                  text: "$currentPage",
                  style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Inter', fontWeight: FontWeight.w600,),
                ),
                TextSpan(
                  text: " of $totalPages",
                  style: TextStyle(color: Colors.grey, fontSize: 20, fontFamily: 'Inter', fontWeight: FontWeight.w600,),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              iconSize: 30,
              color: Color.fromRGBO(151, 151, 151, 1),
              onPressed:() {
                Navigator.of(context).popUntil((route) => route.isFirst);
              }),
        ),
        extendBodyBehindAppBar: true,
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.25,),

              // 질문 컨테이너
              Container(
                //color: Colors.grey,
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: Text('나는 ${Queset[currentPage-1]}',
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),textAlign: TextAlign.center)
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.03,),

              // Yes 버튼
              Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        foregroundColor: MaterialStateProperty.all(Colors.black,),
                        shadowColor: MaterialStateProperty.all(Colors.grey,),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                        ),
                        side: MaterialStateProperty.all(
                          isYesPressed ? BorderSide(color: Color.fromRGBO(98, 183, 183, 1), width: 3) : BorderSide(color: Colors.grey, width: 2),
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
                          Text("Yes",
                            style: TextStyle(
                                fontSize: 28,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                color: Colors.black
                            ),),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.40,),
                          Icon(Yescheckbox, color: YescheckColor, size: 50),
                        ],)

                  )
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.05,),

              // No 버튼
              Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        foregroundColor: MaterialStateProperty.all(Colors.black,),
                        shadowColor: MaterialStateProperty.all(Colors.grey,),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                        ),
                        side: MaterialStateProperty.all(
                          isNoPressed ? BorderSide(color: Color.fromRGBO(98, 183, 183, 1), width: 3) : BorderSide(color: Colors.grey, width: 2),
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
                          Text("No", style: TextStyle(
                              fontSize: 28,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              color: Colors.black
                          ),),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.44),
                          Icon(Nocheckbox, color: NocheckColor, size: 50),
                        ],)
                  )
              ),

              // Back, Next 버튼
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    //Back 버튼
                    Container(
                      margin: EdgeInsets.only(left:15, bottom: 40),
                      alignment: Alignment.bottomLeft,
                      child: ElevatedButton.icon(
                          onPressed: () {
                            if(currentPage != 1){
                              setState((){
                                currentPage--;
                                isYesPressed = false;
                                isNoPressed = false;
                                Yescheckbox = Icons.circle_outlined; // 체크박스 초기화
                                Nocheckbox = Icons.circle_outlined;
                                YescheckColor = Colors.grey;
                                NocheckColor = Colors.grey;
                              });
                            }
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

                    //Next
                    Container(
                      margin: EdgeInsets.only(right:15, bottom: 40),
                      alignment: Alignment.bottomRight,
                      child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: ElevatedButton.icon(
                            onPressed: (){
                              if(isYesPressed || isNoPressed){
                                setState((){
                                  if (currentPage <= totalPages - 1){
                                    currentPage++;
                                    isYesPressed = false;
                                    isNoPressed = false;
                                    Yescheckbox = Icons.circle_outlined; // 체크박스 초기화
                                    Nocheckbox = Icons.circle_outlined;
                                    YescheckColor = Colors.grey;
                                    NocheckColor = Colors.grey;
                                  }
                                  // 마지막 페이지인 경우
                                  else{
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CheckList(answerVals: answerVal, Quesets: Queset), //자가진단 체크 현황 페이지로 이동
                                      ),
                                    );
                                  }
                                });
                              }
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
                    ),
                  ],
                ),
              ),
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
