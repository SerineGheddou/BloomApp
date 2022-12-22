import 'package:bloom/components/onboardnavbtn.dart';
import 'package:bloom/Data/onboard_data.dart';
import 'package:bloom/profile/login.dart';
import 'package:bloom/styles/size.dart';
import 'package:bloom/styles/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/mybutton.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  int currentPage =0;
  //Controller
  PageController _pagecontroller = PageController(initialPage: 0);

  AnimatedContainer dotIndicator(index){
    return AnimatedContainer(
      margin: EdgeInsets.only(right: 7),
      duration: Duration(milliseconds: 300),
      height: 12,
      width: (index == currentPage) ?30:10,
      //width=12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: currentPage == index ? kPrimaryColor:
            kSecondaryColor,
        //shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //initialize
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body:SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: PageView.builder(
                controller: _pagecontroller,
                onPageChanged: (value){
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: onboardingContents.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    SizedBox(height: SizeConfig.blockSizeV! * 10),
                    Text(onboardingContents[index].title,
                    style: GoogleFonts.montserrat(
                      fontSize: SizeConfig.blockSizeH! * 7,
                      color: Color(0xff678D58),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    ),
                    SizedBox( height: SizeConfig.blockSizeV! * 5),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 22),
                      height: SizeConfig.blockSizeV! *48 ,
                      child: Image.asset(
                        onboardingContents[index].image,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox( height: SizeConfig.blockSizeV! * 5),
                     Text(
                       'We Can Help You Take\n    Care Of Your Plant',
                       textAlign: TextAlign.center,
                       style:  GoogleFonts.montserrat(
                         fontSize: SizeConfig.blockSizeH! * 5,
                         color: Color(0xff678D58),
                         fontWeight: FontWeight.w600,
                       ),
                     ),
                    //SizedBox( height: SizeConfig.blockSizeV! *),
                  ],
                ),
             ),
            ),
            Expanded(
                flex:1,
                child: Column(
                  children: [
                    currentPage ==onboardingContents.length -1?
                    MyButton(label:'Get Started', height: SizeConfig.blockSizeH! *13.5, width: SizeConfig.blockSizeH! *68, size: SizeConfig.blockSizeH! *5,hasBeenPressed: false, onTap: ()=> Get.to(Login()))
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OnBoardNavBtn(name: 'Skip',OnPressed: () => Get.to(Login()),
                        ),
                        Row(
                          children: List.generate(onboardingContents.length,
                                  (index) => dotIndicator(index)),
                        ),
                        OnBoardNavBtn(name: 'Next', OnPressed: () {
                          _pagecontroller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.bounceInOut,);
                        },)
                      ],
                    ),
                  ],
                ),
            ),
          ],
        ),
      )
    );
  }
}

