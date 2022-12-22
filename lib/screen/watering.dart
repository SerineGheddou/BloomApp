import 'package:bloom/Models/user.dart';
import 'package:bloom/components/ListTiles/List_Historique.dart';
import 'package:bloom/notifiers/tempNotifier.dart';
import 'package:bloom/screen/plants.dart';
import 'package:bloom/services/plant_firebase_service.dart';
import 'package:bloom/watering_modes/manual_mode.dart';
import 'package:bloom/watering_modes/programmed_mode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloom/components/mybutton.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Models/PlantsModel.dart';
import '../notifiers/plantNotifier.dart';
import '../services/authentification_firebase_service.dart';
import '../watering_modes/automatic_mode.dart';
class Watering extends StatefulWidget {
  const Watering({Key? key}) : super(key: key);

  @override
  State<Watering> createState() => _WateringState();
}
double ConvertToDouble(String string){
  var stringtonumber = double.parse(string);
  assert(stringtonumber is double);
  return stringtonumber;
}
Widget _makesuggestion(String name,String Place,String Image){
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 15),
    margin: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
    height: 80,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Color(0xffE3EDDF),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children:<Widget> [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget> [
            Text(
              name+' plant',
              textAlign: TextAlign.left,
              style: GoogleFonts.montserrat(
                color: Color(0xff515151),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              Place,
              style:GoogleFonts.montserrat(
                color: Color(0xffAAAAAA),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ) ,
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 20, top: 3),
              height: 20,
              width: 50,
              decoration: BoxDecoration(
                color: Color(0xffC2F0FF),
                borderRadius: BorderRadius.circular(19.0)
              ),
              child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(child:Icon(Icons.water_drop_outlined,size: 12,color: Color(0xff0B8BC1),)),
                    TextSpan(
                      text: '-100ml',
                      style: GoogleFonts.montserrat(
                        color: Color(0xff0B8BC1),
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                  ]
                ),
              ),
            )

          ],
        ),
        Spacer(),
        Container(
            alignment: Alignment.topRight,
            width: 80.0,
            height: 150.0,
            decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                    image: new AssetImage(Image)
                )
            )
        ),

      ],
    ),

  );
}

Widget _showSuggestions(List<Plant> myPlants,PlantService plantService, TempNotifier tempNotifier){
  int i=0;
  return Container(
    child: SingleChildScrollView(
      child: Column(
        children: [
            for(var item in myPlants)...[
              (() {
               if(tempNotifier.currenttempList.isNotEmpty && i<tempNotifier.currenttempList.length && tempNotifier.currenttempList[i].compareTo('20')==1){
                 i++;
                 return  _makesuggestion(item.Plant_Name!, item.Plant_Cat!, /*item.Plant_Image!*/ 'img/cactus.png');
                } else{
                  i++;
                  return Container();
                }
              }()),
            ]
        ],
      ),
    ),
  );
}


class _WateringState extends State<Watering> {
  PlantService plantService = PlantService();
  User? user = FirebaseAuth.instance.currentUser;
  authenticationService auth = authenticationService();

  @override
  void initState() {
    super.initState();
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context, listen: false);
    plantService.getPlants(plantNotifier, user!);
    TempNotifier tempNotifier = Provider.of<TempNotifier>(context, listen: false);
    plantService.getList(tempNotifier, plantNotifier.plantList);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context);
    TempNotifier tempNotifier = Provider.of<TempNotifier>(context);
    return
      Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select your mode',
                      style: GoogleFonts.montserrat(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Whether you are  at home or not, you have time or not you can always water your plants ',
                      style: GoogleFonts.montserrat(
                        color: Color(0xffAAAAAA),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left:30 ,right: 10,top: 10,bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child:Stack(
                        children:<Widget> [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyButton(label: 'Manual',height: 50,width: 160,size: 18,hasBeenPressed: false, onTap:()=> Get.to(ManualMode())),
                              SizedBox(height: size.height*0.02),
                              MyButton(label: 'Programmed',height: 50,width: 160,size: 15,hasBeenPressed: false, onTap: ()=> Get.to(ProgrammedMode())),
                              SizedBox(height: size.height*0.02),
                              MyButton(label: 'Automatic',height: 50,width: 160,size: 18,hasBeenPressed: false, onTap: ()=> Get.to(AutomaticMode())),
                              SizedBox(height: size.height*0.02),
                            ],
                          )
                        ],
                      )
                    ),
                    GestureDetector(
                      onTap: ()=> Get.to(ListHistorique()),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 0),
                        height: 180,
                        width:160,
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(16.0) ,
                          gradient: LinearGradient(
                              colors: [
                                Color(0xffE3EDDF),
                                Color(0xb3e3eddf),
                                Color(0x1ae3eddf),
                              ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        ),
                        child: Column(
                          children: [
                            Text(
                              'See history',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                color: Color(0xff515151),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5,),
                            Icon(
                              Icons.history_outlined,
                              color: Color(0xff0B8BC1),
                              size: 130,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),

              ),
              Container(
                margin: const EdgeInsets.only(left: 20,top:30),
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Suggestions',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                  ),
                ),
              ),
              _showSuggestions(plantNotifier.plantList,plantService,tempNotifier,),
            ],
          ),
        ),
      );

  }
}
