import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'myProfile_screen.dart';
import 'SignUp.dart';
import 'package:contact2/main.dart';

import 'package:contact2/model/model_auth.dart';
import 'package:contact2/model/model_login.dart';


void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

// Login 화면
class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider(
        create: (_) => LoginModel(),
        child: MaterialApp(
            theme: ThemeData(scaffoldBackgroundColor: Colors.white, useMaterial3: true,),
            home: Scaffold(
                resizeToAvoidBottomInset : false, //키보드 bottom overflow 방지
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  elevation: 0,
                  leading: IconButton(icon: Icon(Icons.arrow_back_ios, size: 30, color: Color.fromRGBO(151, 151, 151, 1)), onPressed:() {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyApp(), //메인 화면으로 이동
                      ),
                    );
                  }),
                ),
                extendBodyBehindAppBar: true,
                body: Center(
                    child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * 0.15,),
                          LoginTitle(),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.15,),

                          EmailInput(),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                          PasswordInput(),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                          LoginButton(),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                          JoinButton(),
                        ]
                    )
                )
            )
        )
    );
  }
}

class LoginTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.10,
      width: MediaQuery.of(context).size.width * 0.90,
      child: Text('My Page', style: TextStyle(
        color: Color.fromRGBO(106, 154, 165, 1),
        fontSize: 35,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w800,
      ),textAlign: TextAlign.center,),
    );
  }
}

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final login = Provider.of<LoginModel>(context, listen: false);
    return Container(
      width: MediaQuery.of(context).size.width * 0.80,
      child: TextField(
        maxLines: 1,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            labelText: 'Email'
        ),
        onChanged: (email){
          login.setEmail(email);
        },
        keyboardType: TextInputType.text,
      ),
    );
  }
}

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final login = Provider.of<LoginModel>(context, listen: false);
    return Container(
      width: MediaQuery.of(context).size.width * 0.80,
      child: TextField(
        obscureText: true, //비밀번호 안 보이도록
        maxLines: 1,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            labelText: 'Password'
        ),
        onChanged: (password){
          login.setPassword(password);
        },
        keyboardType: TextInputType.text,
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authClient = Provider.of<UserAuthProvider>(context, listen: false);
    final login = Provider.of<LoginModel>(context, listen: false);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromRGBO(98, 183, 183, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        minimumSize: Size(MediaQuery.of(context).size.width * 0.40, MediaQuery.of(context).size.height * 0.06),
      ),
      child: Text('Login', style: TextStyle(
        fontSize: 15,
        color: Colors.white,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
      ), textAlign: TextAlign.center,),
      onPressed: () async {
        await authClient
            .loginWithEmail(login.email, login.password)
            .then((loginStatus) {
          if (loginStatus == AuthStatus.loginSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  content:
                  Text('welcome! ' + authClient.user!.email! + ' ')));
            print('${authClient.user!.email!}');
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Myprofile(email: authClient.user!.email!))); //이메일 정보 전달 & 마이 페이지 창으로 이동
          } else {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text('login fail')));
          }
        });
      },
    );
  }
}

class JoinButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromRGBO(98, 183, 183, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        minimumSize: Size(MediaQuery.of(context).size.width * 0.40, MediaQuery.of(context).size.height * 0.06),
      ),
      child: Text('Join', style: TextStyle(
        fontSize: 15,
        color: Colors.white,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
      ), textAlign: TextAlign.center,),
    );
  }
}