import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/src/services/asset_bundle.dart';
import 'package:flutter/src/painting/image_stream.dart';


class MypageScreen extends StatefulWidget{
  const MypageScreen({Key? key}) :super(key: key);

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
            nameTextFeild(),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 80,
            backgroundImage: _imageFile == null
              ? AssetImage('assets/image/default_profile.png')
              : FileImage(File(_imageFile!.path)),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(context: context, builder: ((builder) =>
                bottomSheet()));
              },
              child: Icon(
                Icons.camera_alt,
                color: Theme.of(context).secondaryHeaderColor,
                size: 40,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget nameTextFeild() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).secondaryHeaderColor,
            width: 2
          ),
        ),
        prefixIcon: Icon(
          Icons.person,
          color: Theme.of(context).primaryColor,
        ),
        labelText: 'Name',
        hintText: 'Input your name'
      ),
    );
  }

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
