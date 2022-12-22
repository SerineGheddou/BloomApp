
import 'dart:async';

import 'package:bloom/components/ListTiles/ListItemTile.dart';
import 'package:bloom/components/appBar.dart';
import 'package:bloom/components/mybutton.dart';
import 'package:bloom/components/programmed_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bloom/Models/PlantsModel.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../notifiers/plantNotifier.dart';
import '../notifiers/userNotifier.dart';
import '../services/authentification_firebase_service.dart';
import '../services/plant_firebase_service.dart';


class AutomaticMode extends StatefulWidget {
  const AutomaticMode ({Key? key}) : super(key: key);

  @override
  State<AutomaticMode> createState() => _AutomaticModeState();
}

class _AutomaticModeState extends State<AutomaticMode> {
  bool _hasBeenPressedActivate = false;
  void onActivate(List<Plant> plants, String RaspId)  {
    setState(() {
      _hasBeenPressedActivate = true;
    });
    for(int i=0; i<plants.length; i++){
      if(plants[i].isSelected){
        plantService.updateOneData('mode', "1", RaspId, plants[i].Plant_Id!);
      }
    }
  }
  void onClickGoBack(){
    setState(() {
      _hasBeenPressedActivate=false;
    });
    Get.back();
  }
  User? user = FirebaseAuth.instance.currentUser;
  authenticationService auth = authenticationService();
  PlantService plantService = PlantService();
  @override
  void initState() {
    super.initState();
    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
    auth.getUser(userNotifier, user!);
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context, listen: false);
    plantService.getPlants(plantNotifier, user!);
  }

  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Automatic mode',
          style: GoogleFonts.montserrat(
            color: Color(0xffF2F5CC),
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation:0,
        backgroundColor: Color(0xff678D58),
        leading:GestureDetector(
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 25,
            ),
            onPressed:(){
              Get.back();
            } ,
            color: Color(0xffF2F5CC),
          ),
        ),
      ),
      body:  Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color(0xffFDEBE7),
                borderRadius: BorderRadius.circular(16.0)
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.warning_rounded, size: 45, color: Color(0xffF6CD3C),),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          'For the automatic mode, you need to \n activate it only.\n Note that you need to turn it off.   ',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                          )
                      ),
                    ],
                  ),
                ]
            ),
          ),
          Text(
            'Choose the plants you want to water',
            style: GoogleFonts.montserrat(
              color: Color(0xff678D58),
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 10,),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Color(0xffF2F5CC),
                  borderRadius: BorderRadius.circular(19)
              ),
              child: ListView.builder(
                  itemCount: plantNotifier.plantList.length,
                  itemBuilder: (BuildContext context, int index){
                    if(plantNotifier.plantList[index].Plant_Name == null){
                      return Container();
                    } else {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: ListItems(plant:plantNotifier.plantList[index]),
                      );
                    }
                  }
              ),
            ),
          ),
          SizedBox(height: 40,),
          Expanded(
              child: Column(
                children: [
                  MyButton(label: 'Activate', height: 40, width: 140, size: 15, hasBeenPressed: _hasBeenPressedActivate,
                      onTap: ()=> onActivate(plantNotifier.plantList, userNotifier.currentuser.Rasp_Id!)),
                ],
              )
          )
        ],
      ),
    );
  }


}


