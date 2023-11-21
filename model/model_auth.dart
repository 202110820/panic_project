import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart'; //shared_preferences에 로그인 했다는 정보를 기록하기 위한 패키지

enum AuthStatus {
  registerSuccess,
  registerFail,
  loginSuccess,
  loginFail
}

// client를 통해 파이어 베이스에 연결
class UserAuthProvider with ChangeNotifier { 
  FirebaseAuth authClient;
  User? user;

  UserAuthProvider({auth}) : authClient = auth ?? FirebaseAuth.instance;

  // 회원가입 (with Email) (AuthStatus를 통해 응답 받음)
  Future<AuthStatus> registerWithEmail(String email, String password) async {
    try {
      UserCredential credential = await authClient.createUserWithEmailAndPassword(email: email, password: password);
      return AuthStatus.registerSuccess;
    } catch (e) {
      return AuthStatus.registerFail;
    }
  }

  // 로그인
  Future<AuthStatus> loginWithEmail(String email, String password) async {
    try {
      await authClient.signInWithEmailAndPassword(email: email, password: password).then(
          (credential) async {
            user = credential.user;
            SharedPreferences prefs = await SharedPreferences.getInstance(); // 로그인 정보 저장
            prefs.setBool('isLogin', true);
            prefs.setString('email', email);
            prefs.setString('password', password);
          }
      );
      return AuthStatus.loginSuccess;
    } catch (e) {
      return AuthStatus.loginFail;
    }
  }

  // 로그아웃
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', false);
    prefs.setString('email', '');
    prefs.setString('password', '');
    user = null;
    await authClient.signOut(); // logout
  }
}