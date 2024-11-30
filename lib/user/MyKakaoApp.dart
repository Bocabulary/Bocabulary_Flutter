import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'App.dart';
import 'kakaoUserController.dart';
import 'kakaoapi.dart';


class MyKakaoApp extends StatelessWidget {
  const MyKakaoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserController(
        kakaoLoginApi: KakaoLoginApi(),
      ),
      child: const MaterialApp(
        home: App(),
      ),
    );
  }
}