
import 'package:bookapplication/home/main_calendar.dart';
import 'package:bookapplication/home/schedule_card.dart';
import 'package:bookapplication/home/today_banner.dart';
import 'package:flutter/material.dart';

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


  @override
  Widget build(BuildContext context){
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
            MainCalendar(
              selectedDate: selectedDate,
              onDaySelected: onDaySelected,
            ),
            SizedBox(height: 8.0,),
            TodayBanner(selectedDate: selectedDate, count: 0),
            SizedBox(height: 8.0,),
            ScheduleCard(libName: '청양도서관',closed: '매주 일요일',address: '청양군 청양읍',homepage: '어쩌고',operationTime: '시시',tel: '010-101-101',),
          ],
        ),
      ),
    );
  }


  void onDaySelected(DateTime selectedDate, DateTime focusedDate){

    setState((){
      this.selectedDate=selectedDate;


    });
  }

}

