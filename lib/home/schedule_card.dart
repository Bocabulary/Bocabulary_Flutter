import 'package:bookapplication/const/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ScheduleCard extends StatelessWidget{

  final String libName;
  final String address;
  final String tel;
  final String homepage;
  final String closed;
  final String operationTime;

  
  const ScheduleCard({
    required this.libName,
    required this.address,
    required this.tel,
    required this.homepage,
    required this.closed,
    required this.operationTime,
    Key? key
}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: PRIMARY_COLOR,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Time(libName: libName,),
              SizedBox(width: 16.0,),
              _Content(address: address,closed: closed,),
              SizedBox(width: 16.0,),
              IconButton(onPressed: (){}, icon: Icon(Icons.star),color: Colors.yellow,),
            ],
          ),
        ),
      ),
    );
  }
}



class _Time extends StatelessWidget {
  final String libName;

  const _Time({
    required this.libName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: PRIMARY_COLOR,
      fontSize: 16.0,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          //숫자가 두자릿수가 안되명 0으로 채워주기
          '${libName}',
          style: textStyle,
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final String address;
  final String closed;

  const _Content({
    required this.address,
    required this.closed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Column(
      children: [
        Text(address),
        Text(closed),
      ],
    ));
  }
}
