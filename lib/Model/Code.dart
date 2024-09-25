import 'package:cloud_firestore/cloud_firestore.dart';
class Code {
 String uid;
 String code;
Code({required this.uid,required this.code,});

Map<String, dynamic> toJson(){
return{
'uid' : uid ,
'code' : code ,
};}
static Code fromJson(Map<String,dynamic> json) => Code(uid: json['uid'],code: json['code'],);

}