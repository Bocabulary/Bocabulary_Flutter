




import 'package:bookapplication/home/schedule_card.dart';
import 'package:bookapplication/library/search_result_banner.dart';
import 'package:flutter/material.dart';
import 'package:bookapplication/model/region.dart' ;


class SearchScreen extends StatefulWidget{
  const SearchScreen({Key? key}) :super(key: key);

  @override
  State<SearchScreen> createState()=> _SearchcreenState();

}

class _SearchcreenState extends State<SearchScreen>{
  final Region region = Region();

  String doRegion="전체";
  String siRegion="전체";
  String? doCode;
  String? siCode;
  Map<String,String>? filterSiRegion;
  @override
  void initState() {
    super.initState();
    filterSiRegion = Map.from(region.dtlRegionCodes);
  }



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

                // SearchBar(
                //   trailing: [Icon(Icons.search)],
                //   shadowColor: MaterialStatePropertyAll(Colors.deepPurple),
                // ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      Container(
                        child: Text('도'),
                      ),
                      Container(
                        child: Text('시/군/구'),
                      ),
                    ],),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Text('$doRegion'),
                              IconButton(onPressed: (){
                                 showDialog(
                                    context: context,
                                    builder: (BuildContext context){
                                      return Dialog(
                                        child: Container(
                                          width: double.maxFinite,
                                          child: ListView.separated(
                                            padding: EdgeInsets.all(10),
                                              itemBuilder: (context,index){
                                                String key=region.regionCodes.keys.elementAt(index);
                                                String value=region.regionCodes[key]!;
                                                return Container(
                                                  padding: EdgeInsets.all(5),
                                                  height: 50,
                                                  child: TextButton(onPressed: (){
                                                    setState(() {
                                                      doRegion=value;
                                                    });
                                                  }, child: Text('$value')),

                                                );
                                              },
                                              separatorBuilder: (context,index)=>Divider(),
                                              itemCount: region.regionCodes.length),
                                        ),
                                      );
                                    }
                                );
                              }, icon: Icon(Icons.arrow_circle_down)),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text('$siRegion'),
                              IconButton(onPressed: (){

                                showDialog(
                                    context: context,
                                    builder: (BuildContext context){
                                      return Dialog(
                                        child: Container(
                                          width: double.maxFinite,
                                          child: ListView.separated(
                                              padding: EdgeInsets.all(10),
                                              itemBuilder: (context,index){
                                                String key=region.dtlRegionCodes.keys.elementAt(index);
                                                if(key.)
                                                String value=region.dtlRegionCodes[key]!;
                                                return Container(
                                                  padding: EdgeInsets.all(5),
                                                  height: 50,
                                                  child: TextButton(onPressed: (){
                                                    setState(() {
                                                      siRegion=value;
                                                    });
                                                  }, child: Text('$value')),

                                                );
                                              },
                                              separatorBuilder: (context,index)=>Divider(),
                                              itemCount: region.dtlRegionCodes.length),
                                        ),
                                      );
                                    }
                                );




                              }, icon: Icon(Icons.arrow_circle_down)),
                            ],
                          ),
                        ),
                        IconButton(onPressed: (){}, icon:Icon(Icons.search))
                      ],

                    ),
                  ],
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

