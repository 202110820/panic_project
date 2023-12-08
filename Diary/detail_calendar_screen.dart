import 'package:flutter/material.dart';

//firebase 연동 패키지
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact2/database_service.dart';

import 'package:intl/intl.dart'; //DateFormat 위한 패키지

class DetailDiary extends StatefulWidget {
  final Timestamp selectedDay;
  final String email;

  DetailDiary({required this.selectedDay, required this.email});

  @override
  _DetailDiaryState createState() => _DetailDiaryState();
}

class _DetailDiaryState extends State<DetailDiary> {

  String emoji = '';
  String changedEmoji = '';
  String changedDiary = '';
  bool isSelectedEmoji = false;


  List<String> emojiList = [
    'assets/Calendar/Emoji/emoji_happy.png', 'assets/Calendar/Emoji/emoji_smile.png', 'assets/Calendar/Emoji/emoji_surprised.png',
    'assets/Calendar/Emoji/emoji_heart_fluttering.png', 'assets/Calendar/Emoji/emoji_shy.png', 'assets/Calendar/Emoji/emoji_tired.png',
    'assets/Calendar/Emoji/emoji_boring.png', 'assets/Calendar/Emoji/emoji_sad.png', 'assets/Calendar/Emoji/emoji_angry.png',
  ];

  // timestamp -> DateTime으로 변환하기 위한 함수
  String formatSelectedDay(Timestamp selectedDay) {
    Timestamp timestamp = selectedDay; // Firestore에서 Timestamp 필드 가져오기
    DateTime dateTime = timestamp.toDate(); // Timestamp를 DateTime으로 변환

    return DateFormat('MM/dd').format(dateTime);
  }

  Widget build(BuildContext context) {
    //final login = Provider.of<LoginModel>(context, listen: false);
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white, useMaterial3: true,),
      home: Scaffold(
          appBar:AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(icon: Icon(Icons.arrow_back_ios, size: 30, color: Color.fromRGBO(151, 151, 151, 1)),
                onPressed:() {
                  Navigator.pop(
                      context // 캘린더 화면으로 이동 (이전 화면)
                  );
                }),
          ),
          extendBodyBehindAppBar: true,
          body: Center(
              child: GestureDetector(
                  onTap:()=> FocusScope.of(context).unfocus(), //바깥 영역 선택시 키보드 사라짐
                  child: SingleChildScrollView(
                      child: Container(
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height * 0.95,
                          width: MediaQuery.of(context).size.width * 0.85,

                          //firebase
                          child: StreamBuilder<QuerySnapshot>(
                              stream: getCalendar(widget.selectedDay.toDate(), widget.email),
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                                // 데이터 없으면 로딩 표시
                                if (!snapshot.hasData || snapshot.data!.docs.isEmpty){
                                  return CircularProgressIndicator(backgroundColor: Colors.white, color: Colors.white);
                                }
                                // 데이터 있으면 화면에 표시
                                else{
                                  final documents = snapshot.data!.docs;
                                  final widgets = documents.map((DocumentSnapshot document){
                                    emoji = document['emotion'];
                                    return Column(children: [
                                      SizedBox(height: MediaQuery.of(context).size.height * 0.10,),

                                      // 날짜 및 온도 행
                                      Container(
                                          child: Column(children: [
                                            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(formatSelectedDay(document['day']), style: TextStyle(fontSize: 16)), // 날짜
                                                SizedBox(width: MediaQuery.of(context).size.width * 0.60,),
                                                Text('${document['temperature']}°C', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),), // 온도
                                              ],)
                                          ],)
                                      ),

                                      // SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                                      // Container(child: Text("Record today's feelings.", style: TextStyle(fontSize: 18),)),
                                      // SizedBox(height: MediaQuery.of(context).size.height * 0.01,),

                                      // 감정 기록
                                      Container(
                                          child: Column(children: [
                                            IconButton(
                                              onPressed: () {
                                                // 아이콘을 눌렀을 때 이모지 팝업 창을 표시
                                                showDialog(
                                                  context: context,
                                                  barrierDismissible: true, //바깥영역 터치 시 닫을지 여부
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      backgroundColor: Colors.white,
                                                      title: Text("Record today's feelings.", textAlign: TextAlign.center),
                                                      content: Container(
                                                        margin: EdgeInsets.only(top: 20),
                                                        height: MediaQuery.of(context).size.height * 0.40, // 그리드 높이 조정
                                                        width: MediaQuery.of(context).size.width * 0.40, // 그리드 너비 조정
                                                        child: GridView.builder(
                                                          shrinkWrap: true,
                                                          itemCount: 9, // 이미지 개수
                                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 3, // 열의 개수 (3x3)
                                                            childAspectRatio: 1 / 1, // item의 행 열의 비율
                                                          ),
                                                          itemBuilder: (BuildContext context, int index) {
                                                            return InkWell(
                                                              child: Container(
                                                                margin: EdgeInsets.all(5), // icon 사이 간격
                                                                child: Image.asset(emojiList[index]),
                                                              ),

                                                              // emotion 수정
                                                              onTap: () {
                                                                setState(() {
                                                                  changedEmoji = emojiList[index];
                                                                  //document.reference.set({'emotion': emojiList[index],}, SetOptions(merge: true)); // 바뀐 감정 데이터 firebase에 저장
                                                                });
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      actions: <Widget>[
                                                        Row(
                                                            mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
                                                            children: <Widget>[
                                                              Container(
                                                                height: MediaQuery.of(context).size.height * 0.075,
                                                                width: MediaQuery.of(context).size.width * 0.30,
                                                                child: ElevatedButton(
                                                                  style: ElevatedButton.styleFrom(
                                                                    backgroundColor: const Color.fromRGBO(98, 183, 183, 1),
                                                                    shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(30),
                                                                    ),
                                                                  ),
                                                                  onPressed: () {
                                                                    setState(() {
                                                                      isSelectedEmoji = true;
                                                                    });
                                                                    print("Now Emoji: ${changedEmoji}");
                                                                    Navigator.pop(context, changedEmoji);
                                                                  },
                                                                  child: Text("OK", style: TextStyle(fontSize: 22,fontFamily: 'Inter',color: Colors.white, fontWeight: FontWeight.w500),),
                                                                )
                                                              )
                                                            ]
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              icon: (changedEmoji != '') ? Image.asset(changedEmoji) : Image.asset(emoji), iconSize: 100,
                                              //icon: Image.asset(changedEmoji), iconSize: 100, // 변경된 emotion으로 icon 설정
                                            ),
                                          ],)
                                      ),

                                      SizedBox(height: MediaQuery.of(context).size.height * 0.01,),

                                      // 다이어리
                                      Container(
                                          //height: MediaQuery.of(context).size.height * 0.25,
                                          width: MediaQuery.of(context).size.width * 0.80,
                                          child: Column(children: [
                                            Container(
                                              child: Text('How was your day today?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFFA2C4C9),),textAlign: TextAlign.center,),
                                            ),

                                            // 일기 수정
                                            Container(
                                              height: MediaQuery.of(context).size.height * 0.40,
                                              child: TextFormField(
                                                textAlign: TextAlign.center,
                                                initialValue: document['contents'], // 초기값
                                                minLines: 1,
                                                maxLines: null,
                                                maxLength: 200,
                                                keyboardType: TextInputType.text,
                                                textInputAction: TextInputAction.done,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none, // 입력 밑줄 제거
                                                  hintText: "Type it here...",
                                                  hintStyle: TextStyle(fontSize: 16, color: Color.fromRGBO(105, 108, 108, 1)),
                                                ),
                                                onChanged: (text){
                                                  setState(() {
                                                    changedDiary = text;
                                                    //document.reference.set({'contents': text}, SetOptions(merge: true)); // 바뀐 일기 데이터 저장
                                                  });
                                                },
                                              ),
                                            ),
                                          ],)
                                      ),
                                      SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                                      //저장 버튼
                                      Container(
                                        alignment: Alignment.bottomCenter,
                                        // height: MediaQuery.of(context).size.height * 0.05,
                                        // width: MediaQuery.of(context).size.width * 0.25,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Color(0xFF62B6B6),
                                            fixedSize: const Size(85, 20),
                                          ),
                                          child: Text("Save", style: TextStyle(fontSize: 15.28, color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w700),
                                            textAlign: TextAlign.center,),
                                          onPressed: () {
                                            if(changedEmoji != ''){
                                              document.reference.set({'emotion': changedEmoji,}, SetOptions(merge: true)); // 바뀐 감정 데이터 firebase에 저장
                                            }
                                            if(changedDiary != ''){
                                              document.reference.set({'contents': changedDiary}, SetOptions(merge: true)); // 바뀐 일기 데이터 저장
                                            }
                                            Navigator.pop( // 캘린더 화면으로 이동 (이전 화면)
                                              context,
                                            );
                                          },
                                        ),
                                      )
                                    ]);
                                  }).toList();
                                  return Column(children: widgets,);
                                }
                              }
                          )
                      )
                  )
              )
          )
      ),
    );
  }
}
