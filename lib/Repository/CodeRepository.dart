import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

import '../Model/Code.dart';
class CodeRepository{

readCode(Code code) async
{final docCode = FirebaseFirestore.instance.collection('Code').doc(code?.uid);
final snapshot = await docCode.get();if(snapshot.exists){
return Code.fromJson(snapshot.data()!);
}}

Stream<List<Code>> readAllCode()=>FirebaseFirestore.instance.collection('Code').snapshots().map((snapshot) => snapshot.docs.map((doc) =>Code.fromJson(doc.data())).toList());


Future UpdateCode(Code Code) async{


final docCode = FirebaseFirestore.instance.collection('Code').doc(Code.uid);


 docCode.update({'code' : Code.code,});

}


deleteCode(Code Code) async {
final docCode = FirebaseFirestore.instance.collection('Code').doc(Code.uid);
 docCode.delete();
}


Future<String?> AjoutCode(Code Code) async{
final docCode = FirebaseFirestore.instance.collection('Code').doc();
String path = docCode.path.split('/')[1];
Code.uid = path;
final data = Code.toJson();
docCode.set(data);
print("Ajout Effectué");
return path;
}

}