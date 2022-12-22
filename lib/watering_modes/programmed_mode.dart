
import 'dart:async';

import 'package:bloom/Models/event.dart';
import 'package:bloom/components/ListTiles/ListItemTile.dart';
import 'package:bloom/components/appBar.dart';
import 'package:bloom/components/mybutton.dart';
import 'package:bloom/components/programmed_input_field.dart';
import 'package:bloom/services/event_firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bloom/Models/PlantsModel.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Models/user.dart';
import '../notifiers/plantNotifier.dart';
import '../notifiers/userNotifier.dart';
import '../services/authentification_firebase_service.dart';
import '../services/plant_firebase_service.dart';


class ProgrammedMode extends StatefulWidget {
  const ProgrammedMode ({Key? key}) : super(key: key);

  @override
  State<ProgrammedMode> createState() => _ProgrammedModeState();
}

class _ProgrammedModeState extends State<ProgrammedMode> {
  DateTime _selectedDate= DateTime.now();
  String _startTime= DateFormat("hh:mm a").format(DateTime.now()).toString();

  //Function that add new event when the user programs a new watering
  Future<void> onClick(List<Plant> plants, String RaspId) async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection("users").doc(user?.uid).get();
    //Saving the data of the current user in the user model
    UserModel  usermodel = UserModel.fromMap(documentSnapshot);
    for(int i=0; i<plants.length; i++){
      if(plants[i].isSelected){
        EventModel eventModel = EventModel();
        eventModel.Date = _selectedDate.day.toString()+'/'+'0'+_selectedDate.month.toString()+'/'+_selectedDate.year.toString();
        eventModel.startTime = _startTime;
        eventModel.Title = 'Watering'+plants[i].Plant_Name!;
        eventModel.ajouterPlan(usermodel, context, eventModel);
        plantService.updateData("2",eventModel.Date!,_startTime, RaspId, plants[i].Plant_Id!);
      }
    }

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
          'Programmed mode',
          style: GoogleFonts.montserrat(
            color: Color(0xffF2F5CC),
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation:0,
        backgroundColor: Color(0xff678D58),
        leading: GestureDetector(
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
                          'For the programmed mode, you need to \n choose the timing of the start.\n Note that you don’t need to stop it.   ',
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
              margin: EdgeInsets.symmetric(horizontal: 25),
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
                      child:  ListItems(plant:plantNotifier.plantList[index]),
                    );
                  }
                }
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      child: MyInputFieldProgrammed(title: "Date", hint: DateFormat.yMd().format(_selectedDate),
                          widget:IconButton(
                            icon: Icon(Icons.calendar_today_outlined,
                              color: Color(0xff678D58),
                              size: 20,
                            ),
                            onPressed: (){
                              _getDateFromUser();
                            },

                          )
                      ),
                    ),
                    Expanded(
                        child: MyInputFieldProgrammed(
                          title: "Start Time",
                          hint: _startTime ,
                          widget: IconButton(
                            onPressed: (){
                              _getTimeFromUser(isStartTime:true);
                            },
                            icon: Icon(
                              Icons.access_time_rounded,
                              color: Color(0xff678D58),
                            ),
                          ),
                        ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                MyButton(label: 'Add to calendar', height: 40, width: 200, size: 15, hasBeenPressed: true,
                    onTap: ()=> onClick(plantNotifier.plantList, userNotifier.currentuser.Rasp_Id!)),
              ],
            )
          )
        ],
      ),
    );
  }
  _getDateFromUser() async{
    DateTime? _pickerDate= await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xffF2F5CC), // header background color
              onPrimary: Color(0xff678d58), // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Color(0xff678D58), // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if(_pickerDate!=null){
      setState(() {
        _selectedDate=_pickerDate;
        print(_selectedDate);
      });
    }else{
      print("It's null or something is wrong");
    }
  }
  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime= await _showTimePicker();
    String _formatedTime=pickedTime.format(context);
    if(pickedTime==null){
      print("Time canceled");
    } else if(isStartTime==true){
      _startTime=_formatedTime;
    }

  }
  _showTimePicker(){
    return  showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
      ),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            backgroundColor: Color(0xffF8FFF2),
            primaryColor: const Color(0xff678d58),
            accentColor: const Color(0xff678d58),
            colorScheme: ColorScheme.light(primary: const Color(0xff678d58)),
            buttonTheme: ButtonThemeData(
                textTheme: ButtonTextTheme.primary
            ),
          ),
          child: child!,
        );
      },
    );
  }



}


