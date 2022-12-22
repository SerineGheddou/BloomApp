
import 'package:bloom/Models/event.dart';
import 'package:bloom/Models/user.dart';
import 'package:bloom/notifiers/eventNotifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class EventService {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  Future<DocumentSnapshot<Object?>> getdoc() async{
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser?.uid).get() ;
   return documentSnapshot;
  }
  //Creating a sub collection 'Events' for each user
  Future<String> addMultipleCollections(String? id, String pid, String title) async{
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    EventModel event = EventModel();
    event.Event_Id = users.doc(id).collection('Events').doc().id ;
    users.doc(id).collection('Events').doc(event.Event_Id).set(
      event.toMap()
    );
    return 'Success';
  }

  //Saving data to dataBase
  Future<String> addEventToDB (UserModel userModel, BuildContext context, EventModel eventModel) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    eventModel.Event_Id = users.doc(userModel.uid).collection('Events').doc().id ;
    await users.doc(userModel.uid).collection('Events').doc(eventModel.Event_Id).set(eventModel.toMap());
    print(userModel.uid);
    Fluttertoast.showToast(msg: "Event added successfully");
    return'';
  }

  //Getting data from collection
getEvents(EventNotifier eventNotifier, User user) async {
  List<EventModel> _eventList = [];
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(user.uid).collection('Events').get().then((value) {
      value.docs.forEach((element) {
        EventModel eventModel = EventModel.fromMap(element.data());
        _eventList.add(eventModel);
      });
      return value;
    });
  eventNotifier.eventList = _eventList;
}

}