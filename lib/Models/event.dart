
import 'package:bloom/Models/user.dart';
import 'package:flutter/material.dart';
import '../services/event_firebase_service.dart';

class EventModel {
  String ? Event_Id;
  String ? User_Id;
  String ? Plant_Id;
  String? Date;
  String ? startTime;
  String ? Title;

  EventModel(
      { this.Event_Id, this.Title, this.Plant_Id, this.Date, this.startTime, this.User_Id});

//Sending Event details to the server
  Map<String, dynamic> toMap() {
    return {
      'title': Title,
      'EventId': Event_Id,
      'PlantId': Plant_Id,
      'date': Date,
      'startTime': startTime,
      'userId': User_Id,
    };
  }

//Getting Event details from server
  factory EventModel.fromMap(Map<String, dynamic> map) {
    print(map['title']);
    return EventModel(
      Event_Id: map['EventId'],
      Title: map['title'],
      Plant_Id: map['PlantId'],
      Date: map['date'],
      startTime: map['startTime'],
      User_Id: map['userId'],
    );
  }

  EventService eventService = EventService();

// Adding new event to database
  Future<String> ajouterPlan(UserModel userModel, BuildContext context,
      EventModel eventModel) async {
    eventService.addEventToDB(userModel, context, eventModel);
    return 'Added successfully';
  }
}

