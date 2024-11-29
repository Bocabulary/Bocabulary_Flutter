import 'package:bookapplication/const/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchResultBanner extends StatelessWidget{
  final int count;
  const SearchResultBanner({
    required this.count,
    Key? key
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle=TextStyle(
      fontWeight: FontWeight.w600,
      color:Colors.white,
    );

    return Container(
      color: PRIMARY_COLOR,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '검색된 결과 : ${count}건',
              style: textStyle,
            )
          ],
        ),
      ),
    );
  }

}