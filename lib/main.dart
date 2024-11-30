import 'package:bookapplication/home/home_screen.dart';
import 'package:bookapplication/login/login_screen.dart';
import 'package:bookapplication/user/kakaologinapi.dart';
import 'package:bookapplication/user/usercontroller.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Kakao SDK 초기화
  KakaoSdk.init(
    nativeAppKey: "896d75d960f3df2e239b38c2eb220039",
    javaScriptAppKey: "6cd5b407e4dc629bed984fb6399f17c3",
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserController>(
          create: (_) => UserController(
            kakaoLoginApi: KakaoLoginApi(),
          ),
        ),
      ],
      child: const MyApp(), // MultiProvider 아래에 MaterialApp 배치
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너 비활성화
      initialRoute: '/', // 초기 라우트 설정
      routes: {
        '/': (context) => const LoginScreen(), // 로그인 페이지
        '/main': (context) => const HomeScreen(), // 메인 페이지
      },
    );
  }
}
