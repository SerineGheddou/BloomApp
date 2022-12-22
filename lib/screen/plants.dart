import 'package:bloom/components/add_plant/addplant.dart';
import 'package:bloom/my_plants/Fruits_Vegetables/Components_Fruits_Vegatbles/part_fruits_vegtables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:bloom/components/title.dart';
import '../Models/user.dart';
import '../components/mybutton.dart';
import '../my_plants/FrontGarden_Kitchen/Components_Kittchen_Front_Garden/buildbox.dart';

class Plants extends StatefulWidget {
  UserModel userModel;
  Plants({Key? key,required this.userModel}) : super(key: key);

  @override
  State<Plants> createState() => _PlantsState();
}

class _PlantsState extends State<Plants> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: size.height*0.02,horizontal:size.width/3.5),
                child:MyButton(label: '+ Add a plant',height:40,width: 170,size:15,hasBeenPressed: false, onTap: ()=> Get.to(AddPlantPage()),),
              ),
              SizedBox(height: size.height/100),
              Padding(
                padding: EdgeInsets.all(size.height/100),
                child: TitleWithCustomUderline(text:"Fruits and vegetables ",),
              ),
              SizedBox(height: size.height*0.01),//15
              PartFruitVegatbles(),
              Padding(padding: EdgeInsets.all(size.height/100),
                child : TitleWithCustomUderline(text: " Front Garden "),
              ),
              BuildBox(categorie: 'Front garden',imgPath: "img/Flower1.png", size: 18.0,),
              Padding(padding: EdgeInsets.all(size.height/100),
                child : TitleWithCustomUderline(text: " Kitchen "),
              ),
              BuildBox(categorie: 'Kitchen',imgPath: "img/Flower.png",size: -8,),
              Container(
                margin: EdgeInsets.symmetric(vertical: size.height*0.04),
              )
            ],
          )
      ),
    );
  }
}
