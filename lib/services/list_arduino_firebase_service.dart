import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import '../Models/user.dart';
import '../notifiers/stringNotifier.dart';

class ListService {
  User? user = FirebaseAuth.instance.currentUser;
  //Getting data from collection
  getList(StringNotifier stringNotifier)async {
    late final db = FirebaseDatabase.instance.ref();
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection("users").doc(user?.uid).get();
    UserModel  usermodel = UserModel.fromMap(documentSnapshot);
    String RaspId = usermodel.Rasp_Id!;
    final snapshot = await db.child('Raspberry/$RaspId/arduinos').get();
    List<String> list=[];
    if (snapshot.exists){
      if (kDebugMode) {
        Map<dynamic,dynamic> listmap = snapshot.value as Map ;
        listmap.forEach((key, value) {
          list.add(key);
        });

      }
    }else{
      if (kDebugMode) {
        print('No data available');
      }
    }
    stringNotifier.stringList = list;

  }
}