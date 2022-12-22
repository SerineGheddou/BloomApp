import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleWithCustomUderline extends StatelessWidget {
  const TitleWithCustomUderline({
    Key? key,
    required this.text
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return  Container(
      //height: 24,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              text,
              style: GoogleFonts.montserrat(fontSize: 19,fontWeight: FontWeight.bold,color: Color(0xff585757)),
            ),
          ),
        ],
      ),
    );
  }
}