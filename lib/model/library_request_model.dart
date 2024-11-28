import 'package:bookapplication/const/config.dart';

class libraryRequestModel{
  static const String  authKey=libraryAUthKey;
  int? libeCode;
  int? region;
  int? dtl_region;
  int? pageNo;
  int? pageSize;
  static const String format="json";

  libraryRequestModel();

}