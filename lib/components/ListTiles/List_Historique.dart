import 'package:bloom/components/appBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Models/PlantsModel.dart';

class ListHistorique extends StatefulWidget {
  const ListHistorique({Key? key}) : super(key: key);

  @override
  State<ListHistorique> createState() => _ListHistoriqueState();
}

class _ListHistoriqueState extends State<ListHistorique> {
  Widget _buildHisElem(Plant root){
      return  Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Color(0xffF2F5CC),
            borderRadius: BorderRadius.circular(16)
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      root.Plant_Name!,
                      style: GoogleFonts.montserrat(
                        color: Color(0xff515151),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                  ),
                  Text(
                    root.Plant_Cat!,
                    style:GoogleFonts.montserrat(
                      color: Color(0xffAAAAAA),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ) ,
                  ),
                  Text(
                    'Last watered on\t'+root.Plant_His!.Date_Arro.day.toString()+'-'+root.Plant_His!.Date_Arro.month.toString()+'-'+
                        root.Plant_His!.Date_Arro.year.toString(),
                      style:GoogleFonts.montserrat(
                        color: Color(0xff0B8BC1),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                  )
                ],
              ),
            ],
          ),
        ),
        Positioned(
          right: 20,
            top: -30,
            child: Container(
                alignment: Alignment.topRight,
                width: 80.0,
                height: 160.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        image: new AssetImage(root.Plant_Image!),
                    )
                )
            )
        )
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(Heading: 'History'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40,vertical: 30),
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              decoration: BoxDecoration(
                color: Color(0xffFDEBE7),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.history,
                    size: 45,
                    color: Color(0xff678D58) ,
                  ),
                  Text(
                    '\t Here you can check when your \n \t plants were last watered',
                    style: TextStyle(
                      color: Color(0xff585757),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'monteserrat',
                    ),
                  ),
                ],
              ),
            ),
              for(var item in plants) _buildHisElem(item)
          ],
        ),
      ),
    );
  }
}
