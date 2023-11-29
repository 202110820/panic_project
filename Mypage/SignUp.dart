import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; //LengthLimitingTextInputFormatter(12), HapticFeedback 패키지
import 'package:flutter/cupertino.dart'; //CupertinoDatePicker, CupertinoButton 패키지
import 'package:contact2/database_service.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:contact2/model/model_auth.dart';
import 'package:contact2/model/model_signup.dart';

import 'package:contact2/Mypage/login_screen.dart';


final _usernameController = TextEditingController();
final _emailController = TextEditingController();
final _nicknameController = TextEditingController();
final _passwordController = TextEditingController();
final _passwordConfirmController = TextEditingController();

const List<String> Genderlist = <String>['Man', 'Woman'];

final _BirthdayController = TextEditingController();

DateTime? tempPickedDate;
DateTime _selectedDate = DateTime.now();

class SignUpScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider(
        create: (_) => RegisterModel(),
        child: MaterialApp(
            theme: ThemeData(
              useMaterial3: true,
            ),
            home: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  elevation: 0,
                  leading: IconButton(icon: Icon(Icons.arrow_back_ios, size: 30, color: Color.fromRGBO(151, 151, 151, 1)), onPressed:() {
                    Navigator.pop(
                        context // 로그인 화면으로 이동 (이전 화면)
                    );
                  }),
                ),
                extendBodyBehindAppBar: true,
                body: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                        // title
                        Container(
                          height: MediaQuery.of(context).size.height * 0.09,
                          width: MediaQuery.of(context).size.width * 0.40,
                          child: Text('Sign Up', style: TextStyle(
                            color: Color.fromRGBO(106, 154, 165, 1),
                            fontSize: 35,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),textAlign: TextAlign.center,),
                        ),

                        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                        NameInput(),

                        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                        NicknameInput(),

                        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                        GenderDropdownButton(),

                        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                        Birthday(),

                        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                        EmailInput(),

                        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                        PasswordInput(),

                        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                        PasswordConfirmInput(),

                        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                        JoinButton(),

                        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                      ],
                    )
                )
            )
        )
    );
  }
}

class NameInput extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final register = Provider.of<RegisterModel>(context, listen: false);
    return Container(
        child: Column(children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Text("Name", style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
          ),
          Container(
            //padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            width: MediaQuery.of(context).size.width * 0.85,
            child: TextField(
              controller: _usernameController,
              maxLines: 1,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                hintText: '본인의 이름을 작성해주세요',
                isCollapsed: true,
              ),
              onChanged: (name){
                register.setName(name);
              },
            ),
          ),
        ],)
    );
  }
}
class EmailInput extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final register = Provider.of<RegisterModel>(context, listen: false);
    return Container(
        child: Column(children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Text("Email", style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
          ),
          Container(
            //padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            width: MediaQuery.of(context).size.width * 0.85,
            child: TextField(
              controller: _emailController,
              maxLines: 1,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                hintText: '이메일을 작성해주세요',
                isCollapsed: true,
              ),
              onChanged: (email){
                register.setEmail(email);
              },
            ),
          ),
        ],)
    );
  }
}
class NicknameInput extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final register = Provider.of<RegisterModel>(context, listen: false);
    return Container(
        child: Column(children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Text("Nickname", style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
          ),
          Container(
            //padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            width: MediaQuery.of(context).size.width * 0.85,
            child: TextField(
              controller: _nicknameController,
              maxLines: 1,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                hintText: '사용될 닉네임을 작성해주세요',
                isCollapsed: true,
              ),
              onChanged: (Usernickname){
                register.setNickname(Usernickname);
              },
            ),
          ),
        ],)
    );
  }
}
class PasswordInput extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final register = Provider.of<RegisterModel>(context);
    return Container(
        child: Column(children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Text("Password", style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
          ),
          Container(
            //padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            width: MediaQuery.of(context).size.width * 0.85,
            child: TextField(
              controller: _passwordController,
              //onChanged: (password) {},
              obscureText: true,
              maxLines: 1,

              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                hintText: '최대 12자리를 입력해주세요',
                isCollapsed: true,
                errorText: register.password != register.passwordConfirm ? 'Password incorrect' : null,
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(12), // 최대 길이 설정
              ],
              onChanged: (password){
                register.setPassword(password);
              },
            ),
          ),
        ],)
    );
  }
}

class PasswordConfirmInput extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final register = Provider.of<RegisterModel>(context, listen: false);
    return Container(
        child: Column(children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Text("Password Confirm", style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
          ),
          Container(
            //padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            width: MediaQuery.of(context).size.width * 0.85,
            child: TextField(
              controller: _passwordConfirmController,
              obscureText: true,
              maxLines: 1,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                hintText: '비밀번호를 다시 한 번 입력해주세요',
                isCollapsed: true,
              ),
              onChanged: (passwordConfirm) {
                register.setPasswordConfirm(passwordConfirm);
              },
            ),
          ),
        ],)
    );
  }
}

class GenderDropdownButton extends StatefulWidget{
  const GenderDropdownButton ({super.key});

  @override
  State<GenderDropdownButton> createState() => _GenderDropdownButtonState();
}

class _GenderDropdownButtonState extends State<GenderDropdownButton> {
  String dropdownValue = Genderlist.first;

  @override
  Widget build(BuildContext context) {
    final register = Provider.of<RegisterModel>(context, listen: false);
    return Container(
      child: Column(children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
          child: Text("Sex", style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
        ),
        DropdownButton<String>(
          //alignment: Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(0, 0, 260, 0),
          value: dropdownValue,
          icon: const Icon(Icons.arrow_drop_down),
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          underline: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: 0.9,
            color: Colors.black,
          ),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
              register.setSex(value);
            });
          },
          items: Genderlist.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ]),);
  }
}

class Birthday extends StatefulWidget{
  const Birthday ({super.key});

  @override
  State<Birthday> createState() => _BirthdayState();
}

class _BirthdayState extends State<Birthday> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          HapticFeedback.mediumImpact();
          _selectDate();
        },
        child: Container(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Date of birth", style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w500),),
              TextFormField(
                enabled: false,
                decoration: const InputDecoration(
                  hintText: '생년월일을 입력하세요',
                  isCollapsed: true,
                  isDense: true,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black), // 원하는 색상으로 변경
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black), // 포커스 시 색상 변경
                  ),
                ),
                controller: _BirthdayController,
              )
            ],)
        )
    );
  }
  _selectDate() async {
    final register = Provider.of<RegisterModel>(context, listen: false);
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
                        Navigator.of(context).pop(tempPickedDate);
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
                    initialDateTime: DateTime.now(),
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

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _BirthdayController.text = pickedDate.toString();
        register.setBirtyday(pickedDate);
        convertDateTimeDisplay(_BirthdayController.text);
      });
    }
  }

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    return _BirthdayController.text = serverFormater.format(displayDate);
  }
}

class JoinButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authClient = Provider.of<UserAuthProvider>(context, listen: false);
    final register = Provider.of<RegisterModel>(context);
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.05,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromRGBO(98, 183, 183, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text('Join', style: TextStyle(
          fontSize: 15,
          color: Colors.white,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
        ), textAlign: TextAlign.center,),

        onPressed: (register.password != register.passwordConfirm) ? null : () async {
          await authClient.registerWithEmail(register.email, register.password).then((registerStatus) {
            if (registerStatus == AuthStatus.registerSuccess) {

              //데이터 추가
              addMyPage(register.birth_date, register.email, register.name, register.password, register.sex, register.Usernickname);

              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text('Regist Success')),
                );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(), // 홈 화면으로
                ),
              );
            } else {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text('Regist Fail')),
                );
            }
          });
        },
      ),
    );
  }
}