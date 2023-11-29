import 'package:flutter/material.dart';
import 'heart_temperature.dart'; // 온도 및 일기 작성 페이지
import 'detail_calendar_screen.dart'; // 기록 날짜에 대한 수정 페이지
import 'package:table_calendar/table_calendar.dart'; // calendar 패키지
import 'package:intl/intl.dart'; // DateFormat을 위한 패키지
import 'package:contact2/main.dart';
// firebase 연동 패키지
import 'package:contact2/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// 캘린더 메인 화면
class TemperCalendar extends StatefulWidget{
  final String email;

  TemperCalendar({required this.email});

  //const TemperCalendar({Key? key}) : super(key: key);

  @override
  _TemperCalendarState createState() => _TemperCalendarState();
}

class _TemperCalendarState extends State<TemperCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  var _selectedDay;

  //bool checkedDetail = false;
  bool selectedcheckDay = false;
  bool checkedDetail = false;

  String formatSelectedDay(Timestamp selectedDay) {
    Timestamp timestamp = selectedDay; // Firestore에서 Timestamp 필드 가져오기
    DateTime dateTime = timestamp.toDate(); // Timestamp를 DateTime으로 변환

    return DateFormat('MM/dd').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    //final login = Provider.of<LoginModel>(context, listen: false);
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white, useMaterial3: true,),
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(icon: Icon(Icons.arrow_back_ios, size: 30, color: Color.fromRGBO(151, 151, 151, 1)), onPressed:() {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyApp(), //메인 화면으로 이동
                ),
              );
            }),
          ),
          extendBodyBehindAppBar: true,
          body: Center(child: Column(children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.10,),

            TableCalendar(
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2050, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              daysOfWeekHeight: MediaQuery.of(context).size.height * 0.08, // 날짜 행렬과 요일 행 사이 간격을 조정
              headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  //title
                  titleCentered: true,
                  titleTextFormatter: (date, locale) {
                    return '${date.year}\n${DateFormat.MMMM(locale).format(date)}';
                  },
                  titleTextStyle: TextStyle(fontSize: 24, fontFamily: 'Inter', fontWeight: FontWeight.bold),
                  // left
                  leftChevronVisible: true,
                  //right
                  rightChevronVisible: true,
                  //header
                  headerMargin: EdgeInsets.fromLTRB(0, 30, 0, 20)
              ),
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                cellMargin:  EdgeInsets.all(0), // 날짜 크기 조절
                cellAlignment: Alignment.topCenter, // 날짜를 네모칸 기준으로 상단 센터에 위치
                //cellPadding: EdgeInsets.all(0), // 내부 패딩 제거

                todayDecoration: BoxDecoration(
                  //color: Color.fromRGBO(162, 196, 201, 0.8),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white,width: 1.5)
                ),

                todayTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(98, 183, 183, 1),
                ),

                selectedDecoration: BoxDecoration(
                    color: Color.fromRGBO(217, 230, 233, 1), //Color.fromRGBO(154, 199, 206, 0.8),
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.white,width: 1.5)
                ),
                selectedTextStyle: TextStyle(
                  //fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                defaultTextStyle: TextStyle(color: Colors.black,),
                weekendTextStyle: TextStyle(color: Colors.red),
              ),

              selectedDayPredicate: (day) {
                // Use `selectedDayPredicate` to determine which day is currently selected.
                // If this returns true, then `day` will be marked as selected.

                // Using `isSameDay` is recommended to disregard
                // the time-part of compared DateTime objects.
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  // Call `setState()` when updating the selected dayseo
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    selectedcheckDay = true;
                  });
                }
              },
              /*
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
            },

            onPageChanged: (focusedDay) {
              // No need to call `setState()` here
              _focusedDay = focusedDay;
            },
            */

              // 온도에 따른 하트 이미지
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  // firebase
                  return StreamBuilder <QuerySnapshot>(
                      stream: getCalendar(date, widget.email),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                        // 기록된 날짜가 없으면 - 빈 하트
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty){
                          return Column(
                            children: [
                              const SizedBox(height: 20.0),
                              Center(
                                  child: Image.asset('assets/Calendar/HeartPercentage/empty_heart.png', width: 24, height: 24)
                              ),
                            ],
                          );
                        }

                        // 기록된 날짜 있으면
                        else {
                          final documents = snapshot.data!.docs;
                          final widgets = documents.map((DocumentSnapshot document){
                            return InkWell(
                              child: Column(
                                children: [
                                  const SizedBox(height: 20.0),
                                  Center(
                                      child: Image.asset('assets/Calendar/HeartPercentage/heart${document['temperature']}.png', width: 24, height: 24)
                                  ),
                                ],
                              ),
                              onTap: () {
                                setState(() {
                                  checkedDetail = true;
                                });
                                if(document['day'] != null){
                                  if(checkedDetail == true){
                                    if('assets/Calendar/HeartPercentage/heart${document['temperature']}.png' != 'assets/Calendar/HeartPercentage/empty_heart.png'){
                                      // 이벤트를 클릭할 때 세부 정보 팝업 열기
                                      _showDetailsPopup(context, date);
                                    }
                                  }

                                }
                              },
                            );
                          }).toList();
                          return Column(children: widgets,);
                        }
                        //return const InkWell();
                      }
                  );
                },
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.10,),

            // 다이어리 추가 버튼
            Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.25,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(98, 183, 183, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () async {
                    if(selectedcheckDay == true){
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DiaryExample(selectedDay: _selectedDay, email: widget.email), //온도 및 일기 작성 페이지로 이동
                        ),
                      );
                    }
                  },
                  child: Icon(Icons.add_outlined, size: 50, color: Colors.white),
                )
            ),
          ]),)
      ),
    );
  }

  // 기록한 날짜에 대한 디테일 팝업
  void _showDetailsPopup(BuildContext context, DateTime selectedDay) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              color: Color.fromRGBO(217, 230, 233, 1),
              height: MediaQuery.of(context).size.height / 4, // 화면 높이의 1/4로 조절
              width: double.infinity,
              child: StreamBuilder <QuerySnapshot>(
                  stream: getCalendar(selectedDay, widget.email),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty){
                      return CircularProgressIndicator(backgroundColor: Color.fromRGBO(217, 230, 233, 1), color: Color.fromRGBO(217, 230, 233, 1));
                    }
                    else{
                      final documents = snapshot.data!.docs;
                      final widgets = documents.map((DocumentSnapshot document){
                        return InkWell(
                          onTap: () async {
                            setState(() {
                              checkedDetail = false;
                            });
                            // 팝업 클릭 시 새로운 페이지로 이동
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailDiary(selectedDay: document['day'], email: widget.email,), // 기록 날짜에 대한 수정 페이지로 이동
                                )
                            );
                          },
                          child: Column(
                            children: <Widget> [
                              Row(children: [
                                SizedBox(width: MediaQuery.of(context).size.width * 0.85,),
                                //휴지통
                                IconButton(
                                  onPressed: (){
                                    document.reference.delete(); //데이터 삭제
                                    Navigator.pop(context); //화면 닫기
                                  },
                                  icon: Image.asset('assets/Calendar/trashcan.png'), iconSize: 25,
                                  alignment: Alignment.topRight,
                                ),
                              ],),
                              Image.asset(document['emotion']), //이모지
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                              Text('${formatSelectedDay(document['day'])}의 일기'), //날짜
                              Text('${document['temperature']}°C'), //온도
                            ],
                          ),
                        );
                      }).toList();
                      return Column(children: widgets,);
                    }
                  }
              )
          );
        }
    );
  }
}