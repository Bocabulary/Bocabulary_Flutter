// import 'dart:io';
//
// import 'package:bookapplication/user/kakaologinapi.dart';
// import 'package:bookapplication/user/usercontroller.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
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
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) :super(key: key);
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
//
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             logoTitle(),
//             SizedBox(height: 50),
//             kakaoLogin(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget logoTitle () {
//     return Center(
//       child: Column(
//         // mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.local_library, size: 100,
//             color: Colors.brown[600],
//           ),
//           Text(
//             '북어사전',
//             style: TextStyle(
//               fontSize: 40,
//             ),
//           ),
//         ]
//       ),
//     );
//   }
//
//   Widget kakaoLogin () => Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: GestureDetector(
//       // 카카오 로그인을 위한 메소드
//         onTap: () {
//           context.read<UserController>().kakaoLogin;
//           KakaoLoginApi().signWithKakao(context); // context 전달
//         },
//         child: Image.asset("assets/image/kakao_login_medium_narrow.png")),
//   );
// }
//
