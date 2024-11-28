import 'package:bookapplication/home/home_screen.dart';
import 'package:bookapplication/mypage/mypage_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  runApp(
    MaterialApp(

      home: MypageScreen(),
      // home: HomeScreen(),
    )
  );
}

