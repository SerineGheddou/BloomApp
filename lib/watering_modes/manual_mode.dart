
import 'dart:async';

import 'package:bloom/components/ListTiles/ListItemTile.dart';
import 'package:bloom/components/appBar.dart';
import 'package:bloom/components/mybutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bloom/Models/PlantsModel.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../components/addplan/number_input_field_.dart';
import '../notifiers/plantNotifier.dart';
import '../notifiers/userNotifier.dart';
import '../services/authentification_firebase_service.dart';
import '../services/plant_firebase_service.dart';


class ManualMode extends StatefulWidget {
  const ManualMode ({Key? key}) : super(key: key);

  @override
  State<ManualMode> createState() => _ManualModeState();
}

class _ManualModeState extends State<ManualMode> {
  bool value = false;
  bool _hasBeenPressedStart = false;
  bool _hasBeenPressedGoBack = false;

  void onClickStart(List<Plant> plants,String RaspId,String q){
    for (int i=0; i<plants.length; i++) {
      if(plants[i].isSelected){
        plantService.updateOneData('mode', "3", RaspId, plants[i].Plant_Id!);
        plantService.updateOneData('quantity', q, RaspId, plants[i].Plant_Id!);
      }
    }
    setState(() {
         _hasBeenPressedStart=true;
    });
  }


  //Initialising the notifier
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
  TextEditingController _quantiteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manual mode',
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
                                  '\t For the manual mode you can only start \n \t watering and stop it, make sure not to \n \t forget the watering on    ',
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
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    color: const Color(0xffF2F5CC),
                    borderRadius: BorderRadius.circular(19)
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                  itemCount: plantNotifier.plantList.length,
                  itemBuilder: (BuildContext context, int index ){
                      if(plantNotifier.plantList[index].Plant_Name == null){
                        return Container();
                      } else {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: ListItems(plant:plantNotifier.plantList[index]),
                        );
                      }
                    }
                ),
              ),
            ),
            Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 60),
                          child: MyInputFieldnumber(title: 'Enter quantity', hint: 'Quantity in ml',color: Color(0xffF2F5CC),
                            color2:Color(0xffF2F5CC),controller: _quantiteController ,)
                      ),
                      SizedBox(height: 10,),
                      MyButton(label: ('Start'), height: 50, width: 120, size: 18,hasBeenPressed: _hasBeenPressedStart,
                          onTap: ()=> onClickStart(plantNotifier.plantList,userNotifier.currentuser.Rasp_Id!,_quantiteController.text)),
                    ],
                  ),

            )
          ],
        ),
    );
  }

}


