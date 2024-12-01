import 'package:bookapplication/const/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class ScheduleCard extends StatefulWidget{

  final String libName;
  final String address;
  final String tel;
  final String homepage;
  final String closed;
  final String operationTime;
  bool isClicked=false;



  ScheduleCard({
    required this.libName,
    required this.address,
    required this.tel,
    required this.homepage,
    required this.closed,
    required this.operationTime,
    Key? key
  }):super(key: key);

  @override
  State<ScheduleCard> createState()=> _ScheduleCardState();

}


class _ScheduleCardState extends State<ScheduleCard> {
  




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
              _Time(libName: widget.libName ,),
              SizedBox(width: 16.0,),
              _Content(address: widget.address,closed: widget.closed,),
              SizedBox(width: 16.0,),
              IconButton(onPressed: () async {
                if(widget.isClicked){
                  deleteFirebase( widget.libName,  widget.address,  widget.tel,  widget.homepage,  widget.closed,  widget.operationTime);
                  setState(() {

                    widget.isClicked=!widget.isClicked;
                    print(widget.isClicked);
                  });

                }else{

                  SaveFirebase( widget.libName,  widget.address,  widget.tel,  widget.homepage,  widget.closed,  widget.operationTime);
                  setState(() {

                    widget.isClicked=!widget.isClicked;
                    print(widget.isClicked);
                  });

                }

              }, icon: Icon(widget.isClicked?Icons.star:Icons.star_border),color: widget.isClicked?Colors.yellow:Colors.grey,),
            ],
          ),
        ),
      ),
    );
  }
  Future<bool> SaveFirebase( String libName, String address, String tel, String homepage, String closed, String operationTime) async {

    FirebaseFirestore db=FirebaseFirestore.instance;
    CollectionReference libraryRef=db.collection("library");
    Map<String,dynamic> library={
      'libName':libName,
      'address':address,
      'tel':tel,
      'homepage':homepage,
      'closed':closed,
      'operationTime':operationTime
    };
    libraryRef.where('libName',isEqualTo:libName ).get()
    .then((QuerySnapshot value) async {
      List<QueryDocumentSnapshot> list=value.docs;
      print('list: $list');
      if(list.length==0){
        DocumentReference libraryDocumentRef= await libraryRef.add(library);
      }

    });
    // if(searchlibRef==null){
    //   DocumentReference libraryDocumentRef= await libraryRef.add(library);
    //   print(libraryDocumentRef.id);
    //   return true;
    // }


    return false;


  }

  void deleteFirebase(String libName, String address, String tel, String homepage, String closed, String operationTime) {

    FirebaseFirestore db=FirebaseFirestore.instance;
    CollectionReference libraryRef=db.collection("library");
    Map<String,dynamic> library={
      'libName':libName,
      'address':address,
      'tel':tel,
      'homepage':homepage,
      'closed':closed,
      'operationTime':operationTime
    };
    libraryRef.where('libName',isEqualTo:libName ).get()
        .then((QuerySnapshot value) async {
      List<QueryDocumentSnapshot> list=value.docs;
      print('list: $list');
      DocumentReference deletelibrary=libraryRef.doc(list[0].id);
      deletelibrary.delete();

    });
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
    int libLen=libName.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          //숫자가 두자릿수가 안되명 0으로 채워주기
          '${libName.substring(0,libLen-3)}',
          style: textStyle,
        ),
        Text(
          //숫자가 두자릿수가 안되명 0으로 채워주기
          '${libName.substring(libLen-3,libLen)}',
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
