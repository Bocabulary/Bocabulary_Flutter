import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/src/services/asset_bundle.dart';
import 'package:flutter/src/painting/image_stream.dart';


class MyApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    // Listener 추가
    themeNotifier.addListener(() {
      debugPrint('ThemeNotifier updated: ${themeNotifier.value}');
    });

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, themeMode, child) {
        return MaterialApp(
          title: "북어사전",
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeMode,
          home: const MypageScreen(),
        );
      },
    );
  }
}

class MypageScreen extends StatefulWidget{
  const MypageScreen({Key? key}) :super(key: key);

  @override
  State<MypageScreen> createState() => _MypageScreenState();

  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.dark);

}

class _MypageScreenState extends State<MypageScreen> {
  XFile? _imageFile;

  bool _isLightMode = true;

  final ImagePicker _picker = ImagePicker();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.local_library)),
            Text('북어사전'),
            ]
            ),

            IconButton(onPressed: (){}, icon: Icon(Icons.notifications_outlined),color: Colors.black,),

        ],
        ),
      ),
      body: SafeArea(
          child: Column(
          children: [
            imageProfile(),
            SizedBox(height: 20),
            nameText(),
            const Divider(
              height: 44,
              thickness: 1,
              indent: 24,
              endIndent: 24,
              color: Colors.black12,
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
        ? AssetImage('assets/image/default_profile.png')
        : FileImage(File(_imageFile!.path)),
      )
    );
  }

  Widget nameText() {
    return const SizedBox(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'name',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black87,
              ),
            ),
          ]
        ),
      ),
    );
  }

  Widget imageButton() {
    return SizedBox(
      height: 60, // 버튼의 높이 설정
      width: double.infinity, // 버튼을 가로로 꽉 채우기
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
              color:  Colors.black45, // 테두리 색상
            ),
            borderRadius: BorderRadius.circular(8), // 모서리 둥글게
          ),
          padding: EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft, // 텍스트와 아이콘 정렬
          child: const Row(
            children: [
              Icon(
                Icons.account_circle_outlined,
                color: Colors.black54,
                size: 24,
              ),
              SizedBox(width: 12), // 아이콘과 텍스트 사이 간격
              Text(
                '프로필 변경',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
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
          border: Border.all(color: Colors.black45),
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
                color: Colors.black87,
              ),
            ),
            const Spacer(),
            Switch(
              value: MyApp.themeNotifier.value == ThemeMode.light,
              onChanged: (isLightMode) {
                setState(() {
                  MyApp.themeNotifier.value =
                  isLightMode ? ThemeMode.light : ThemeMode.dark;
                });
              },
            ),
          ],
        ),
      ),
    );
  }


  Widget libraryList () {
    return SizedBox(
        height: 60,
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color:  Colors.black45, // 테두리 색상
            ),
            borderRadius: BorderRadius.circular(8), // 모서리 둥글게
          ),
          padding: EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft, // 텍스트와 아이콘 정렬
          child: const Row(
            children: [
              Icon(
                Icons.star_border_rounded,
                color: Colors.black54,
                size: 24,
              ),
              SizedBox(width: 12), // 아이콘과 텍스트 사이 간격
              Text(
                '도서관 리스트',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        )
    );
  }

  Widget inquiryButton () {
    return SizedBox(
        height: 60,
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color:  Colors.black45, // 테두리 색상
            ),
            borderRadius: BorderRadius.circular(8), // 모서리 둥글게
          ),
          padding: EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft, // 텍스트와 아이콘 정렬
          child: const Row(
            children: [
              Icon(
                Icons.chat,
                color: Colors.black54,
                size: 24,
              ),
              SizedBox(width: 12), // 아이콘과 텍스트 사이 간격
              Text(
                '문의하기',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        )
    );
  }


  // Widget nameTextFeild() {
  //   return TextFormField(
  //     decoration: InputDecoration(
  //       border: const OutlineInputBorder(
  //         borderSide: BorderSide(
  //           color: Colors.black45,
  //         )
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderSide: BorderSide(
  //           color: Theme.of(context).secondaryHeaderColor,
  //           width: 2
  //         ),
  //       ),
  //       prefixIcon: Icon(
  //         Icons.person,
  //         color: Theme.of(context).primaryColor,
  //       ),
  //       labelText: 'Name',
  //       hintText: 'Input your name'
  //     ),
  //   );
  // }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20
      ),
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
                // label:const Text('Camera', style: TextStyle(
                //   fontSize: 20
                //   ),
                // ),
          ),

              IconButton.outlined(
                icon: Icon(Icons.photo_library, size: 50),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                // label: const Text('Gallery', style: TextStyle(
                //   fontSize: 20
                // ),),
              )
            // )
            ],
          )
        ],
      ),
    );
  }
  takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _imageFile = pickedFile; // XFile을 사용
      }
    });
  }


}
