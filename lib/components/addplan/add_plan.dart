
import 'dart:ffi';
import 'package:bloom/Models/PlantsModel.dart';
import 'package:bloom/components/addplan/input_field.dart';
import 'package:bloom/components/mybutton.dart';
import 'package:bloom/screen/calendar.dart';
import 'package:bloom/services/event_firebase_service.dart';
import 'package:bloom/Models/event.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../Models/user.dart';
import '../../services/authentification_firebase_service.dart';

class AddPlanPage extends StatefulWidget {
  final  UserModel userModel;
  const AddPlanPage({Key? key, required this.userModel}) : super(key: key);

  @override
  _AddPlanPageState createState() => _AddPlanPageState();
}
class _AddPlanPageState extends State<AddPlanPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _CatController = TextEditingController();
  final TextEditingController _PlantController = TextEditingController();
  DateTime _selectedDate= DateTime.now();
  late Bool isStartTime;
  String _startTime= DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _selectCategorie= "Plant categorie";
  String _selectedPlantName = "Plant name";
  String _selectedPlant="";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      "img/tropical-background.png"
                  )
              )
          ),
          padding: const EdgeInsets.only(left: 20,right: 20,top: 77),
          child:SingleChildScrollView(
            child: FormBuilder(
              key:_formKey,
              child: Column(
                children: [
                  MyInputField(title: "Title", hint: "Enter your title ",controller: _titleController,),
                  MyInputField(title: "Plant categories", hint: "$_selectCategorie ",controller: _CatController,
                    widget: DropdownButton(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                      iconSize: 32,
                      elevation: 4,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'montserrat',
                      ),
                      onChanged: (String? newValue){
                        setState(() {
                          _selectCategorie= newValue!;
                        });
                      },
                      items: getDropdownItems(plants) ,
                    ),
                  ),
                  MyInputField(title: 'Choose Plant', hint: "$_selectedPlantName",controller: _PlantController,
                    widget: DropdownButton(
                      icon: Icon(Icons.keyboard_arrow_down,
                        color: Colors.grey ,
                    ),
                      iconSize: 32,
                      elevation: 4,
                      onChanged:(String? newValue){
                        setState(() {
                          _selectedPlantName=newValue!;
                        });
                      },
                      items: getsecondDropdownItems(_selectCategorie),
                  ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MyInputField(title: "Date", hint: DateFormat.yMd().format(_selectedDate),
                            widget:IconButton(
                              icon: Icon(Icons.calendar_today_outlined,
                                color: Colors.grey,
                              ),
                              onPressed: (){
                                _getDateFromUser();
                              },
                            )
                        ),
                      ),
                      SizedBox(width: 5,),
                      Expanded(
                          child: MyInputField(
                            title: "Start Time",
                            hint: _startTime ,
                            widget: IconButton(
                              onPressed: (){
                                _getTimeFromUser(isStartTime:true);
                              },
                              icon: Icon(
                                Icons.access_time_rounded,
                                color: Colors.grey,
                              ),
                            ),
                          )
                      ),
                      SizedBox(width: 12,),
                    ],
                  ),
                  SizedBox(height: 18,),
                  Container(
                      margin: EdgeInsets.only(left: 190,right: 5,top: 15), //Not Responsive
                      child: MyButton(label: "Create Plan",height: 40,width: 150,size: 15,hasBeenPressed: false, onTap: (){_validateDate();})

                  )
                ],
              ),
            ),
          )
      ),
    );
  }

 Future _validateDate() async {
    if (_titleController.text.isNotEmpty) {
      //Add to database
      print(_titleController);
      //Initializing the event model
      EventModel eventModel= EventModel();
      eventModel.Plant_Id = getSelectedPlant(_selectedPlantName, plants);
      eventModel.Title= _titleController.text;
      eventModel.Date= _selectedDate.day.toString()+'/'+_selectedDate.month.toString()+'/'+_selectedDate.year.toString();
      eventModel.startTime=_startTime;

      //Getting the authetication service to get the current user
      authenticationService authService = authenticationService();
      //Getting the current user
      User? user = FirebaseAuth.instance.currentUser;
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection("users").doc(user?.uid).get();

      //Saving the data of the current user in the user model
      UserModel  usermodel = UserModel.fromMap(documentSnapshot);

      //Adding the event to the data base
      eventModel.ajouterPlan(usermodel, context, eventModel);
      Get.back();
    } else if (_titleController.text.isEmpty) {
      Get.snackbar("Required", "All fields are required!",
          margin: EdgeInsets.only(bottom: 20
              , left: 20, right: 20),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color(0xff678d58),
          colorText: Color(0xffF2F5CC),
          icon: Icon(Icons.warning_amber_rounded)
      );
    }
  }


  List<DropdownMenuItem<String>> getDropdownItems(List<Plant> myPlants){
    List<DropdownMenuItem<String>> dropDownItems=[];
    for (Plant item in myPlants) {
      var newDropdown= DropdownMenuItem(
        child: Text(item.Plant_Cat!),
        value: item.Plant_Cat,
      );
      dropDownItems.add(newDropdown);
    }
    return dropDownItems;
  }
  List<DropdownMenuItem<String>> getsecondDropdownItems(String categorie){
    List<DropdownMenuItem<String>> dropDownItems=[];
      for (Plant item in plants) {
        if (item.Plant_Cat == categorie){
          var newDropdown= DropdownMenuItem(
            child: Text(item.Plant_Name!),
            value: item.Plant_Name,
          );
          dropDownItems.add(newDropdown);
        }
    }
    return dropDownItems;
  }
  String getSelectedPlant(String name, List<Plant> myPlants){
    for (var item in myPlants){
      if (item.Plant_Name == name){
        _selectedPlant=item.Plant_Id!;
      }
      break;
    }
    return _selectedPlant;
  }
  _appBar(BuildContext context){
    return AppBar(
      title: Text(
        'Add Plan',
        style: TextStyle(
          color: Color(0xffF2F5CC),
          fontSize: 23,
          fontWeight: FontWeight.bold,
          fontFamily: 'montserrat',
        ),
      ),
      centerTitle: true,
      elevation:0,
      backgroundColor: Color(0xff678D58),
      leading: GestureDetector(
        onTap: (){
          Get.back();
        },
        child: Icon(Icons.arrow_back_ios,
          size: 20,
          color: Color(0xffF2F5CC),
        ),
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