import 'package:bloom/Models/PlantsModel.dart';
import 'package:bloom/Models/event.dart';
import 'package:flutter/cupertino.dart';

import '../services/authentification_firebase_service.dart';
//User model
class UserModel {
 String? uid;
 String? Name;
 String? email;
 String? Password;
 String? PhoneNumber;
 String? PhotoProfile;
 bool? isConnected;
 String? Rasp_Id;
 List<Plant>? myPlants;
 List<EventModel>? events;
 //Constructor
UserModel({this.uid,this.Name,this.email,this.Password,this.PhoneNumber,this.PhotoProfile,this.isConnected,this.Rasp_Id,this.events,this.myPlants});

//Getting data from server
factory UserModel.fromMap(map)
{
  return UserModel(
   uid: map['uid'],
   Name: map['Name'],
   email: map['email'],
   Password: map['Password'],
   PhoneNumber: map['PhoneNumber'],
   PhotoProfile: map['PhotoProfile'],
   isConnected: map['isConnected'],
   Rasp_Id: map['RaspId'],
   myPlants: map['myPlants'],
   events: map['events'],
  );
}
// Sending data to our server
Map<String, dynamic> toMap()
{
  return {
   'uid': uid,
   'Name': Name,
   'email': email,
   'Password':Password,
   'PhoneNumber': PhoneNumber,
   'PhotoProfile':PhotoProfile,
   'isConnected':isConnected,
   'RaspId': Rasp_Id,
   'myPlants': myPlants,
   'events': events,
  };
}
//Getting the authentication Service
 authenticationService authService = authenticationService();

// Méthode pour se connecter
Future seConnecter(String email, String password, BuildContext context) async{
  authService.loginUsingEmailPassword(email, password, context);
}

}
