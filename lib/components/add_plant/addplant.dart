import 'dart:core';
import 'package:bloom/components/addplan//number_input_field_.dart';
import 'package:bloom/notifiers/StringPompNotifier.dart';
import 'package:bloom/notifiers/userNotifier.dart';
import 'package:bloom/services/authentification_firebase_service.dart';
import 'package:bloom/services/plant_firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../Models/PlantsModel.dart';
import '../../Models/user.dart';
import '../../notifiers/stringNotifier.dart';
import '../../services/list_arduino_firebase_service.dart';
import '../../services/list_pompe_firebase_service.dart';
import '../addplan/input_field.dart';
import '../mybutton.dart';

class AddPlantPage extends StatefulWidget {
  const AddPlantPage({Key? key}) : super(key: key);

  @override
  State<AddPlantPage> createState() => _AddPlantPageState();
}
class _AddPlantPageState extends State<AddPlantPage> {
  ListService _listService = ListService();
  ListPompeService _listpompeService = ListPompeService();
  authenticationService auth = authenticationService();
  User? user = FirebaseAuth.instance.currentUser;
  PlantService plantService = PlantService();

  @override
  void initState() {
    super.initState();
    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
    auth.getUser(userNotifier, user!);
    StringNotifier listNotifier = Provider.of<StringNotifier>(context, listen: false);
    StringPompNotifier listpompeNotifier = Provider.of<StringPompNotifier>(context, listen: false);
  }
  var png = "https://www.woolha.com/media/2021/06/flutter-using-decorationimage-1200x627.jpg";

  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _PlaceController = TextEditingController();
  final TextEditingController _NamePlantController = TextEditingController();
  final TextEditingController _SeuilController = TextEditingController();
  final TextEditingController _QuantiteController = TextEditingController();
  String _selectedArduino = "Arduino";
  String _selectedPompe = "Pompe";
  List<String> ArduinoList = [];

  List<String> PompeList = [];


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    //Initialising the notifiers
    StringNotifier listNotifier = Provider.of<StringNotifier>(context);
    StringPompNotifier listpompeNotifier = Provider.of<StringPompNotifier>(
        context);
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);

    //getting the list from database
    _listService.getList(listNotifier);
    _listpompeService.getListPomp(listpompeNotifier);


    //Saving the list in new lists
    ArduinoList = listNotifier.stringList;
    PompeList = listpompeNotifier.stringList;


    return Scaffold(
      appBar: _appBar(context),
      body: Stack(
        alignment: Alignment.center,
        // padding: const EdgeInsets.only(left: 20, right: 20,top: 100 ),//Not RESPONSIVE
        children: [
          Column(
            children: [
              Container(
                height: size.height / 9,
                color: Color(0xff678D58),
              ),
              Expanded(
                child: Container(
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              FormBuilder(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    MyInputField(title: "Plant Name ",
                                      hint: "Enter your plant name ",
                                      controller: _NamePlantController,),
                                    MyInputField(title: "Place",
                                      hint: "Enter your place ",
                                      controller: _PlaceController,),
                                    MyInputFieldnumber(title: "Threshold",
                                        hint: "Enter your humidity threshold ",
                                        controller: _SeuilController,
                                        color: Colors.transparent,
                                        color2: Colors.grey),
                                    Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: MyInputFieldnumber(
                                                    title: "Quantity",
                                                    hint: 'Quantity in ml',
                                                    controller: _QuantiteController,
                                                    color: Colors.transparent,
                                                    color2: Colors.grey,)),
                                              const SizedBox(width: 12,),
                                              Expanded(child: MyInputField(
                                                  title: "Pomp",
                                                  hint: _selectedPompe,
                                                  widget: DropdownButton(
                                                    icon: const Icon(
                                                      Icons.keyboard_arrow_down,
                                                      color: Colors.grey,
                                                    ),
                                                    iconSize: 32,
                                                    elevation: 4,
                                                    style: GoogleFonts
                                                        .montserrat(
                                                      color: Colors.grey[600],
                                                      fontSize: 14,
                                                      fontWeight: FontWeight
                                                          .w400,
                                                    ),
                                                    underline: Container(
                                                      height: 0,),
                                                    onChanged: (
                                                        String? newValue) {
                                                      setState(() {
                                                        _selectedPompe =
                                                        newValue!;
                                                      });
                                                    },
                                                    items: PompeList.map<
                                                        DropdownMenuItem<
                                                            String>>((
                                                        String? value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                          value: value,
                                                          child: Text(value!,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .grey))
                                                      );
                                                    }
                                                    ).toList(),
                                                  )
                                              ),),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(child: MyInputField(
                                                  title: "Arduino",
                                                  hint: "$_selectedArduino",
                                                  widget: DropdownButton(
                                                    icon: const Icon(
                                                      Icons.keyboard_arrow_down,
                                                      color: Colors.grey,
                                                    ),
                                                    iconSize: 32,
                                                    elevation: 4,
                                                    style: GoogleFonts
                                                        .montserrat(
                                                      color: Colors.grey[600],
                                                      fontSize: 14,
                                                      fontWeight: FontWeight
                                                          .w400,
                                                    ),
                                                    underline: Container(
                                                      height: 0,),
                                                    onChanged: (
                                                        String? newValue) {
                                                      setState(() {
                                                        _selectedArduino =
                                                        newValue!;
                                                      });
                                                    },
                                                    items: listNotifier
                                                        .stringList.map<
                                                        DropdownMenuItem<
                                                            String>>((
                                                        String? value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                          value: value,
                                                          child: Text(value!,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .grey))
                                                      );
                                                    }
                                                    ).toList(),
                                                  )
                                              ),),
                                              const SizedBox(width: 12,),
                                            ],
                                          ),
                                        ]
                                    ),
                                    const SizedBox(height: 18,),
                                    Container(
                                        margin: const EdgeInsets.only(
                                            left: 190, right: 5, top: 15),
                                        //Not Responsive
                                        child: MyButton(label: "Create Plant",
                                            height: 40,
                                            width: 150,
                                            size: 15,
                                            hasBeenPressed: false,
                                            onTap: () => _validate())

                                    )
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0.0,
            child: MaterialButton(
              onPressed: () {
                ShowImageEditor();
              },
              child: Container(
                height: 125,
                width: 125,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(png),
                    fit: BoxFit.fill,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white),
                  color: Colors.white,
                ),

              ),
            ),
          ),
        ],
      ),
    );
  }

  _validate() async {
    if (_NamePlantController.text.isNotEmpty &&
        _PlaceController.text.isNotEmpty &&
        _SeuilController.text.isNotEmpty &&
        _QuantiteController.text.isNotEmpty) {
      //Initializing the event model
      Plant plant = Plant();
      plant.Plant_Name = _NamePlantController.text;
      plant.Plant_Cat = _PlaceController.text;

      //Getting the authetication service to get the current user
      authenticationService authService = authenticationService();
      //Getting the current user
      User? user = FirebaseAuth.instance.currentUser;
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection("users").doc(user?.uid).get();

      //Saving the data of the current user in the user model
      UserModel usermodel = UserModel.fromMap(documentSnapshot);
      //Adding the event to the data base
      plant.ajouterPlan(usermodel, context, plant);
      print(_QuantiteController.text);
      plantService.setData(
          _NamePlantController.text,
          _PlaceController.text,
          ConvertToDouble(_SeuilController.text),
          _QuantiteController.text,
          _selectedArduino,
          "00",
          _selectedPompe,
          usermodel.Rasp_Id!,
          plant.Plant_Id!);
      //Going back to the previous page
      Get.back();
    } else
    if (_NamePlantController.text.isEmpty || _PlaceController.text.isEmpty) {
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

  _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Add Plant',
        style: GoogleFonts.montserrat(
          color: Color(0xffF2F5CC),
          fontSize: 23,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Color(0xff678D58),
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(Icons.arrow_back_ios,
          size: 20,
          color: Color(0xffF2F5CC),
        ),
      ),
    );
  }

  /*
  Future downloadFile(String path) async {
    try {
      String downloadUrl = await firebase_storage.FirebaseStorage.instance
          .ref(path)
          .getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print(e.toString());
    }
  }
  */

  //ShowImageEditor function
  Future ShowImageEditor() async {
    var chosen = "https://firebasestorage.googleapis.com/v0/b/bloom-92627.appspot.com/o/plant_img%2FParsley.png?alt=media&token=1ead4725-0600-4d21-a9c6-cca6558f7228";
    final ref = FirebaseStorage.instance.ref().child('plant_img');
    final listResult = await ref.listAll();
    List<Widget> data = [];

    for (var truc in listResult.items) {
      final imageUrl = await FirebaseStorage.instance.ref()
          .child(truc.fullPath)
          .getDownloadURL();

        data.add(
          MaterialButton(onPressed: () {
            //print(imageUrl);
            chosen = imageUrl;
          },
              child: Material(
                borderRadius: BorderRadius.circular(25.0),
                color: Colors.white,
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 5,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 5,
                  child: Image.network(
                    imageUrl,
                    height: 30,),
                ),
              )
          ),
        );

    }

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 3,
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 1.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children:data,
                      ),
                    ),

                  ],
                ),
              ),
            );
          });
    png = chosen;
    }

  //Fonction qui permet de convertir une chaine de caractère en entier
  double ConvertToDouble(String string){
    var stringtonumber = double.parse(string);
    assert(stringtonumber is double);
    return stringtonumber;
  }

}





