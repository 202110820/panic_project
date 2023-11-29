import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_gif/flutter_gif.dart';

class AnimatedSizeScreen extends StatefulWidget{
  @override
  _Be_heart createState() => _Be_heart();
}

class _Be_heart extends State<AnimatedSizeScreen> with TickerProviderStateMixin{
  late FlutterGifController controller1;

  @override
  void initState(){
    controller1 = FlutterGifController(vsync: this);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      controller1.repeat(
        min:1,
        max:500,
        period: const Duration(seconds: 19),
      );
      super.initState();
    });
  }

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
                  onPressed:() {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }),
            ),
            extendBodyBehindAppBar: true,
            body: Column(
              children: [
                //뒤로가기랑 텍스트 빈 공간
                Container(
                    height: 100
                ),
                //첫번째 텍스트
                Container(
                  alignment: Alignment.center,
                  //padding: EdgeInsets.only(left: 18),
                  //height: 100,
                  width: (MediaQuery.of(context).size.width),
                  child: Text('Breath with\nthis heart',
                    style: TextStyle(fontSize: 37,
                        fontFamily: 'Inter', fontWeight: FontWeight.w600,
                        color: Color(0xFF6A9AA5)
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  height: 30,
                ),
                GifImage(
                  controller: controller1,
                  image: const AssetImage('assets/breathe.gif'),
                ),
              ]
            )
        )
    );
  }
}