import 'package:flutter/cupertino.dart';
import 'package:bloom/my_plants/Fruits_Vegetables/fruits_vegetables.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Models/PlantsModel.dart';

class ButtonFruitsVrgetable extends StatelessWidget {
   ButtonFruitsVrgetable({
    Key? key,
    required this.plant
  }) : super(key: key);
  Plant plant;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top:140,bottom: 10,left: 25,right: 25),
      height: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffF2F5CC),
        boxShadow: [BoxShadow(
          color: Colors.grey.withOpacity(0.4),
          spreadRadius:1,
          blurRadius: 20,
          offset:Offset(0,7),
        ),
        ],
      ),
      child: Text(
        plant.Plant_Name! ,
        style: GoogleFonts.montserrat(
            fontSize:15,
            fontWeight: FontWeight.bold,
            color: Colors.black
        ),
      ),
    );
  }
}
