import 'package:contact2/Self_Diagnosis/diagnosis_check.dart';
import 'package:flutter/material.dart';
import 'map.dart';

//information
import 'information/Cause/pd_cause_1.dart';
import 'information/Symptom/pd_sym_1.dart';
import 'information/What_is_panic_disorder/pd_1.dart';

//medication
import 'Medication/What_is_medication/What_is_medication.dart';
import 'Medication/Antidepressant/ad_1.dart';
import 'Medication/Anti-anxiey/aa_1.dart';

//cbt
import 'CBT/cbt_menu.dart';
import 'CBT/Breating_exercises/be_main.dart';
import 'CBT/Muscle_relaxation/mr_main.dart';

//firebase 및 로그인 확인
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(Main_Split());
}

class Main_Split extends StatefulWidget {
  @override
  _Main_Split createState() => _Main_Split();
}

class _Main_Split extends State<Main_Split> with TickerProviderStateMixin {
  late TabController tabController = TabController(
    length: 3,
    vsync: this,
    initialIndex: 0,

    /// 탭 변경 애니메이션 시간
    animationDuration: const Duration(milliseconds: 200),
  );
  String? userName; // 닉네임 저장할 변수

  // 로그인 여부를 확인하고, 로그인된 사용자의 닉네임을 가져오는 함수
  Future<void> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool('isLogin') ?? false;

    if(isLogin){
      String? userEmail = prefs.getString('email'); // 'email' 키로 저장된 값을 불러옴
      if (userEmail != null) {
        final QuerySnapshot<Map<String, dynamic>> userQuery = await FirebaseFirestore.instance
            .collection('Mypage')
            .where("email", isEqualTo: userEmail)
            .get();

        // 쿼리 결과에서 문서 가져오기
        final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents = userQuery.docs;
        if (documents.isNotEmpty) {
          // 문서가 존재하면 첫 번째 문서의 참조를 얻기
          final DocumentSnapshot<Map<String, dynamic>> userSnapshot = documents.first;
          setState(() {
            userName = userSnapshot['nickname'];
          });
          print(userName);
        } else {
          print('No documents found for the given email.');
        }
      } else { null;
      // 로그인이 되어 있지만 이메일 정보가 없는 경우의 처리
      print('No documents found for the given email.');
      }
    }
    else {
      print('No documents found for the given email.');
    }
  }

  @override
  void initState() {
    super.initState();
    checkLogin(); // initState에서 checkLogin함수 호출
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: Scaffold(
          appBar: AppBar(
              title: Text('  ${userName ?? ''}', style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 30,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w800,
                height: 0,
              ),
              ),
              centerTitle: false,
              //backgroundColor: Colors.transparent,
              elevation: 0.0,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notifications_none),
                  iconSize: 45,
                )
              ]
          ),
          extendBodyBehindAppBar: false,
          body: Home(),
        )
    );
  }

  Widget Home(){
    return Column(
        children: [
          Container(height: 10,),
          //자가진단부분
          selfDiagnosis(),
          //moreinfo
          MoreInfo(),
          //메뉴선택
          _tabBar(),
        ]
    );
  }

  Widget InfoView(){
    return Container(
      height: 225,
      margin: EdgeInsets.only(left:9, right: 9, top: 12),
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: ShapeDecoration(
        //color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),

      ),
      child: Column(
        children: [
          InkWell(
            highlightColor: Colors.white.withOpacity(0.5),
            //splashColor: Colors.cyanAccent.withOpacity(0.4),
            borderRadius: BorderRadius.all(
                Radius.circular(5)
            ),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Pd_1())
            ),
            child: Container(
              height: 48,
              child: Row(
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    padding: const EdgeInsets.all(10),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Color(0xCC134F5C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  Text('   What is panic disorder?', style: TextStyle(color: Color(0xFF333333),
                    fontSize: 15.3,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,),),Spacer(),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
                ],),
            ),
          ),
          Div(),
          InkWell(
            highlightColor: Colors.white.withOpacity(0.5),
            //splashColor: Colors.cyanAccent.withOpacity(0.4),
            borderRadius: BorderRadius.all(
                Radius.circular(5)
            ),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Pd_cause_1())
            ),
            child: Container(
              height: 48,
              child: Row(
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    padding: const EdgeInsets.all(10),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Color(0xCC45818E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90),
                      ),
                    ),
                  ),
                  Text('   Cause', style: TextStyle(color: Color(0xFF333333),
                    fontSize: 15.3,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,),),Spacer(),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
                ],),
            ),
          ),
          Div(),
          InkWell(
            highlightColor: Colors.white.withOpacity(0.5),
            //splashColor: Colors.cyanAccent.withOpacity(0.4),
            borderRadius: BorderRadius.all(
                Radius.circular(5)
            ),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Pd_sym())
            ),
            child: Container(
              height: 48,
              child: Row(
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    padding: const EdgeInsets.all(10),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Color(0xCC76A5AF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90),
                      ),
                    ),
                  ),
                  Text('   Symptom', style: TextStyle(color: Color(0xFF333333),
                    fontSize: 15.3,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,),),Spacer(),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
                ],),
            ),
          ),
          Div(),
          InkWell(
            highlightColor: Colors.white.withOpacity(0.5),
            //splashColor: Colors.cyanAccent.withOpacity(0.4),
            borderRadius: BorderRadius.all(
                Radius.circular(5)
            ),
            onTap: (){},
            child: Container(
              height: 48,
              child: Row(
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    padding: const EdgeInsets.all(10),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Color(0xCCA2C4C9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90),
                      ),
                    ),
                  ),
                  Text('   Complications', style: TextStyle(color: Color(0xFF333333),
                    fontSize: 15.3,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,),),Spacer(),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
                ],),
            ),
          ),
          Div(),
          InkWell(
            highlightColor: Colors.white.withOpacity(0.5),
            //splashColor: Colors.cyanAccent.withOpacity(0.4),
            borderRadius: BorderRadius.all(
                Radius.circular(5)
            ),
            onTap: () {},
            child: Container(
              height: 48,
              child: Row(
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    padding: const EdgeInsets.all(10),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Color(0xCCD0E0E3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90),
                      ),
                    ),
                  ),
                  Text('   Other information', style: TextStyle(color: Color(0xFF333333),
                    fontSize: 15.3,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,),),Spacer(),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
                ],),
            ),
          ),
        ],
      ),
    );
  }
  Widget MediView(){
    return  Container(
      height: 145,
      margin: EdgeInsets.only(left:9, right: 9, top: 12),
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Column(
        children: [
          InkWell(
            highlightColor: Colors.white.withOpacity(0.5),
            //splashColor: Colors.cyanAccent.withOpacity(0.4),
            borderRadius: BorderRadius.all(
                Radius.circular(5)
            ),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Medication())
            ),
            child: Container(
              height: 48,
              child: Row(
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    padding: const EdgeInsets.all(10),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Color(0xCC134F5C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90),
                      ),
                    ),
                  ),
                  Text('   What is medication?', style: TextStyle(color: Color(0xFF333333),
                    fontSize: 15.3,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,),),Spacer(),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18)
                ],),
            ),
          ),
          Div(),
          InkWell(
            highlightColor: Colors.white.withOpacity(0.5),
            //splashColor: Colors.cyanAccent.withOpacity(0.4),
            borderRadius: BorderRadius.all(
                Radius.circular(5)
            ),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Ad_1())
            ),
            child: Container(
              height: 48,
              child: Row(
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    padding: const EdgeInsets.all(10),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Color(0xCC45818E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90),
                      ),
                    ),
                  ),
                  Text('   Antidepressant medication', style: TextStyle(color: Color(0xFF333333),
                    fontSize: 15.3,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,),),Spacer(),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
                ],),
            ),
          ),
          Div(),
          InkWell(
            highlightColor: Colors.white.withOpacity(0.5),
            //splashColor: Colors.cyanAccent.withOpacity(0.4),
            borderRadius: BorderRadius.all(
                Radius.circular(5)
            ),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Aa_1())
            ),
            child: Container(
              height: 48,
              child: Row(
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    padding: const EdgeInsets.all(10),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Color(0xCC76A5AF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90),
                      ),
                    ),
                  ),
                  Text('   Anti-anxiety medication', style: TextStyle(color: Color(0xFF333333),
                    fontSize: 15.3,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,),),Spacer(),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18)
                ],),
            ),
          ),
        ],
      ),

    );
  }
  Widget CbtView(){
    return Container(
      height: 188,
      margin: EdgeInsets.only(left:9, right: 9, top: 12),
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: ShapeDecoration(
        //color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Column(
        children: [
          InkWell(
            highlightColor: Colors.white.withOpacity(0.5),
            //splashColor: Colors.cyanAccent.withOpacity(0.4),
            borderRadius: BorderRadius.all(
                Radius.circular(5)
            ),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Cbt_menu())
            ),
            child: Container(
              height: 48,
              child: Row(
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    padding: const EdgeInsets.all(10),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Color(0xCC134F5C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90),
                      ),
                    ),
                  ),
                  Text('   Cognitive restructuring', style: TextStyle(color: Color(0xFF333333),
                    fontSize: 15.3,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,),),Spacer(),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey, size:18)
                ],),
            ),
          ),
          Div(),
          InkWell(
            highlightColor: Colors.white.withOpacity(0.5),
            //splashColor: Colors.cyanAccent.withOpacity(0.4),
            borderRadius: BorderRadius.all(
                Radius.circular(5)
            ),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Be_main())
            ),
            child: Container(
              height: 48,
              child: Row(
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    padding: const EdgeInsets.all(10),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Color(0xCC45818E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90),
                      ),
                    ),
                  ),
                  Text('   Breathing Exercises', style: TextStyle(color: Color(0xFF333333),
                    fontSize: 15.3,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,),),Spacer(),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
                ],),
            ),
          ),
          Div(),
          InkWell(
            highlightColor: Colors.white.withOpacity(0.5),
            //splashColor: Colors.cyanAccent.withOpacity(0.4),
            borderRadius: BorderRadius.all(
                Radius.circular(5)
            ),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Mr_main())
            ),
            child: Container(
              height: 48,
              child: Row(
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    padding: const EdgeInsets.all(10),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Color(0xCC76A5AF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90),
                      ),
                    ),
                  ),
                  Text('   Muscle relaxation', style: TextStyle(color: Color(0xFF333333),
                    fontSize: 15.3,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,),),Spacer(),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18)
                ],),
            ),
          ),
          Div(),
          InkWell(
            highlightColor: Colors.white.withOpacity(0.5),
            //splashColor: Colors.cyanAccent.withOpacity(0.4),
            borderRadius: BorderRadius.all(
                Radius.circular(5)
            ),
            onTap: () {

            },
            child: Container(
              height: 48,
              child: Row(
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    padding: const EdgeInsets.all(10),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Color(0xCCA2C4C9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90),
                      ),
                    ),
                  ),
                  Text('   Exposure therapy training', style: TextStyle(color: Color(0xFF333333),
                    fontSize: 15.3,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,),),Spacer(),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18)
                ],),
            ),
          )
        ],
      ),

    );
  }
  Widget _tabBar() {
    return Flexible(
      fit:  FlexFit.loose,
      child: Column(
          children: [
            //tabBar
            Container(
                margin: EdgeInsets.only(left: 18, right: 18, top: 10),
                child: TabBar(
                  labelPadding: EdgeInsets.only(left: 5, right: 5),
                  indicatorWeight: 0.0,
                  //indicatorSize: TabBarIndicatorSize.label,
                  //padding: const EdgeInsets.only(top: 8),
                  indicatorColor: Colors.transparent,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color(0xFF92CDCD),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x33131419),
                          blurRadius:8,
                          offset: Offset(2, 2),
                          spreadRadius: 2,
                        )
                      ]
                  ),
                  labelColor: Colors.black,
                  labelStyle: const TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelColor: Color(0xFF333333),
                  unselectedLabelStyle: const TextStyle(
                    color: Color(0xFF979797),
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),

                  /// 탭바 클릭시 나오는 splash effect 컬러
                  overlayColor: MaterialStatePropertyAll(
                    Colors.teal.shade50,
                  ),

                  /// 탭바 클릭할 때 나오는 splash effect의 radius
                  splashBorderRadius: BorderRadius.circular(50),
                  controller: tabController,
                  tabs: [
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                color: Color(0x99CACACA), width: 1)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Information"),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                color: Color(0x99CACACA), width: 1)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Medication"),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                color: Color(0x99CACACA), width: 1)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("CBT"),
                        ),
                      ),
                    ),
                  ],
                )),
            //tabBarView
            Container(
              width: (MediaQuery
                  .of(context)
                  .size
                  .width),
              height: 270,

              padding: EdgeInsets.only(left: 10, right: 10),
              //margin: EdgeInsets.only(left: 18, right: 18, top: 10),
              //color: Colors.transparent,
              child: TabBarView(
                  controller: tabController,
                  children: [
                    InfoView(),
                    MediView(),
                    CbtView()
                  ]
              ),
            )
          ]
      ),
    );
  }
  Widget selfDiagnosis(){
    return Ink(
      width: (MediaQuery
          .of(context)
          .size
          .width)*0.9,
      height: 160,
      decoration: ShapeDecoration(
          color:Color(0xFFC3E9E4),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25)
          ),
          shadows: [
            BoxShadow(
              color: Color(0x33131419),
              blurRadius: 10,
              offset: Offset(0, 0),
              spreadRadius: 2,
            )
          ]
      ),
      child: InkWell(
        //splashColor: Colors.white12.withOpacity(0.9),
        //highlightColor: Colors.white.withOpacity(0.9),
        //splashColor: Colors.cyanAccent.withOpacity(0.4),
        borderRadius: BorderRadius.all(
            Radius.circular(25)
        ),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PageDiagnosis())
        ),
        child: Container(
            //self 박스 안
            child: AspectRatio(
              aspectRatio: 1/1,
              child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 25, top: 28),
                      child: Text('Self Diagnosis',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 26,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 25, top: 60),
                        child: Text(
                            "\n\nLet's test\nIf you have panic disorder",
                            style: TextStyle(
                              color: Color(0xFF111901),
                              fontSize: 17,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,)
                        )
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 245, top: 55),
                      child: Image(image: AssetImage('assets/icon_check.png'),
                          width: 70),
                    )
                  ]
              ),
            )
        ),
      ),
    );
  }
  Widget MoreInfo(){
    return Container(
        margin: EdgeInsets.only(top: 35, left: 35),
        alignment: Alignment.centerLeft,
        child: Text(
          'More Information',
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 26,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        )
    );
  }
  Widget Div(){
    return const Divider(
      height: 1,
      thickness: 0.4,
      indent: 0,
      endIndent: 0,
      color: Color(0xFFC9C9C9),
    );
  }
}
