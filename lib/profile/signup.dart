import 'package:bloom/Models/user.dart';
import 'package:bloom/main_screen.dart';
import 'package:bloom/services/event_firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../services/authentification_firebase_service.dart';


class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}
Widget insertLogo(){
  return Column(
    children:<Widget> [
      Padding(
          padding: EdgeInsets.fromLTRB(30, 50, 30, 10),
          child: Image(
            image: AssetImage(
                "img/Logo_Cage.png"
            ),
            height:150 ,
            width: 150,
          )
      ),
    ],
  );
}
Widget  buildName(TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 10),
      TextFormField(
          controller: controller,
          keyboardType:  TextInputType.name,
          validator: (value){
            RegExp regex= new RegExp(r'^.{3,}$');
            if(value!.isEmpty){
              return ("Please Enter your name");
            }
            if(!regex.hasMatch(value)){
              return ("Enter a valid name(Min. 3 Character)");
            }
            return null;
          },
          onSaved: (value){
            controller.text=value!;
          },
          style: TextStyle(
              color: Colors.black87
          ),
          decoration: InputDecoration(
              fillColor: Color(0xffFBFCF0) ,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none
                )
              ),
              contentPadding: EdgeInsets.only(top:14),
              prefixIcon: Icon(
                  Icons.person,
                  color: Color(0xff678D58)
              ),
              hintText: 'Enter your full name',
              hintStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  color:  Color(0xffC1C1C1)
              )
          ),
        ),
    ],
  );
}
Widget  buildEmail(TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 10),
      TextFormField(
          controller: controller,
          keyboardType:  TextInputType.emailAddress,
          onSaved: (value){
             controller.text=value!;
             },
          validator: (value){
            if(value!.isEmpty){
              return ("Please Enter your email");
            }
            if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                .hasMatch(value)){
              return "Enter a valid email";
            }
            return null;
          },
          style: TextStyle(
              color: Colors.black87
          ),
          decoration: InputDecoration(
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none
                  )
              ),
              fillColor: Color(0xffFBFCF0) ,
              contentPadding: EdgeInsets.only(top:14),
              prefixIcon: Icon(
                  Icons.email,
                  color: Color(0xff678D58)
              ),
              hintText: 'Enter email',
              hintStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  color:  Color(0xffC1C1C1)
              )
          ),
        ),
    ],
  );
}
Widget  buildPhoneNumber(TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 10),
      TextFormField(
          controller: controller,
          keyboardType:  TextInputType.number,
          validator: (value){
            return null;
          },
          style: TextStyle(
              color: Colors.black87
          ),
          decoration: InputDecoration(
              fillColor: Color(0xffFBFCF0) ,
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none
                  )
              ),
              contentPadding: EdgeInsets.only(top:14),
              prefixIcon: Icon(
                  Icons.phone,
                  color: Color(0xff678D58)
              ),
              hintText: 'Enter phone number',
              hintStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  color:  Color(0xffC1C1C1)
              )
          ),
        ),
    ],
  );
}
Widget  buildPassword(TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 10),
      TextFormField(
          autofocus: false,
          obscureText: true,
          controller: controller,
          validator: (value){
             RegExp regex = new RegExp(r'^.{6,}$');
             if(value!.isEmpty){
                 return ("Password is required to sign in");
             }
             if(!regex.hasMatch(value)){
               return ("Enter a valid password (Min. 6 Character)");
             }
             return null;
             },
          onSaved: (value){
            controller.text=value!;
          },
          textInputAction: TextInputAction.next,
          style: TextStyle(
              color: Colors.black87
          ),
          decoration: InputDecoration(
              fillColor: Color(0xffFBFCF0) ,
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none
                  )
              ),
              contentPadding: EdgeInsets.only(top:14),
              prefixIcon: Icon(
                  Icons.lock,
                  color: Color(0xff678D58)
              ),
              hintText: 'Password',
              hintStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  color:  Color(0xffC1C1C1)
              )
          ),
        ),
    ],
  );
}
Widget  buildConfirmPassword(TextEditingController controller, TextEditingController mdpController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 10),
      TextFormField(
         controller: controller,
         onSaved: (value){
          controller.text=value!;
          },
          validator: (value){
            if( mdpController.text != value){
              return ("Password doesn't match");
            }
            return null;
          },
          textInputAction: TextInputAction.next,
          obscureText: true,
          style: TextStyle(
              color: Colors.black87
          ),
          decoration: InputDecoration(
              fillColor: Color(0xffFBFCF0) ,
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none
                    )
              ),
              contentPadding: EdgeInsets.only(top:14),
              prefixIcon: Icon(
                  Icons.lock,
                  color: Color(0xff678D58)
              ),
              hintText: 'Confirm your Password',
              hintStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  color:  Color(0xffC1C1C1)
              )
          ),
        ),
    ],
  );
}
Widget buildSignUpBtn(Future SignUp){
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10),
    width: 250,
    child: RaisedButton(
      elevation: 5,
      onPressed: () {
        SignUp;
      },
      padding: EdgeInsets.all(14),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      color: Color(0xff678D58),
      child: Text(
        'Sign up',
        style: TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}



class _SignupState extends State<Signup> {
  final _auth = FirebaseAuth.instance;
  //Our form Key
  final _formkey= GlobalKey<FormBuilderState>();
  //editing Controllers
  final nameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final mdpEditingController = new TextEditingController();
  final confirmMdpEditingController = new TextEditingController();
  final phoneNumEditingController = new TextEditingController();
  authenticationService authService = authenticationService();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        decoration: BoxDecoration(
              image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                  "img/tropical-background.png"
               )
              )
            ),
        child: FormBuilder(
          key: _formkey,
          autovalidateMode:  AutovalidateMode.onUserInteraction,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  SizedBox(height: size.height*0.03),
                  insertLogo(),
                  SizedBox(height: size.height*0.05),
                  buildName(nameEditingController),
                  SizedBox(height: size.height*0.01),
                  buildEmail(emailEditingController),
                  SizedBox(height: size.height*0.01),
                  buildPhoneNumber(phoneNumEditingController),
                  SizedBox(height: size.height*0.01),
                  buildPassword(mdpEditingController),
                  SizedBox(height: size.height*0.01),
                  buildConfirmPassword(confirmMdpEditingController,mdpEditingController),
                  SizedBox(height: size.height*0.025),
                  buildSignUpBtn(authService.SignUp(emailEditingController.text, mdpEditingController.text,nameEditingController.text,context)),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

}
