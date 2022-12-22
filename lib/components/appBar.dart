import 'package:bloom/profile/edit_profile.dart';
import 'package:bloom/screen/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String Heading;
  const MyAppBar({Key? key, required this.Heading});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(Heading),
      titleTextStyle: GoogleFonts.montserrat(
        color: Color(0xff678D58),
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ) ,
      //centerTitle: false,
      backgroundColor: Colors.white,
        actions: [
          IconButton(
              alignment: Alignment.centerRight,
              onPressed: ()=> Get.to(Menu()),
              iconSize: 100,
              icon: new Image.asset( "icons/icoune.png")
          )
        ],
      );
  }



}