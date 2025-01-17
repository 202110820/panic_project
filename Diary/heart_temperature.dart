import 'package:flutter/material.dart';
import 'package:contact2/database_service.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart'; //온도 설정 바 패키지
import 'package:sliding_up_panel/sliding_up_panel.dart'; //다이어리 sliding panel 패키지
import 'package:intl/intl.dart'; //DateFormat을 위한 패키지

//온도 설정 및 일기 작성 페이지
class DiaryExample extends StatefulWidget {
  final DateTime selectedDay;
  final String email;

  DiaryExample({required this.selectedDay, required this.email});

  @override
  _DiaryExampleState createState() => _DiaryExampleState();
}

class _DiaryExampleState extends State<DiaryExample> {
  final _contentEditController = TextEditingController();
  Map<int, String> heartImages = {
    0: 'assets/Calendar/HeartPercentage/heart0.png', 10: 'assets/Calendar/HeartPercentage/heart10.png', 20: 'assets/Calendar/HeartPercentage/heart20.png', 30: 'assets/Calendar/HeartPercentage/heart30.png',
    40: 'assets/Calendar/HeartPercentage/heart40.png', 50: 'assets/Calendar/HeartPercentage/heart50.png', 60: 'assets/Calendar/HeartPercentage/heart60.png', 70: 'assets/Calendar/HeartPercentage/heart70.png',
    80: 'assets/Calendar/HeartPercentage/heart80.png', 90: 'assets/Calendar/HeartPercentage/heart90.png', 100: 'assets/Calendar/HeartPercentage/heart100.png'
  };

  String formatDate = '';

  final double _initFabHeight = 120.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 95.0;

  bool _isAppBarVisible = false; // Panel appBar의 표시 여부

  List<String> emojiList = [
    'assets/Calendar/Emoji/emoji_happy.png', 'assets/Calendar/Emoji/emoji_smile.png', 'assets/Calendar/Emoji/emoji_surprised.png',
    'assets/Calendar/Emoji/emoji_heart_fluttering.png', 'assets/Calendar/Emoji/emoji_shy.png', 'assets/Calendar/Emoji/emoji_tired.png',
    'assets/Calendar/Emoji/emoji_boring.png', 'assets/Calendar/Emoji/emoji_sad.png', 'assets/Calendar/Emoji/emoji_angry.png',
  ];

  String selectedHeartImage = '';
  double temperature = 0;
  String diaryText = '';
  String selectedEmoji = '';

  @override
  void initState() {
    super.initState();

    _fabHeight = _initFabHeight;
  }

  String formatSelectedDay(DateTime selectedDay) {
    return DateFormat('MM/dd').format(selectedDay);
  }

  bool isSelectedEmoji = false;

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height; // panel이 전부 올라왔을 때의 높이 (-> 앱의 전체 높이만큼)
    return Material(
      child: Container(child: Stack(
        alignment: Alignment.topCenter,
        children: [
          SingleChildScrollView(
            child: SlidingUpPanel(
              maxHeight: _panelHeightOpen,
              minHeight: _panelHeightClosed,
              backdropEnabled: true,
              parallaxEnabled: true,
              parallaxOffset: .5,
              body: _body(),
              panelBuilder: (sc) => _panel(sc),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0)),
              onPanelSlide: (double pos) => setState(() {
                _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) +_initFabHeight;
                _isAppBarVisible = pos == 1.0; // 슬라이딩 패널이 열렸을 때만 appBar 표시
              }),
              collapsed: _viewPanel(), // panel 올리기 전, 표시되는 것
              header: _isAppBarVisible ? _appBar() : null,
            ),
          )

        ],
      ),),
    );
  }

  // 온도 설정 창 아래에 살짝 보이는 Panel
  Widget _viewPanel(){
    return Container(
        child: Column(children: [
          Icon(
            Icons.keyboard_arrow_up_outlined, // 위로 향하는 화살표 아이콘
            color: Colors.grey,
            size: 40.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(formatSelectedDay(widget.selectedDay), style: TextStyle(fontSize: 16)),
              SizedBox(width: MediaQuery.of(context).size.width * 0.60,),
              Text('${temperature.toInt()}°C', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
            ],)
        ],)
    );
  }

  //다이어리 Panel의 appbar
  Widget _appBar() {
    return Container(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
          Container(
              child: Row(children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.03,),

                // 캘린더 홈으로 이동 버튼
                Container(
                    child: IconButton(icon: Icon(Icons.arrow_back_ios, size: 30, color: Color.fromRGBO(151, 151, 151, 1)),
                        onPressed:() {
                          Navigator.pop(
                              context // 캘린더 화면으로 이동 (이전 화면)
                          );
                        })
                ),
              ],)
          )
        ],
      ),
    );
  }

  // 감정 기록 및 다이어리 작성 panel 위젯
  Widget _panel(ScrollController scrollController) {
    String basicEmoji = 'assets/Calendar/Emoji/emoji_add.png'; // icon의 기본 이미지 경로

    // diaryText가 비어있지 않다면 컨트롤러에 값을 설정
    if (diaryText.isNotEmpty) {
      _contentEditController.text = diaryText;
    }

    return SingleChildScrollView( // 키보드 overflow 방지를 위해 ScrollView()로 묶음
      controller: scrollController,
      child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.10,),

            // 날짜 및 온도 행
            Container(
                child: Column(children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(formatSelectedDay(widget.selectedDay), style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)), // 날짜
                      SizedBox(width: MediaQuery.of(context).size.width * 0.60,),
                      Text('${temperature.toInt()}°C', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),), // 온도
                    ],)
                ],)
            ),
            // SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            // Container(child:Text("Record today's feelings.", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),)),
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
                            title: Text("이모티콘을 통해\n오늘의 감정을 기록해보세요.", textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Inter',fontSize: 16),),
                            content: Container(
                              margin: EdgeInsets.only(top: 10),
                              height: MediaQuery.of(context).size.height * 0.35, // 그리드 높이 조정
                              width: MediaQuery.of(context).size.width * 0.45, // 그리드 너비 조정
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
                                    onTap: () {
                                      setState(() {
                                        selectedEmoji = emojiList[index];
                                      });
                                      print("select Emoji: $selectedEmoji");
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
                                      //height: MediaQuery.of(context).size.height * 0.0,
                                      width: MediaQuery.of(context).size.width * 0.25,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromRGBO(98, 183, 183, 1),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          //fixedSize: Size(29, 10)
                                        ),
                                        onPressed: () {
                                          print("Now Emoji: $selectedEmoji");
                                          setState(() {
                                            isSelectedEmoji = true;
                                          });
                                          Navigator.pop(context, selectedEmoji);
                                          print("success ${selectedEmoji}, ${isSelectedEmoji}");
                                        },
                                        child: Text("선택", style: TextStyle(fontSize: 17,fontFamily: 'Inter',color: Colors.white, fontWeight: FontWeight.w500),
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
                    icon: (selectedEmoji != '') ? Image.asset(selectedEmoji) : Image.asset(basicEmoji), iconSize: 100,
                  ),
                ],)
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),

            // 다이어리
            Container(
              //color: Colors.blue,
              //   height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width * 0.80,
                child: Column(children: [
                  //SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                  Container(
                    child: Text('오늘 하루는 어땠나요?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFFA2C4C9),),textAlign: TextAlign.center,),
                  ),

                  //일기 작성
                  Container(
                    height: MediaQuery.of(context).size.height * 0.40,
                    //color: Colors.green,
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: _contentEditController,
                      minLines: 1,
                      maxLines: null,
                      maxLength: 200,
                      keyboardType: TextInputType.text, //TextInputType.multiline,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        border: InputBorder.none, // 입력 밑줄 제거
                        hintText: "이곳에 작성해주세요...",
                        hintStyle: TextStyle(fontSize: 16, color: Color.fromRGBO(105, 108, 108, 1)),
                      ),
                    ),
                  ),
                ],)
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            // 저장하기 버튼
            Container(
              //color: Colors.red,
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF62B6B6),
                  //fixedSize: const Size(85, 20),
                ),
                child: Text("저장하기", style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,),
                onPressed: () {
                  selectedHeartImage = heartImages[temperature.toInt()] ?? 'assets/Calendar/HeartPercentage/empty_heart.png';
                  diaryText = _contentEditController.text; //일기 기록 내용

                  if (selectedHeartImage.isNotEmpty &&
                      selectedEmoji.isNotEmpty &&
                      diaryText.isNotEmpty){
                    // 선택한 온도와 관련된 이미지를 이전 화면(캘린더 화면)으로 반환
                    print('Selected Heart Image: $selectedHeartImage');
                    print('Today Emoji is: $selectedEmoji');

                    // DB 저장!
                    //addCalendar(DateTime recordDate, String diary, String emotion, String temperature, String email)
                    addCalendar(widget.selectedDay, diaryText, selectedEmoji, (temperature.toInt()).toString(), widget.email);

                    Navigator.pop( // 이전 화면 (캘린더 화면)
                      context,
                    );
                  }else {
                    // 하나라도 기록을 안 했을 때 경고문 표시
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder:(BuildContext context){
                          return AlertDialog(
                            content: Text("\n모든 항목을 채워주세요!",style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.black
                            ),
                              textAlign: TextAlign.center,),
                            actions: <Widget>[
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('확인',style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white
                                      ),
                                        textAlign: TextAlign.center,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Color(0xFF62B6B6),
                                        fixedSize: const Size(80, 35),
                                        //padding: const EdgeInsets.fromLTRB(0,0,10,0),
                                      ),
                                    ),
                                  ]
                              ),
                            ],
                          );
                        }
                    );
                  }
                },
              ),
            ),
          ]
      ),
    );
  }

  // 온도 설정 화면 (처음 보이는 화면)
  Widget _body() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        home: Scaffold(
            appBar:AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              leading: IconButton(icon: Icon(Icons.arrow_back_ios, size: 30, color: Color.fromRGBO(151, 151, 151, 1)), onPressed:() {
                Navigator.pop(
                    context // 캘린더 화면으로 이동 (이전 화면)
                );
              }),
              // 가이드 버튼
              actions: [
                IconButton(icon: Icon(Icons.question_mark, size: 30, color: Colors.grey), onPressed:(){
                  showDialog(
                    //barrierColor: Colors.white,
                      context: context,
                      barrierDismissible: true, //바깥영역 터치 시 닫을지 여부
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          content: Column(mainAxisSize: MainAxisSize.min, children: [
                            SizedBox(height: 10,),
                            Container(
                                child: Text.rich(
                                  TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "오늘의 하트를 채워주세요.\n",
                                        style: TextStyle(color: Color.fromRGBO(153, 150, 150, 1), fontSize: 17, fontWeight: FontWeight.w800, fontFamily: 'Archivo',),
                                      ),
                                      TextSpan(
                                        text: "\n-100°C부터 0°C까지 기분을\n하트로 표현하세요.",
                                        style: TextStyle(color: Color.fromRGBO(153, 150, 150, 1), fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'Archivo'),
                                      ),
                                    ],
                                  ),textAlign: TextAlign.center,
                                )
                            ),
                            //SizedBox(height: 10,),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.50,
                              child: Image.asset('assets/Calendar/TemperatureGuide.png'),
                            ),
                          ],),
                        );
                      }
                  );
                })
              ],
            ),
            extendBodyBehindAppBar: true,
            body:
            SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.20,),

                    //문구
                    Container(
                        child: Text("오늘 당신의 마음 온도는\n몇 도였나요?", textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 24, color: Color.fromRGBO(60, 60, 60, 1), fontWeight: FontWeight.w700, fontFamily: 'Inter'))
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                    Container(
                        child: Column(children: <Widget>[

                          // 하트 이미지
                          Container(
                            child: Image.asset('assets/Calendar/HeartPercentage/heart${temperature.round()}.png'),
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width * 0.15,
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                          // 마음 온도계
                          Container(
                            child: SleekCircularSlider(
                              initialValue: temperature,
                              min: 0,
                              max: 100,
                              appearance: CircularSliderAppearance(
                                  size: 300,
                                  startAngle: 180,
                                  angleRange: 180,
                                  customWidths: CustomSliderWidths(progressBarWidth: 15),

                                  customColors: CustomSliderColors(
                                    progressBarColors: [Color.fromRGBO(204, 22, 60, 1), Color.fromRGBO(255, 224, 230, 1)],
                                    trackColor: Colors.grey,
                                    dotColor: Colors.grey,

                                    hideShadow: true, // progressBar 그림자 제거
                                    gradientStartAngle: 0.0, // 그라데이션 시작 각도 설정
                                    gradientEndAngle: 180.0,
                                  )
                              ),
                              // 온도계 안에 숫자 위젯
                              innerWidget: (double value) {
                                return Center(
                                    child: Text.rich(
                                      TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "${temperature.toInt()}",
                                            style: TextStyle(color: Color.fromRGBO(60, 60, 60, 1), fontSize: 80, fontWeight: FontWeight.w600, fontFamily: 'Baloo 2'),
                                          ),
                                          TextSpan(
                                            text: "°C",
                                            style: TextStyle(color: Color.fromRGBO(60, 60, 60, 1), fontSize: 45, fontWeight: FontWeight.w600, fontFamily: 'Baloo 2'),
                                          ),
                                        ],
                                      ),
                                    )
                                );
                              },
                              onChange: (double value) {
                                setState(() {
                                  temperature = (value / 10).round() * 10;
                                });
                              },
                            ),
                          ),
                        ],)
                    ),
                  ],
                ),
              ),
            )
        )
    );
  }
}