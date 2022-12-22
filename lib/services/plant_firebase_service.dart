
import 'dart:core';

import 'package:bloom/Models/PlantsModel.dart';
import 'package:bloom/Models/user.dart';
import 'package:bloom/notifiers/TempHumNotifier.dart';
import 'package:bloom/screen/watering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../notifiers/plantNotifier.dart';
import '../notifiers/tempNotifier.dart';


class PlantService {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  late final db = FirebaseDatabase.instance.ref();



  //Creating a sub collection 'Events' for each user
  Future<String> addMultipleCollections(String? id, String pid, String title) async{
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    Plant plant = Plant();
    plant.Plant_Id = users.doc(id).collection('Plants').doc().id ;
    users.doc(id).collection('Plants').doc(plant.Plant_Id).set(
        plant.toMap()
    );
    return 'Success';
  }

  //Saving data to dataBase
  Future<String> addPlantToDB (UserModel userModel, BuildContext context, Plant plant) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    plant.Plant_Id = users.doc(userModel.uid).collection('Plants').doc().id ;
    await users.doc(userModel.uid).collection('Plants').doc(plant.Plant_Id).set(plant.toMap());
    print(userModel.uid);
    Fluttertoast.showToast(msg: "Plant added successfully");
    return 'Success';
  }

  //Getting data from collection
  getPlants(PlantNotifier plantNotifier, User user) async {
    List<Plant> _plantList = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(user.uid).collection('Plants').get().then((value) {
      value.docs.forEach((element) {
        Plant plant = Plant.fromMap(element.data());
        _plantList.add(plant);
      });
      return value;
    });
    plantNotifier.plantList = _plantList;

  }
  //Adding plant to RealTime database
  setData(String Name,String Place,double Seuil, String Quantite , String Arduino,String mode, String Pompe,String RaspId,String PlantId){
    db.child('Raspberry/$RaspId/plantes/$PlantId').set(
        {
          'airhumidity':'',
          'arduino':Arduino,
          'dateArrosage':'',
          'groupe':Place,
          'heureArrosage':'',
          'humidity':'',
          'mode':mode,
          'nom':Name,
          'pompe':Pompe,
          'quantity':Quantite,
          'seuil':Seuil,
          'temperature':'',
        }
    );
  }

  //Updating plant data in realtime firestore
 updateData(String mode,String date, String time, String RaspId, String PlantId) {
   db.child('Raspberry/$RaspId/plantes/$PlantId').child('mode').set(mode);
   db.child('Raspberry/$RaspId/plantes/$PlantId').child('dateArrosage').set(date);
   db.child('Raspberry/$RaspId/plantes/$PlantId').child('heureArrosage').set(time);


 }
 updateOneData(String dataName, String data,String RaspId, String PlantId){
    db.child('Raspberry/$RaspId/plantes/$PlantId').child(dataName).set(data);
 }

  getList(TempNotifier tempNotifier,List<Plant> plantes) async {
    late final db = FirebaseDatabase.instance.ref();
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection("users").doc(user?.uid).get();
    UserModel  usermodel = UserModel.fromMap(documentSnapshot);
    String RaspId = usermodel.Rasp_Id!;
    List<String> list=[];
    for(var item in plantes){
      String PlantId = item.Plant_Id!;
      final snapshot= await db.child('Raspberry/$RaspId/plantes/$PlantId/temperature').get();
      list.add(snapshot.value.toString());
    }
    tempNotifier.currenttemp = list;
  }
  gettTemp( TempHumNotifier temphumNotifier,Plant plantes ) async {
    double temp=0.0;
    late final db = FirebaseDatabase.instance.ref();
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection("users").doc(user?.uid).get();
    UserModel  usermodel = UserModel.fromMap(documentSnapshot);
    String RaspId = usermodel.Rasp_Id!;
    String PlantId = plantes.Plant_Id!;
    final snapshot= await db.child('Raspberry/$RaspId/plantes/$PlantId/temperature').get();
    print(snapshot.value.toString());
    temp = ConvertToDouble(snapshot.value.toString());
    temphumNotifier.currenttempset = temp;
    }
  gettHum( TempHumNotifier temphumNotifier,Plant plantes ) async {
    double  humidity=0.0;
    late final db = FirebaseDatabase.instance.ref();
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection("users").doc(user?.uid).get();
    UserModel  usermodel = UserModel.fromMap(documentSnapshot);
    String RaspId = usermodel.Rasp_Id!;
    String PlantId = plantes.Plant_Id!;
    final snapshot= await db.child('Raspberry/$RaspId/plantes/$PlantId/humidity').get();
    print(snapshot.value.toString());
    humidity = ConvertToDouble(snapshot.value.toString());
    temphumNotifier.currenthumset = humidity;
  }

}
