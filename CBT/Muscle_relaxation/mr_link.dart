import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Mr_link extends StatelessWidget {
  Mr_link({Key? key}) : super(key: key);
  static String youtubeId = 'j6ICKnpn054';
  final YoutubePlayerController _con = YoutubePlayerController(
    initialVideoId: youtubeId,
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
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
                    height: (MediaQuery.of(context).size.height)*0.17
                ),


                //첫번째 텍스트
                Container(
                  alignment: Alignment.centerLeft,
                  //padding: EdgeInsets.only(left: 18),
                  //height: 100,
                  width: (MediaQuery.of(context).size.width),
                  child: Text("\n   근육 이완 운동을\n   영상을 보면서 따라해보세요",
                    style: TextStyle(fontSize: 27,
                        fontFamily: 'Inter', fontWeight: FontWeight.w600,
                        color: Color(0xFF6A9AA5)
                    ),
                    //textAlign: TextAlign.center,
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: (MediaQuery.of(context).size.height)*0.05),
                  // width: (MediaQuery.of(context).size.width),
                  // height: 200,
                  // color: Colors.grey,
                  child: YoutubePlayer(
                    controller: _con,
                  )
                ),
              ],
            )
        )
    );
  }
}
