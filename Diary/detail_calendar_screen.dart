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

            //Save 버튼
            actions: [
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.25,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    //shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text("Save", style: TextStyle(fontSize: 15.28, color: Color.fromRGBO(154, 154, 154, 1), fontFamily: 'Poppins', fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,),
                  onPressed: () {
                    Navigator.pop( // 캘린더 화면으로 이동 (이전 화면)
                      context,
                    );
                  },
                ),
              )
            ],
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
                                    return Column(children: [
                                      SizedBox(height: MediaQuery.of(context).size.height * 0.10,),

                                      // 날짜 및 온도 행
                                      Container(
                                          child: Column(children: [
                                            SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(formatSelectedDay(document['day']), style: TextStyle(fontSize: 16)), // 날짜
                                                SizedBox(width: MediaQuery.of(context).size.width * 0.60,),
                                                Text('${document['temperature']}°C', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),), // 온도
                                              ],)
                                          ],)
                                      ),

                                      SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                                      Container(child: Text("Record today's feelings.", style: TextStyle(fontSize: 18),)),
                                      SizedBox(height: MediaQuery.of(context).size.height * 0.01,),

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
                                                                  document.reference.set({'emotion': emojiList[index],}, SetOptions(merge: true)); // 바뀐 감정 데이터 firebase에 저장
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
                                                                height: MediaQuery.of(context).size.height * 0.08,
                                                                width: MediaQuery.of(context).size.width * 0.30,
                                                                child: ElevatedButton(
                                                                  style: ElevatedButton.styleFrom(
                                                                    backgroundColor: const Color.fromRGBO(98, 183, 183, 1),
                                                                    shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(30),
                                                                    ),
                                                                  ),
                                                                  onPressed: () {
                                                                    print("Now Emoji: ${document['emotion']}");
                                                                    Navigator.pop(context, document['emotion']);
                                                                  },
                                                                  child: Text("OK", style: TextStyle(fontSize: 22, shadows:[
                                                                    Shadow(color: Colors.grey, offset: Offset(1,2), blurRadius: 5)],),
                                                                  ),
                                                                ),
                                                              )
                                                            ]
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              icon: Image.asset(document['emotion']), iconSize: 100, // 변경된 emotion으로 icon 설정
                                            ),
                                          ],)
                                      ),

                                      SizedBox(height: MediaQuery.of(context).size.height * 0.01,),

                                      // 다이어리
                                      Container(
                                          height: MediaQuery.of(context).size.height * 0.25,
                                          width: MediaQuery.of(context).size.width * 0.80,
                                          child: Column(children: [
                                            Row(children: [
                                              Container(
                                                child: Text('How was your day today?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                              ),
                                            ],),

                                            // 일기 수정
                                            Container(
                                              child: TextFormField(
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
                                                    document.reference.set({'contents': text}, SetOptions(merge: true)); // 바뀐 일기 데이터 저장
                                                  });
                                                },
                                              ),
                                            ),
                                          ],)
                                      ),
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