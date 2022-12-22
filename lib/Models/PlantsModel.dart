import 'dart:ffi';

import 'package:bloom/Models/historique.dart';
import 'package:bloom/Models/user.dart';
import 'package:flutter/cupertino.dart';

import '../services/plant_firebase_service.dart';

class Plant {
  String? Plant_Id;
  String? Arduino_Id;
  int? Pompe;
  String? Plant_Name;
  String? Plant_Cat;
  String? Plant_Image;
  double? Seuil_Temp;
  double? Seuil_Hum;
  int? mode=0;
  bool isSelected=false;
  Historique? Plant_His;
  Plant({this.Plant_Id,this.Plant_Name,this.Plant_Cat,this.Plant_Image,this.Plant_His, this.Arduino_Id,this.Pompe,this.Seuil_Hum,this.Seuil_Temp,this.mode});


//Sending Event details to the server
  Map<String, dynamic> toMap() {
    return {
      'Name': Plant_Name,
      'PlantId': Plant_Id,
      'PlantCat': Plant_Cat,
      'PlantImage': Plant_Image,
      'SeuilTemp': Seuil_Temp,
      'SeuilHum': Seuil_Hum,
      'Pompe': Pompe
    };
  }

//Getting Event details from server
  factory Plant.fromMap(Map<String, dynamic> map) {
    return Plant(
      Plant_Id: map['PlantId'],
      Plant_Name: map['Name'],
      Plant_Cat: map['PlantCat'],
      Plant_Image: map['PlantImage'],
      Seuil_Temp: map['SeuilTemp'],
      Seuil_Hum: map['SeuilHum'],
      Pompe: map['Pompe'],

    );
  }

  PlantService plantService = PlantService();

// Adding new event to database
  Future<String> ajouterPlan(UserModel userModel, BuildContext context,
      Plant plantModel) async {
    plantService.addPlantToDB(userModel, context, plantModel);
    return 'Added successfully';
  }
}

final List<Plant> plants= <Plant>[
          Plant(Plant_Id: '005',Plant_Name: 'Tomato',Plant_Cat:'Fruits and Veggies',Plant_Image:'img/tomatos.png',Plant_His:Historique('005',0,0),),
          Plant(Plant_Id:'006',Plant_Name:'Parsley',Plant_Cat:'Fruits and Veggies',Plant_Image:'img/Parsley.png',Plant_His:Historique('005',0,0),),
          Plant(Plant_Id:'007',Plant_Name:'Cactus',Plant_Cat:'Front Garden',Plant_Image:'img/cactus.png',Plant_His:Historique('007',0,0),),
          Plant(Plant_Id:'008',Plant_Name:'The fiddle Plant',Plant_Cat:'Front Garden',Plant_Image:'img/fiddle.png',Plant_His:Historique('008',0,0),),
          Plant(Plant_Id:'009',Plant_Name:'Pepper',Plant_Cat:'Kitchen',Plant_Image:'img/cactus.png',Plant_His:Historique('009',0,0),),
          Plant(Plant_Id:'010',Plant_Name:'Carrots',Plant_Cat:'Kitchen',Plant_Image:'img/cactus.png',Plant_His:Historique('010',0,0),),
          Plant(Plant_Id:'011',Plant_Name:'Coriander',Plant_Cat:'Kitchen',Plant_Image:'img/cactus.png',Plant_His:Historique('011',0,0),),
    ];