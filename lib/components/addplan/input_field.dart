import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final FormFieldValidator? validators;
  final Widget? widget;

  const MyInputField({Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.validators,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:16),
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
            margin: EdgeInsets.only(top: 8.0),
            padding: EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(12)
            ),
            child:Row(
              children: [
                Expanded(
                    child: TextFormField(
                      controller : controller,
                      validator: (value){
                        if (value!.isEmpty){
                          return("This field is required");
                        }
                      },
                      onSaved: (value){
                        controller?.text = value!;
                      },
                      readOnly: widget==null?false:true,
                      autofocus: false,
                      cursorColor: Colors.grey[700],
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
