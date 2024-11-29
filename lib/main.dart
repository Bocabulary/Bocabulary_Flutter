import 'package:bookapplication/home/home_screen.dart';

import 'package:bookapplication/library/search_sub.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'library/search_screen.dart';
import 'package:bookapplication/login/login_screen.dart';
import 'package:bookapplication/mypage/mypage_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: "896d75d960f3df2e239b38c2eb220039",
    javaScriptAppKey: "6cd5b407e4dc629bed984fb6399f17c3",
  );
  // await initializeDateFormatting();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너 비활성화
      initialRoute: '/', // 초기 라우트 (로그인 화면)
      routes: {
        '/': (context) => const LoginScreen(), // 로그인 페이지
        '/main': (context) => const HomeScreen(), // 메인 페이지
      },
      // home: HomeScreen(),
    )
  );
}

