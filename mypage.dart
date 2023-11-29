import 'package:flutter/material.dart';

class Mypage extends StatelessWidget{
  const Mypage({Key? key}) : super(key:key);
  //const Mypage({super.key});
  @override
  Widget build(BuildContext context) {
    final name = ModalRoute.of(context)!.settings.arguments;

    return MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
        ),
      home: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Text('profile',style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),),
            leading: IconButton(
              icon: Icon(Icons.arrow_circle_left),
              color: Colors.white,
              iconSize: 40,
              onPressed: (){
                Navigator.pop(context);
              },
            ),
        ),
        extendBodyBehindAppBar: true,
        body: Container(
            color: Color(0xFF87D8B6),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.22),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.78,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(40), topRight:Radius.circular(40)),
                  )
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height*0.15,
                left:  (MediaQuery.of(context).size.width-110)*0.5,
                child: Container(
                    width: 110, height: 110,
                    decoration: ShapeDecoration(
                      //color: Colors.teal,
                      color: Color(0xFFD9D9D9),
                      shape: OvalBorder(),
                      )
                    ),
                ),
              Positioned(
                top: MediaQuery.of(context).size.height*0.16,
                left:  (MediaQuery.of(context).size.width-110)*0.57,
                child: Image.asset('assets/profile.png', width: 70)
              ),
              Positioned(
                top: MediaQuery.of(context).size.height*0.33,
                  left: (MediaQuery.of(context).size.width)*0.25,
                child: Container(
                  width: 200,
                  height: 200,
                    child: Text('${name}', style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                        textAlign: TextAlign.center)),
                  ),
            ],
          ),
        ),

      )
    );
  }
}