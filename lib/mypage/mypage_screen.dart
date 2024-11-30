import 'dart:io';

import 'package:bookapplication/user/usercontroller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';

class Mypage extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    // ThemeMode가 변경될 때마다 디버그 로그 출력
    themeNotifier.addListener(() {
      debugPrint('ThemeNotifier updated: ${themeNotifier.value}');
    });

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, themeMode, child) {
        return Consumer<UserController>(
          builder: (context, userController, child) {
            // UserController에서 로그인된 사용자 정보 가져오기
            User? user = userController.user;

            return MaterialApp(
              title: "북어사전",
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              debugShowCheckedModeBanner: false,
              themeMode: themeMode,
              home: Scaffold(
                appBar: AppBar(
                  title: Text('마이페이지'),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.light_mode),
                      onPressed: () {
                        // 테마를 light로 변경
                        themeNotifier.value = ThemeMode.light;
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.dark_mode),
                      onPressed: () {
                        // 테마를 dark로 변경
                        themeNotifier.value = ThemeMode.dark;
                      },
                    ),
                  ],
                ),
                body: user == null // 로그인되지 않으면
                    ? Center(child: Text('로그인되지 않았습니다.'))
                    : MypageScreen(user: user), // 로그인된 사용자의 정보를 전달
              ),
            );
          },
        );
      },
    );
  }
}

class MypageScreen extends StatefulWidget {
  final User user;

  const MypageScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<MypageScreen> createState() => _MypageScreenState();
}

class _MypageScreenState extends State<MypageScreen> {
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.local_library)),
                Text('북어사전'),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications_outlined),
              color: Colors.black,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 40),
            imageProfile(),
            SizedBox(height: 20),
            nameText(),
            Divider(
              height: 44,
              thickness: 1,
              indent: 24,
              endIndent: 24,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black45
                  : Colors.white54,
            ),
            imageButton(),
            SizedBox(height: 20),
            darkMod(),
            SizedBox(height: 20),
            libraryList(),
            SizedBox(height: 20),
            inquiryButton(),
          ],
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: CircleAvatar(
        radius: 80,
        backgroundImage: _imageFile == null
            ? NetworkImage( '${widget.user.kakaoAccount?.profile?.profileImageUrl}') as ImageProvider
            : FileImage(File(_imageFile!.path)),
      ),
    );
  }

  Widget nameText() {
    // 로그인된 사용자의 닉네임을 표시
    return SizedBox(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${widget.user.kakaoAccount?.profile?.nickname}',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageButton() {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => bottomSheet(),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black45
                  : Colors.white54,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Icon(Icons.account_circle_outlined, size: 24),
              SizedBox(width: 12),
              Text(
                '프로필 변경',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget darkMod() {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black45
                : Colors.white54,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            const Icon(Icons.dark_mode_outlined, size: 24),
            const SizedBox(width: 12),
            const Text(
              '다크모드',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const Spacer(),
            Switch(
              value: Mypage.themeNotifier.value == ThemeMode.dark,
              onChanged: (_isLightMode) {
                setState(() {
                  Mypage.themeNotifier.value =
                  _isLightMode ? ThemeMode.dark : ThemeMode.light;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget libraryList() {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black45
                : Colors.white54,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Icon(
              Icons.star_border_rounded,
              size: 24,
            ),
            SizedBox(width: 12),
            Text(
              '도서관 리스트',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget inquiryButton() {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black45
                : Colors.white54,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Icon(
              Icons.chat,
              size: 24,
            ),
            SizedBox(width: 12),
            Text(
              '문의하기',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          const Text(
            'Choose Profile photo',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton.outlined(
                icon: Icon(Icons.camera, size: 50),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
              ),
              IconButton.outlined(
                icon: Icon(Icons.photo_library, size: 50),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _imageFile = pickedFile;
      }
    });
  }
}
