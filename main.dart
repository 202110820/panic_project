import 'package:flutter/material.dart';
import 'mypage.dart';
import 'map.dart';
import 'map/map_main.dart';
import 'package:provider/provider.dart';
import 'main_split.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:contact2/firebase_options.dart';
import 'firebase_options.dart';
import 'package:contact2/Mypage/splash_screen.dart';
import 'package:contact2/Diary/check_login_status.dart';
import 'package:contact2/map/check_login_status.dart';
import 'package:contact2/model/model_auth.dart';
import 'package:contact2/information/What_is_panic_disorder/pd_1.dart';
// ...

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserAuthProvider()),
      ],

      child: MaterialApp(
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
                    icon: Icon(Icons.heart_broken),
                    label: "Diagnosis"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_month),
                    label: "Diary"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.map_outlined),
                    label: "My Map"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: "My Page"),
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
