import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

final FirebaseFirestore firestore = FirebaseFirestore.instance; // DB 인스턴스

CollectionReference MindCalendarCollection = firestore.collection('MindCalendar'); // MindCalendar 컬렉션
CollectionReference MyPageCollection = firestore.collection('MyPage'); // MyPage 컬렉션
CollectionReference MyMapCollection = firestore.collection('MyMap'); // MyMap 컬렉션

// 캘린더 데이터 저장 메소드
void addCalendar(DateTime recordDate, String diary, String emotion, String temperature, String email){
  MindCalendarCollection.add({
    'date': recordDate, //기록 날짜 저장
    'diary': diary, //일기 저장
    'emotion': emotion, //감정 저장
    'temperature': temperature, //마음 온도 저장 
    'userID': email, // 유저 이메일 저장
  }).then((value) => print('Calendar Data added'));
}

// 캘린더 데이터 조회 메소드
Stream<QuerySnapshot> getCalendar(DateTime recordDate, String userEmail){
  return MindCalendarCollection.where("date", isEqualTo: recordDate).where("userID", isEqualTo: userEmail).snapshots();
}

// #############################################################

// MyPage 데이터 저장 메소드
void addMyPage(DateTime birthDate, String email, String username, String password, String gender, String userID){
  MyPageCollection.add({
    'birth_date': birthDate, //생년월일 저장
    'email': email, //이메일 저장
    'name': username, //이름 저장
    'password': password, //비밀번호 저장
    'sex': gender, //성별 저장
    'userID': userID, // 고유 userID 저장
  }).then((value) => print('MyPage Data added'));
}

// MyPage 데이터 조회 메소드
Stream<QuerySnapshot> getMyPage(String email){
  return MyPageCollection.where("email", isEqualTo: email).snapshots();
}

// #############################################################

// MyMap 데이터 저장 메소드
void addMyMap(GeoPoint location, DateTime recordDate, String userID){
  MyMapCollection.add({
    'time': recordDate, //시간 저장
    'list_locations': location, //장소 저장
    'userID': userID, //고유 ID 저장
  }).then((value) => print('My Map Data added'));
}

// MyMap 데이터 조회 메소드
Stream<QuerySnapshot> getMyMap(DateTime userID){
  return MyMapCollection.where("userID", isEqualTo: userID).snapshots();
}



class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  // FOR EVERY FUNCTION HERE
  // POP THE ROUTE USING: Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);

  // GET USER DATA
  // using null check operator since this method should be called only
  // when the user is logged in
  User get user => _auth.currentUser!;

  // STATE PERSISTENCE STREAM
  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();
  // OTHER WAYS (depends on use case):
  // Stream get authState => FirebaseAuth.instance.userChanges();
  // Stream get authState => FirebaseAuth.instance.idTokenChanges();
  // KNOW MORE ABOUT THEM HERE: https://firebase.flutter.dev/docs/auth/start#auth-state

  // EMAIL SIGN UP
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await sendEmailVerification(context);
    } on FirebaseAuthException catch (e) {
      // if you want to display your own custom error message
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      showSnackBar(
          context, e.message!); // Displaying the usual firebase error message
    }
  }

  // EMAIL LOGIN
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!user.emailVerified) {
        await sendEmailVerification(context);
        // restrict access to certain things using provider
        // transition to another page instead of home screen
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    }
  }

  // EMAIL VERIFICATION (검증)
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, 'Email verification sent!');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Display error message
    }
  }

  // SIGN OUT
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    }
  }

  // DELETE ACCOUNT
  Future<void> deleteAccount(BuildContext context) async {
    try {
      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
      // if an error of requires-recent-login is thrown, make sure to log
      // in user again and then delete account.
    }
  }
}