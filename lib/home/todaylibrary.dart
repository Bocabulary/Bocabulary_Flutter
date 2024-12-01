import 'package:bookapplication/home/schedule_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class todaylibrary extends StatefulWidget{

  final List<QueryDocumentSnapshot>? libList;

  todaylibrary({
    required this.libList,
    Key? key
  }):super(key: key);



  @override
  State<todaylibrary> createState()=> _todaylibraryState();



}

class _todaylibraryState extends State<todaylibrary> {


  @override
  Widget build(BuildContext context) {

    return widget.libList?.length!=0?
    ListView.builder(
        itemCount:widget.libList?.length ,
        itemBuilder: (context,index){
          QueryDocumentSnapshot<Object?>? libInfo=widget.libList?[index];
          print(libInfo);
          return(
          Container(
            child: Column(
              children: [

                ScheduleCard(libName: '${libInfo?['libName']}', address: '${libInfo?['address']}', tel: '${libInfo?['tel']}', homepage: '${libInfo?['homepage']}', closed: '${libInfo?['closed']}', operationTime: '${libInfo?['operationTime']}'),
                SizedBox(height: 10.0,)

              ],
            ),
          )


          );



        }
    ): Center(
    child: Text('검색결과가 없습니다.'),
    );
  }
}