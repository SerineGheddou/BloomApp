import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
class MyInputFieldProgrammed extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  const MyInputFieldProgrammed({Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30,vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.montserrat(
              color: Color(0xff678D58),
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          Container(
            height: 40,
            width: 160,
            margin: EdgeInsets.only(top: 5),
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
                color: Color(0xffF2F5CC) ,
                border: Border.all(
                  color: Color(0xffF2F5CC),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(16)
            ),
            child:Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        readOnly: widget==null?false:true,
                        autofocus: false,
                        cursorColor: Color(0xff678D58),
                        controller: controller,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.montserrat(
                          color: Color(0xff678D58),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                            hintText: hint,
                            hintStyle: GoogleFonts.montserrat(
                              color: Color(0xff515151),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                        ),
                      ),
                    )
                ),
                widget==null?Container():Container(child:widget)
              ],
            ) ,
          )
        ],
      ),
    );
  }
}
