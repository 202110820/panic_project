import 'package:contact2/Self_Diagnosis/SelfDiagnosis.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'mypage.dart';
import 'map.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';

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

import 'main_split.dart';

void main() {
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
    HomeScreen(),
    HomeScreen(),
    Mypage()
  ];

  void _onNavTapped(int index){
    setState((){
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            items: const[
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
    );
  }
}