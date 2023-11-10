import 'package:flutter/material.dart';


class Mr_link extends StatelessWidget {
  const Mr_link({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  iconSize: 30,
                  color: Color.fromRGBO(151, 151, 151, 1),
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }),
            ),
            extendBodyBehindAppBar: true,
            body: Column(
              children: [
                //뒤로가기랑 텍스트 빈 공간
                Container(
                    height: 130
                ),


                //첫번째 텍스트
                Container(
                  alignment: Alignment.center,
                  //padding: EdgeInsets.only(left: 18),
                  //height: 100,
                  width: (MediaQuery.of(context).size.width),
                  child: Text("Let's start\nwith this vedio",
                    style: TextStyle(fontSize: 37,
                        fontFamily: 'Inter', fontWeight: FontWeight.w600,
                        color: Color(0xFF6A9AA5)
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: (MediaQuery.of(context).size.width),
                  height: 200,
                  color: Colors.grey,
                ),

                // 텍스트
                Container(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                    margin: EdgeInsets.only(left:15, right: 15, top: 20,bottom: 10),

                    child: Center(
                      child: Text("Follow this link",
                        style: TextStyle(fontSize: 16,
                            fontFamily: 'Inter', fontWeight: FontWeight.w600,
                        color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    )
                ),


                //첫줄 버튼
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.all(
                          Radius.circular(5)
                      ),
                      onTap: (){
                        {
                        }
                      },
                      child: Container(
                          width: (MediaQuery.of(context).size.width)*0.4,
                          height:  (MediaQuery.of(context).size.height)*0.1,

                          decoration: ShapeDecoration(
                              color:Color(0xFFD9E6E9),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)
                              ),
                              shadows: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 8,
                                  offset: Offset(0, 0),
                                  spreadRadius: 1,
                                )
                              ]
                          ),

                          child: Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 15, top: 17),
                                  child: Text('link 1',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 100, top: 30),
                                  child: Image(image: AssetImage('assets/mrlink.png'),
                                      width: 70),
                                )
                              ]
                          )
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.all(
                          Radius.circular(5)
                      ),
                      onTap: (){

                      },
                      child: Container(
                        //padding: EdgeInsets.only(left:30),
                        // margin: EdgeInsets.only(top: 10),
                          width: (MediaQuery.of(context).size.width)*0.4,
                          height:  (MediaQuery.of(context).size.height)*0.1,

                          decoration: ShapeDecoration(
                              color:Color(0xFFC4D9DD),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)
                              ),
                              shadows: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 8,
                                  offset: Offset(0, 0),
                                  spreadRadius: 1,
                                )
                              ]
                          ),

                          child: Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 15, top: 17),
                                  child: Text('link 2',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 100, top: 30),
                                  child: Image(image: AssetImage('assets/mrlink.png'),
                                      width: 70),
                                )
                              ]
                          )
                      ),
                    ),
                  ],
                ),
                Container(height: 24,),
                //2번째 줄 버튼
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.all(
                          Radius.circular(5)
                      ),
                      onTap: (){
                      },
                      child: Container(
                          width: (MediaQuery.of(context).size.width)*0.4,
                          height:  (MediaQuery.of(context).size.height)*0.1,

                          decoration: ShapeDecoration(
                              color:Color(0xFFBDD4D9),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)
                              ),
                              shadows: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 8,
                                  offset: Offset(0, 0),
                                  spreadRadius: 1,
                                )
                              ]
                          ),

                          child: Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 15, top: 17),
                                  child: Text('link 3',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 100, top: 30),
                                  child: Image(image: AssetImage('assets/mrlink.png'),
                                      width: 70),
                                )
                              ]
                          )
                      ),

                    ),


                    InkWell(
                      borderRadius: BorderRadius.all(
                          Radius.circular(5)
                      ),
                      onTap: (){},
                      child: Container(
                        //padding: EdgeInsets.only(left:30),
                        // margin: EdgeInsets.only(top: 10),
                          width: (MediaQuery.of(context).size.width)*0.4,
                          height:  (MediaQuery.of(context).size.height)*0.1,

                          decoration: ShapeDecoration(
                              color:Color(0xFFA1B9BE),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)
                              ),
                              shadows: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 8,
                                  offset: Offset(0, 0),
                                  spreadRadius: 1,
                                )
                              ]
                          ),

                          child: Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 15, top: 17),
                                  child: Text('link 4',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 100, top: 30),
                                  child: Image(image: AssetImage('assets/mrlink.png'),
                                      width: 70),
                                )
                              ]
                          )
                      ),
                    ),
                  ],
                ),
              ],
            )
        )
    );
  }
}