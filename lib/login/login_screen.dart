import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// class MyLogin extends StatelessWidget {
//   const MyLogin({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => UserController(
//         kakaoLoginApi: KakaoLoginApi(),
//       ),
//       child: const MaterialApp(
//         home: LoginScreen(),
//       ),
//     );
//   }
// }

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) :super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            logoTitle(),
            SizedBox(height: 50),
            kakaoLogin(),
          ],
        ),
      ),
    );
  }

  Widget logoTitle () {
    return Center(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.local_library, size: 100,
            color: Colors.brown[600],
          ),
          Text(
            '북어사전',
            style: TextStyle(
              fontSize: 40,
            ),
          ),
        ]
      ),
    );
  }

  Widget kakaoLogin () {
    return Center(

    );
  }
}