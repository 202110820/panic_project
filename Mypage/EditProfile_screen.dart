import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart'; //CupertinoDatePicker, CupertinoButton 패키지
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact2/database_service.dart';
import 'package:intl/intl.dart';

import 'myProfile_screen.dart';

const List<String> Genderlist = <String>['Man', 'Woman'];
String dropdownValue = Genderlist.first;

String formatSelectedDay(Timestamp selectedDay) {
  Timestamp timestamp = selectedDay; // Firestore에서 Timestamp 필드 가져오기
  DateTime dateTime = timestamp.toDate(); // Timestamp를 DateTime으로 변환

  return DateFormat('yyyy.MM.dd').format(dateTime);
}

// bool _isEditing = false;
// TextEditingController _nicknameController = TextEditingController();

class EditPage extends StatefulWidget {
  final String email;

  EditPage({required this.email});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white, useMaterial3: true,),
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
            leading: IconButton(icon: Icon(Icons.arrow_back_ios, size: 30, color: Color.fromRGBO(151, 151, 151, 1)), onPressed:() {
              Navigator.pop(
                  context // 마이페이지 화면으로 이동 (이전 화면)
              );
            }),
          ),
          extendBodyBehindAppBar: true,
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.13,),
                  Title(),
                  UserInformation(email: widget.email),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                  UpdateButton(email: widget.email),
                ],
              ),
            ),
          )
      ),
    );
  }
}

// Edit Profile
class Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width * 0.60,
      child: Text('Edit Profile', style: TextStyle(
        color: Color.fromRGBO(106, 154, 165, 1),
        fontSize: 35,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w800,
      ),textAlign: TextAlign.center,),
    );
  }
}

// 정보들
class UserInformation extends StatefulWidget{
  final String email;

  UserInformation({required this.email});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {

  DateTime? tempPickedDate;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getMyPage(widget.email),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty){
          return CircularProgressIndicator();
        }

        // 개인 정보들 표시
        else{
          final documents = snapshot.data!.docs;
          final widgets = documents.map((DocumentSnapshot document) {
            String sex = document['sex'].toString().toLowerCase();
            //_nicknameController.text = document['userID'];
            return Column(
                children: [

                  //사진 아이콘(편하게 남자/여자 로 나눴음..)
                  Container(
                    height: MediaQuery.of(context).size.height * 0.30,
                    width: MediaQuery.of(context).size.width * 0.50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(255, 255, 255, 0.98), // 배경 색상
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey, // 그림자 색상
                          offset: Offset(0, 3), // 그림자의 위치 (수평, 수직)
                          blurRadius: 6, // 그림자의 흐릿한 정도
                          spreadRadius: 5, // 그림자의 확산 정도
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Container(
                        padding: EdgeInsets.all(35),
                        child: Image.asset(
                          'assets/MyPage/${sex}.png',
                          //fit: BoxFit.none,
                        ),
                      ),
                    ),
                  ),

                  // 닉네임
                  Text(
                    '${document['nickname']}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.01,),

                  // 정보들
                  Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: Column(children: [
                        // 성별
                        Container(
                          //color: Colors.grey,
                          height: MediaQuery.of(context).size.height * 0.10,
                          width: MediaQuery.of(context).size.width * 0.90,
                          child: Column(children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text("Sex", style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.90,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: Colors.grey,  // 선의 색상
                                  width: 1.0,            // 선의 두께
                                ),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: DropdownButton<String>(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                value: document['sex'],
                                icon: null, //const Icon(Icons.arrow_drop_down),
                                elevation: 16,
                                style: const TextStyle(color: Colors.black),
                                underline: Container(
                                  //height: MediaQuery.of(context).size.height * 0.05,
                                  width: MediaQuery.of(context).size.width * 0.90,
                                  //color: Colors.grey,
                                ),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    dropdownValue = value!;
                                    document.reference.set({'sex': value,}, SetOptions(merge: true)); // 바뀐 데이터 저장
                                  });
                                },
                                items: Genderlist.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            )

                          ]),),

                        // 생년월일
                        Container(
                          //color: Colors.grey,
                            height: MediaQuery.of(context).size.height * 0.10,
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: Column(children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text("Date of birth", style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                              ),
                              // 생년월일 수정 부분
                              InkWell(
                                onTap: () async {
                                  DateTime? pickedDate = await _selectDate(context, document['birth']);
                                  if (pickedDate != null) {
                                    setState(() {
                                      tempPickedDate = pickedDate;
                                    });
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  alignment: Alignment.centerLeft,
                                  height: MediaQuery.of(context).size.height * 0.05,
                                  width: MediaQuery.of(context).size.width * 0.90,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Text(
                                    '${formatSelectedDay(document['birth'])}', //tempPickedDate ?? document[]
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ])
                        ),

                        // 이메일
                        Container(
                          //color: Colors.grey,
                          height: MediaQuery.of(context).size.height * 0.10,
                          width: MediaQuery.of(context).size.width * 0.90,
                          child: Column(children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text("Email", style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.90,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: Colors.grey,  // 선의 색상
                                  width: 1.0,            // 선의 두께
                                ),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Container(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  width: MediaQuery.of(context).size.width * 0.90,
                                  child: Text('${document['email']}', style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w400))
                              ),
                            )
                          ]),),
                      ],)
                  )
                ]
            );
          }).toList();
          return Column(children: widgets,);
        }
      },
    );
  }
  Future<DateTime?> _selectDate(BuildContext context, Timestamp currentBirthDate) async {
    DateTime? pickedDate = await showModalBottomSheet<DateTime>(
      backgroundColor: ThemeData.light().scaffoldBackgroundColor,
      context: context,
      builder: (context) {
        // DateTime tempPickedDate;
        return Container(
          height: 300,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('취소', style: TextStyle(color: Color.fromRGBO(106, 154, 165, 1), fontFamily: 'Poppins', fontWeight: FontWeight.w500),),
                      onPressed: () {
                        Navigator.of(context).pop();
                        FocusScope.of(context).unfocus();
                      },
                    ),
                    CupertinoButton(
                      child: Text('완료', style: TextStyle(color: Color.fromRGBO(106, 154, 165, 1), fontFamily: 'Poppins', fontWeight: FontWeight.w500),),
                      onPressed: () {
                        Navigator.of(context).pop(tempPickedDate); //데이터 형: DateTime
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  child: CupertinoDatePicker(
                    backgroundColor: ThemeData.light().scaffoldBackgroundColor,
                    minimumYear: 1900,
                    maximumYear: DateTime.now().year,
                    initialDateTime: currentBirthDate.toDate(),
                    maximumDate: DateTime.now(),
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime dateTime) {
                      tempPickedDate = dateTime;
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (pickedDate != null && pickedDate != currentBirthDate.toDate()) {
      // Firebase에 데이터 업데이트
      await updateBirthDate(pickedDate);
      return pickedDate;
    }

    return null;
  }

  Future<void> updateBirthDate(DateTime newBirthDate) async {
    // Firebase에서 해당 이메일을 가진 문서 찾기
    final QuerySnapshot<Map<String, dynamic>> userQuery = await FirebaseFirestore.instance
        .collection('Mypage')
        .where("email", isEqualTo: widget.email)
        .get();

    // 쿼리 결과에서 문서 가져오기
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents = userQuery.docs;

    if (documents.isNotEmpty) {
      // 문서가 존재하면 첫 번째 문서의 참조를 얻어서 birth_date 업데이트
      final DocumentReference<Map<String, dynamic>> userReference = documents.first.reference;

      await userReference.update({'birth': newBirthDate}).then((value) {
        print('Birth date successfully updated!');
      }).catchError((error) {
        print('Error updating birth date: $error');
      });
    } else {
      print('No documents found for the given email.');
    }
  }
}

//Update 버튼
class UpdateButton extends StatefulWidget{
  final String email;

  UpdateButton({required this.email});

  @override
  State<UpdateButton> createState() => _UpdateButtonState();
}
class _UpdateButtonState extends State<UpdateButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromRGBO(98, 183, 183, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        minimumSize: Size(MediaQuery.of(context).size.width * 0.80, MediaQuery.of(context).size.height * 0.06),
      ),
      onPressed: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Myprofile(email: widget.email)));
      },
      child: Text('Update',
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}