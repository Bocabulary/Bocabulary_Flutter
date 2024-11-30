import 'package:bookapplication/home/home_screen.dart';
import 'package:bookapplication/login/login_screen.dart';
import 'package:bookapplication/user/kakaologinapi.dart';
import 'package:bookapplication/user/usercontroller.dart';
import 'package:flutter/material.dart';

import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

  // Kakao SDK 초기화
  KakaoSdk.init(
    nativeAppKey: "99863960ef5da56c25d508a0fa2c428c",
    javaScriptAppKey: "f43f257ac042f74f93df2de45788395b",
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
  print(await KakaoSdk.origin);
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
