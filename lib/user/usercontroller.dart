import 'package:bookapplication/user/kakaologinapi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

class UserController with ChangeNotifier {
  User? _user;
  KakaoLoginApi kakaoLoginApi;
  User? get user => _user;
  FirebaseFirestore db=FirebaseFirestore.instance;





  UserController({required this.kakaoLoginApi});

  // 카카오 로그인
  void kakaoLogin(BuildContext context) async {

    CollectionReference userRef=db.collection("users");


    kakaoLoginApi.signWithKakao(context).then((user) async {
      // 반환된 값이 NULL이 아니라면
      // 정보 전달
      if (user != null) {
        _user = user;
        print(_user);
        DocumentReference documentRef= await userRef.add(userToFirebase(_user!));
        notifyListeners();
      }
    });
    }

  Map<String,dynamic> userToFirebase(User user) {
    Map<String,dynamic> fireBase={
      'id':user.id,
      'nickname':user.properties?['nickname'],
      'thumbnail_image':user.properties?['thumbnail_image'],
      'name':user.kakaoAccount?.name,
      'email':user.kakaoAccount?.email,
      'phone_number':user.kakaoAccount?.phoneNumber


    };
    return fireBase;
  }
}