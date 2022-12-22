import 'package:bloom/Models/user.dart';
import 'package:bloom/profile/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/authentification_firebase_service.dart';
// LOGIN SCREEN
class Login extends StatefulWidget {
  Login({Key? key, this.onTap}) : super(key: key);
  final Function() ? onTap;

  @override
  State<Login> createState() => _LoginState();
}

Widget  buildEmail(BuildContext context,TextEditingController _emailController) {
  Size size = MediaQuery.of(context).size;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: size.height*0.02),
      TextFormField(
        autofocus: false,
        controller: _emailController,
        keyboardType:  TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          _emailController.text = value!;
        },
        style: TextStyle(
            color: Colors.black87
        ),
        textInputAction: TextInputAction.next,
        decoration:InputDecoration(
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none
                )
            ),
            fillColor:Color(0xffFBFCF0),
            contentPadding: EdgeInsets.only(top:14),
            prefixIcon: Icon(Icons.person, color: Color(0xff678D58)
            ),
            hintText: 'Enter your email adress',
            hintStyle: GoogleFonts.montserrat(
                color:  Color(0xffC1C1C1)
            )
        ),
      ),
    ],
  );
}

Widget  buildPassword(TextEditingController _passwordController) {

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 10),
      TextFormField(
        autofocus: false,
        controller:  _passwordController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        onSaved: (value) {
          _passwordController.text = value!;
        },
        style: TextStyle(
            color: Colors.black87
        ),
        textInputAction: TextInputAction.done,
        decoration:InputDecoration(
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none
                )
            ),
            fillColor: Color(0xffFBFCF0),
            contentPadding: EdgeInsets.only(top:14),
            prefixIcon: Icon(Icons.lock, color: Color(0xff678D58)),
            hintText: 'Password',
            hintStyle: GoogleFonts.montserrat(
                color:  Color(0xffC1C1C1)
            )
        ),
      ),
    ],
  );
}

Widget buildFrogotPassBtn(){
  return Container(
    alignment: Alignment.centerRight,
    child: FlatButton(
      onPressed: () =>print("Forgot password"),
      padding: EdgeInsets.only(right: 0),
      child: Text(
        'Recover password ',
        style: GoogleFonts.montserrat(
            fontSize: 12,
            color: Color(0xcc9f9f9f),
            fontWeight: FontWeight.bold
        ),
      ),
    ),
  );
}

Widget buildLoginBtn(context,Future loginEmailPassword, GlobalKey <FormState> key){
  Size size = MediaQuery.of(context).size;

  return Container(
    padding: EdgeInsets.symmetric(vertical: size.height*0.01),
    width: 250,
    child: RaisedButton(
      elevation: 5,
      onPressed: () {
        //test the app
        if(key.currentState!.validate()){
         loginEmailPassword;
        }
      },
      padding: EdgeInsets.all(14),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      color: Color(0xff678D58),
      child:  Text(
        'Log in',
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget buildSignUp() {
  return GestureDetector(
    onTap: () => Get.to(Signup()),
    child: RichText(
      text: TextSpan(
          children: [
            TextSpan(
                text: 'Don\'t have an account?',
                style: GoogleFonts.montserrat(
                    color: Color(0xe69f9f9f),
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                )
            ),
            TextSpan(
                text: ' Register now ',
                style: GoogleFonts.poppins(
                    color:  Color(0xff1787dc),
                    fontSize: 12,
                    fontWeight: FontWeight.bold
                )
            )
          ]
      ),
    ),
  );
}

Widget insertLogo(context){
  Size size = MediaQuery.of(context).size;
  return Column(
    children:<Widget> [
      Padding(
          padding: EdgeInsets.fromLTRB(30, 50, 30, 10),
          child:Image(
            image: AssetImage(
                "img/Logo_Cage.png"
            ),
            height: size.height*0.25,
            width: 225,
          )
      ),
    ],
  );
}

Widget _buildSignInWithText(context) {
  Size size= MediaQuery.of(context).size;
  return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height*0.01),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '------------------------',
            style: TextStyle(
              color: Colors.black54,
              letterSpacing: -1,
            ),
          ),
          Text(
            '     Or Continue with    ',
            style: GoogleFonts.montserrat(
                color: Colors.black54,
                fontSize: 12,
                fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '-------------------------',
            style: TextStyle(
              color: Colors.black54,
              letterSpacing: -1,
            ),
          ),
        ],
      )
  );
}

Widget _buildIconRow(BuildContext context){
  Size size= MediaQuery.of(context).size;
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      IconButton(
          padding:EdgeInsets.only( top:size.height*0.04, bottom: size.height*0.04) ,
          iconSize: 70,
          onPressed: (){
            //Provider.of<LoginController>(context, listen: false).googleLogin();
          },
          icon: new Image.asset( "icons/facebook.png")
      ),
      IconButton(
          padding:EdgeInsets.only(left: size.width*0.05,top:size.height*0.04, bottom: size.height*0.04) ,
          iconSize: 80,
          onPressed: ()=>Null,
          icon: new Image.asset( 'icons/apple.png')
      ),
      IconButton(
          padding:EdgeInsets.only(left:  size.width*0.05, top:size.height*0.04, bottom: size.height*0.04) ,
          iconSize: 57,
          onPressed: (){
            //Provider.of<LoginController>(context, listen: false).facebooklogin();
          },
          icon: new Image.asset( 'icons/google.png')
      ),
    ],
    // ),
  );
}



class _LoginState extends State<Login> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // string for displaying the error Message
  String? errorMessage;

  //editing controller
  final  emailController = TextEditingController();
  final  passwordController = TextEditingController();

  //firebase
  final _auth = FirebaseAuth.instance;

  //Authentication service
  authenticationService authService = authenticationService();

  //Creating a new userModel
  UserModel userModel = UserModel();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor:  Colors.white,
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
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Form(
                  key: _formKey,
                  child:  Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: size.width*0.12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: size.height*0.065),
                          insertLogo(context),
                          SizedBox(height: size.height*0.06),
                          buildEmail(context,emailController),
                          SizedBox(height: size.height*0.006),
                          buildPassword(passwordController),
                          buildFrogotPassBtn(),
                          buildLoginBtn(context,userModel.seConnecter(emailController.text, passwordController.text, context),_formKey),
                          SizedBox(height: size.height*0.006),
                          _buildSignInWithText(context),
                          _buildIconRow(context),
                          //loginUI(),
                          Padding(
                            padding:EdgeInsets.only(bottom: size.height*0.0015,top:size.height*0.002),
                            child: buildSignUp(),
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }



}

