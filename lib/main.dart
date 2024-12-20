import 'package:bookapplication/home/home_screen.dart';
import 'package:bookapplication/library/search_screen.dart';
import 'package:bookapplication/login/login_screen.dart';
import 'package:bookapplication/mypage/mypage_screen.dart';
import 'package:bookapplication/user/kakaologinapi.dart';
import 'package:bookapplication/user/usercontroller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      child: const MyApp(),
    ),
  );
  print(await KakaoSdk.origin);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: Mypage.themeNotifier,
        builder: (context, themeMode, child) {
      return MaterialApp(
        title: '북어사전',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: themeMode,
        debugShowCheckedModeBanner: false,
        initialRoute: '/', // 초기 라우트 설정
        routes: {
          '/': (context) => const LoginScreen(), // 로그인 페이지
          '/main': (context) => const HomeScreen(), // 메인 페이지
          '/search': (context) => const SearchScreen(), // 메인 페이지
          '/mypage': (context) {
            final userController = Provider.of<UserController>(context);
            final user = userController.user;

            // user가 null일 경우 로그인 화면으로 리디렉션
            if (user == null) {
              return const LoginScreen();
          }

          // user가 null이 아닌 경우에만 MypageScreen으로 이동
          return MypageScreen(user: user);
        },
      },
      );
      },
    );
  }
}
