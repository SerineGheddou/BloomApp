import 'package:bloom/plant_details/plant_detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../Models/PlantsModel.dart';
import '../../../notifiers/plantNotifier.dart';
import '../../../services/plant_firebase_service.dart';

class BuildBox extends StatefulWidget {
  final String categorie;
  final String imgPath;
  final double size;
  const BuildBox({Key? key, required this.categorie, required this.imgPath, required this.size}) : super(key: key);
  _BuildBoxState createState() => _BuildBoxState();
}
Widget _BuildOtherBoxes(String imgPath,Plant Plantname,context,double sizes){
  Size size = MediaQuery.of(context).size;
  return InkWell(
    onTap: ()=> Get.to(PlantDetail(plant: Plantname)),
    child: Stack(
      children: [
        Container(
          height: size.height*0.4,
          width: 200.0,
        ),
        Positioned(
          top: 28.0,
          child: Container(
            height: 240.0,
            width: 172.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Color(0xffF2F5CC),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(Plantname.Plant_Name!,
                      style: GoogleFonts.montserrat(
                          fontSize: 16.0,
                          color: Color(0xff515151),
                          fontWeight: FontWeight.bold)
                  ),
                ),
                SizedBox(height: 3.0,),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0,bottom: 12),
                  child: Text(
                      'Tap to see more details ',
                      style: GoogleFonts.montserrat(
                          fontSize: 12.0,
                          color: Color(0xff678D58).withOpacity(0.6),
                          fontWeight: FontWeight.w400)),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: sizes,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 220.0,
            width: 150.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(imgPath),
                    fit:BoxFit.cover
                )
            ),
          ),
        ),
      ],
    ),
  );
}

class _BuildBoxState extends State<BuildBox> {
  User? user = FirebaseAuth.instance.currentUser;
  PlantService plantService = PlantService();
  @override
  void initState() {
    super.initState();
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context, listen: false);
    plantService.getPlants(plantNotifier, user!);
  }
  @override
  Widget build(BuildContext context) {
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context);
    return  SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: <Widget>[
            for(int i=0; i<plantNotifier.plantList.length;i++)...[
              ((){
                if(plantNotifier.plantList[i].Plant_Cat == widget.categorie && plantNotifier.plantList[i].Plant_Name != null){
                  return _BuildOtherBoxes(/*plantNotifier.plantList[i].Plant_Image!*/widget.imgPath,
                      plantNotifier.plantList[i], context,widget.size);
                } else {
                  return Container();
                }
              }())
            ],
          ],
        ),
      ),
    );
  }
}

