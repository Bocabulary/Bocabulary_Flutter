




import 'package:bookapplication/home/schedule_card.dart';
import 'package:bookapplication/library/search_result_banner.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget{
  const SearchScreen({Key? key}) :super(key: key);

  @override
  State<SearchScreen> createState()=> _SearchcreenState();

}

class _SearchcreenState extends State<SearchScreen>{


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.local_library)),
              Text('도서관 검색'),
            ]
            ),

            IconButton(onPressed: (){}, icon: Icon(Icons.notifications_outlined),color: Colors.black,),

          ],
        ),

      ),
      body: SafeArea(
        child: Padding(padding: EdgeInsets.all(10.0),
          child:  Column(
              children: [

                SearchBar(
                  trailing: [Icon(Icons.search)],
                  shadowColor: MaterialStatePropertyAll(Colors.deepPurple),
                ),
                SizedBox(height: 15.0,),
                SearchResultBanner(count: 10),
                SizedBox(height: 10.0,),
                ScheduleCard(libName: '청양', address: '청양', tel: '청양', homepage: '청양', closed: '청양', operationTime: '청양'),


              ]),
        ),


      ),
    );
  }




}

