




import 'dart:convert';

import 'package:bookapplication/home/schedule_card.dart';
import 'package:bookapplication/library/search_result_banner.dart';
import 'package:bookapplication/model/library_response_model.dart';
import 'package:flutter/material.dart';
import 'package:bookapplication/model/region.dart' ;
import 'package:http/http.dart' as http;
import 'package:bookapplication/const/config.dart';

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
  dynamic resultNum=0;
  Map<String,dynamic>? rejson;
  Map<String,dynamic>? libsInfo;
  List<dynamic>?libsInfoList;
  //resultNum=0;
  Map<String,String>? filterSiRegion;
  @override
  void initState() {
    super.initState();
  }

  String result='';
  onPressGet(String doCode,String siCode) async{
    String httpUrl;
    if(siCode== null && doCode==null){
     httpUrl='https://data4library.kr/api/libSrch?authKey=$libraryAUthKey&pageNo=1&pageSize=3&format=json';
    }else{
      httpUrl='https://data4library.kr/api/libSrch?authKey=$libraryAUthKey&region=$doCode&dtl_region=$siCode&pageNo=1&pageSize=10&format=json';
    }
    http.Response response= await http.get(

        Uri.parse(httpUrl)

    );

    if(response.statusCode==200){
      setState(() {
       rejson=jsonDecode(response.body);
       resultNum=rejson!['response']['resultNum'];
       rejson=rejson?['response'];
       libsInfo=Map.fromEntries(rejson!.entries.where((entry)=>entry.key=="libs"));
       libsInfoList=libsInfo!["libs"];
       print(libsInfoList?[0]);
      });


    }else{
      setState(() {
        result='error!';
      });
    }
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
                                                      print('${key.substring(0,2)}');
                                                      doRegion=value;
                                                      doCode=key;
                                                      filterSiRegion=Map.fromEntries(
                                                        region.dtlRegionCodes.entries.where((entry)=>entry.key.startsWith("${key.substring(0,2)}"))
                                                      );
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
                                                String? key=filterSiRegion?.keys.elementAt(index);
                                                String? value=filterSiRegion?[key]!;
                                                return Container(
                                                  padding: EdgeInsets.all(5),
                                                  height: 50,
                                                  child: TextButton(onPressed: (){
                                                    setState(() {
                                                      siRegion=value!;
                                                      siCode=key;
                                                    });
                                                  }, child: Text('$value')),

                                                );
                                              },
                                              separatorBuilder: (context,index)=>Divider(),
                                              itemCount: filterSiRegion!.length),
                                        ),
                                      );
                                    }
                                );




                              }, icon: Icon(Icons.arrow_circle_down)),
                            ],
                          ),
                        ),
                        //검색 아이콘
                        IconButton(onPressed: (){
                          onPressGet(doCode!, siCode!);

                        }, icon:Icon(Icons.search))
                      ],

                    ),
                  ],
                ),
                SizedBox(height: 15.0,),
                SearchResultBanner(count: resultNum),
                SizedBox(height: 10.0,),
                Expanded(
                    child:ListView.builder(
                        itemCount:libsInfoList?.length ,
                        itemBuilder: (context,index){
                          Map<String,dynamic> libInfo=libsInfoList?[index];
                          return
                            ScheduleCard(libName: '${libInfo['lib']['libName']}', address: '${libInfo['lib']['address']}', tel: '${libInfo['lib']['tel']}', homepage: '${libInfo['lib']['homepage']}', closed: '${libInfo['lib']['closed']}', operationTime: '${libInfo['lib']['operationTime']}');

                        }
                    ),


                ),

                //리스트로 빌더로 값을 뿌려야함.



              ]),
        ),


      ),
    );
  }




}

