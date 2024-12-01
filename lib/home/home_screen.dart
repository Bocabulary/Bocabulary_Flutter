
import 'package:bookapplication/home/main_calendar.dart';
import 'package:bookapplication/home/schedule_card.dart';
import 'package:bookapplication/home/today_banner.dart';
import 'package:bookapplication/home/todaylibrary.dart';
import 'package:bookapplication/shard/menubottom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../bottom_menu.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key}) :super(key: key);




  @override
  State<HomeScreen> createState()=> _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen>{

  DateTime selectedDate=DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  FirebaseFirestore db=FirebaseFirestore.instance;
  List<QueryDocumentSnapshot>? libList;




  @override
  Widget build(BuildContext context){

    CollectionReference libraryRef=db.collection("library");

    libraryRef.get().then((QuerySnapshot value) async {
      libList=value.docs;
    });


    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.local_library)),
              Text('북어'
                  '사전'),
            ]
            ),

            IconButton(onPressed: (){}, icon: Icon(Icons.notifications_outlined),color: Colors.black,),

          ],
        ),

      ),
      body: SafeArea(
        child: Column(
          children: [
            MainCalendar(
              selectedDate: selectedDate,
              onDaySelected: onDaySelected,
            ),
            SizedBox(height: 8.0,),
            TodayBanner(selectedDate: selectedDate, count: libList!.length),
            SizedBox(height: 8.0,),
            Expanded(child: todaylibrary(libList: libList,),),

          ],
        ),
      ),
      bottomNavigationBar: MenuBottom(),
    );
  }


  void onDaySelected(DateTime selectedDate, DateTime focusedDate){

    setState((){
      this.selectedDate=selectedDate;


    });
  }

}



