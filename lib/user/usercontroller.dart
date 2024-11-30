// import 'package:bookapplication/user/kakaologinapi.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
//
// class UserController with ChangeNotifier {
//   User? _user;
//   KakaoLoginApi kakaoLoginApi;
//   User? get user => _user;
//
//   UserController({required this.kakaoLoginApi});
//
//
//   // 카카오 로그인
//   void kakaoLogin(BuildContext context) async {
//     kakaoLoginApi.signWithKakao(context).then((user) {
//       // 반환된 값이 NULL이 아니라면
//       // 정보 전달
//       if (user != null) {
//         _user = user;
//         notifyListeners();
//       }
//     });
//     }
// }