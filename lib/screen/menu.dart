import 'package:bloom/profile/edit_profile.dart';
import 'package:bloom/services/authentification_firebase_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  authenticationService auth = authenticationService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff678D58),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff678D58),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.close,
                color: Color(0xffF2F5CC),
                size: 40,
              )
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 30),
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                    "img/tropical-background.png"
                )
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              child: Text(
                'Edit profile',
                    style:GoogleFonts.montserrat(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffF2F5CC)
                    )
              ),
              onTap: () => Get.to(EditProfile()),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              child: Text(
                  'Log out',
                  style:GoogleFonts.montserrat(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffF2F5CC)
                  )
              ),
              onTap: ()=> auth.logOut(),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              child: Text(
                  'Change language',
                  style:GoogleFonts.montserrat(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffF2F5CC)
                  )
              ),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              child: Text(
                  'Help',
                  style:GoogleFonts.montserrat(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffF2F5CC)
                  )
              ),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              child: Text(
                  'Contact us',
                  style:GoogleFonts.montserrat(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffF2F5CC)
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
