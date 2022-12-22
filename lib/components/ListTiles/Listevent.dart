import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class ListEvent extends StatelessWidget {
  final String Title;
  final String Place;
  final String startTime;
  final String dateTime;
  const ListEvent({Key? key, required this.Title, required this.Place, required this.startTime,  required this.dateTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 20,),
          padding: EdgeInsets.only(left: 10),
          width: 300,
          decoration: BoxDecoration(
            color: Color(0xffE3EDDF),
            border: Border(
              left: BorderSide(
                width: 5,
                color: Color(0xff678D58)
              )
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Title+', '+Place,
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                  fontSize:14 ,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff678D58)
                ),
              ),
                Text(
                  startTime,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Color(0xffAAAAAA),
                  ),
                ),
              Text(
                dateTime,
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Color(0xffAAAAAA),
                ),
              )

            ],
          ),
        ),
      ],
    );
  }
}
