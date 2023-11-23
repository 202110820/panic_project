import 'package:flutter/material.dart';
import 'package:main/screens/main_screen.dart';
import 'package:flutter_gif/flutter_gif.dart';

class Breathe extends StatefulWidget {
  const Breathe ({Key? key}) : super(key:key);

  @override
  _BreatheState createState() => _BreatheState();
}

class _BreatheState extends State<Breathe> with TickerProviderStateMixin{ //TickerProvider는 애니메이션에 사용되는 Ticker를 생성할 수 있는 메서드인 vsync를 제공하는 인터페이스
  late FlutterGifController controller1;
  Stopwatch stopwatch = Stopwatch()..start();
  //late AssetImage image;

  @override
  void initState(){
    controller1 = FlutterGifController(vsync: this);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      controller1.repeat(
        min:1,
        max:500,
        period: const Duration(seconds: 19),
      );
      print('Elapsed time: ${stopwatch.elapsed.inMilliseconds}');
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('GIF Player'),
          backgroundColor: Color.fromRGBO(98, 183, 183, 1),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios, size: 30, color: Color.fromRGBO(151, 151, 151, 1)), onPressed:() {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => IntroScreen(), //홈 화면으로 이동
              ),
            );
            //Navigator.of(context).popUntil((route) => route.isFirst); //홈 화면으로 이동
          }),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: GifImage(
                  controller: controller1,
                  image: const AssetImage('assets/breathe.gif'),
                )
              ),
            ]
          ),
        ),
      )
    );
  }
}