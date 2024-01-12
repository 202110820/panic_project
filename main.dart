import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main_split.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:contact2/firebase_options.dart';
import 'firebase_options.dart';
import 'package:contact2/Mypage/splash_screen.dart';
import 'package:contact2/Diary/check_login_status.dart';
import 'package:contact2/map/check_login_status.dart';
import 'package:contact2/model/model_auth.dart';

// ...
import 'package:flutter/services.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( // firebase 초기화
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyApp> with TickerProviderStateMixin {
  int _selectedIndex = 0;

  final List<Widget> _navIndex = [
    Main_Split(),
    LoginCalendarScreen(),
    LoginMapScreen(),
    SplashScreen()
  ];

  void _onNavTapped(int index){
    setState((){
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserAuthProvider()),
      ],

      child: MaterialApp(

        debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
          ),
          home: Scaffold(
            body: _navIndex[_selectedIndex],
            //네이게이터 부분
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onNavTapped,
              type: BottomNavigationBarType.fixed,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.volunteer_activism_rounded),
                    label: "자가진단"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_month),
                    label: "마음 일기"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.map_outlined),
                    label: "마이 맵"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: "마이페이지"),
              ],
              selectedItemColor: Colors.black,
              selectedLabelStyle: TextStyle(color: Colors.black),
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              unselectedLabelStyle: TextStyle(color: Colors.black),
            ),
          )
      ),
    );
  }
}
