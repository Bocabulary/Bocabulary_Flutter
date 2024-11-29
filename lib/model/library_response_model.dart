import 'package:bookapplication/const/config.dart';

class libraryResponseModel{
  int? pageNo;
  int? pageSize;
  int? numFound; //전체 검색 결과수
  int? resultNum; //응답결과 건수
  Map<String,dynamic>? libs;
  int? libCode;
  String? libName;
  String? address;
  String? tel;
  String? homepage;
  String? closed;
  String? operatingTime;

  libraryResponseModel.fromJson(Map<String,dynamic>json)
  : pageNo=json['pageNo'],pageSize=json['pageSize'],numFound=json['numFound'],
  resultNum=json['resultNum'],libName=json['libs']['lib']['libName'],
  address=json['libs']['lib']['address'],tel=json['libs']['lib']['tel'],
  homepage=json['libs']['lib']['homepage'],closed=json['libs']['lib']['closed'],
  operatingTime=json['libs']['lib']['operatingTime'];

}