import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:path/path.dart';



class KakaoLoginApi {
  Future<User?> signWithKakao(BuildContext context) async {
    final UserApi api = UserApi.instance;
    try {
      if (await isKakaoTalkInstalled()) {
        await api.loginWithKakaoTalk();
      } else {
        await api.loginWithKakaoAccount();
      }
      Navigator.pushReplacementNamed(context, '/mypage');
      return await api.me(); // 사용자 정보를 반환
    } catch (error) {
      print('카카오 로그인 실패: $error');
      return null;
    }
  }
}

