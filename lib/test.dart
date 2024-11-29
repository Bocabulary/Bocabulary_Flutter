import 'package:bookapplication/const/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main(){
  runApp(testHttp());
}

class testHttp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return testhttpState();
  }

}

class testhttpState extends State<testHttp>{

  String result='';
  onPressGet() async{
    String httpUrl='https://data4library.kr/api/libSrch?authKey=$libraryAUthKey&pageNo=1&pageSize=3&format=json';
    http.Response response= await http.get(

      Uri.parse(httpUrl)

    );

    if(response.statusCode==200){
      setState(() {
        result=response.body;
      });

    }else{
      setState(() {
        result='error!';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(
          title: Text('test'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$result'),
              ElevatedButton(onPressed: onPressGet, child: Text('GET')),
            ],
          ),
        ),
      ) ,
    );

  }

}