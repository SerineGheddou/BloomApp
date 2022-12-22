import 'package:bloom/styles/size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


Color kPrimaryColor = Color(0xffd3d59b);
Color kSecondaryColor = Color(0xff678D58);

final kTitle = GoogleFonts.montserrat(
  fontSize: SizeConfig.blockSizeH! * 7,
  color: kSecondaryColor,
);

final kBodyText1 = TextStyle(
  color: kSecondaryColor,
  fontSize: SizeConfig.blockSizeH! * 4.5,
  fontWeight: FontWeight.bold,
);