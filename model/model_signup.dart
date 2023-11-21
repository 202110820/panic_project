import 'package:flutter/material.dart';

// 개인정보가 변경될 때마다 set 메서드를 통해 Provider를 이용하여 상태변화값을 알리는 RegisterModel

class RegisterModel extends ChangeNotifier {
  String name = '';
  DateTime birth_date = DateTime.now();
  String sex = '';
  String Usernickname = ''; //userID
  String email = '';
  String password = '';
  String passwordConfirm = '';

  void setName(String name){
    this.name = name;
    notifyListeners(); //상태 변경 사항 브로트 캐스팅
  }
  void setBirtyday(DateTime birth_date) {
    this.birth_date = birth_date;
    notifyListeners();
  }

  void setSex(String sex) {
    this.sex = sex;
    notifyListeners();
  }
  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setNickname(String Usernickname) {
    this.Usernickname = Usernickname;
    notifyListeners();
  }
  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  void setPasswordConfirm(String passwordConfirm) {
    this.passwordConfirm = passwordConfirm;
    notifyListeners();
  }
}

