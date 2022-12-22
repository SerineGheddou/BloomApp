import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
class MyInputFieldnumber extends StatelessWidget {
  final String title;
  final String hint;
  final Color? color;
  final Color? color2;
  final TextEditingController? controller;
  final Widget? widget;

  const MyInputFieldnumber({Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget, this.color, this.color2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top:16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          Container(
            height: 52,
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
              color: color,
                border: Border.all(
                  color: color2!,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(12)
            ),
            child:Row(
              children: [
                Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]*'))],
                      readOnly: widget==null?false:true,
                      autofocus: false,
                      cursorColor: Colors.grey[700],
                      controller: controller,
                      style: GoogleFonts.montserrat(
                        color: Colors.grey[600],
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                          hintText: hint,
                          hintStyle: GoogleFonts.montserrat(
                            color: Colors.grey[600],
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: context.theme.backgroundColor,
                                  width: 0
                              )
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: context.theme.backgroundColor,
                                  width: 0
                              )
                          )
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
