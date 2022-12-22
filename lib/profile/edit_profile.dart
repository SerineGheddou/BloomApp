import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class EditProfile extends StatefulWidget{
  @override
  State<EditProfile> createState()=> _EditProfileState();

}
Widget buildUsername(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height:10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Color(0xffFBFCF0),
          borderRadius: BorderRadius.circular(15),
        ),
        height: 50,
        child: TextField(
          keyboardType: TextInputType.name,
          style: TextStyle(
              color: Colors.black87
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(
              Icons.person,
              color: Color(0xff678D58),
           ),
            hintText: 'yANCHUI',
            hintStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  color:  Color(0xffC1C1C1)
              )
          ),
        ),
      ),
    ],
  );
}
Widget  buildEmail() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 10),
      Container(
        alignment:  Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Color(0xffFBFCF0),
          borderRadius: BorderRadius.circular(15),
        ),
        height: 50,
        child: TextField(
          keyboardType:  TextInputType.emailAddress,
          style: TextStyle(
              color: Colors.black87
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top:14),
              prefixIcon: Icon(
                  Icons.email,
                  color: Color(0xff678D58)
              ),
              hintText: 'yanchui@gmail.com',
              hintStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  color:  Color(0xffC1C1C1)
              )
          ),
        ),
      )
    ],
  );
}
Widget buildPhoneNumber(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 10,),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Color(0xffFBFCF0),
          borderRadius: BorderRadius.circular(15),
        ),
        height: 50,
        child: TextField(
          keyboardType: TextInputType.number,
          style: TextStyle(
              color: Colors.black87
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.phone,
                color: Color(0xff678D58),
              ),
              hintText: '+14987889999',
              hintStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  color:  Color(0xffC1C1C1)
              )
          ),
        ),
      ),
    ],
  );
}
Widget  buildPassword() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 10),
      Container(
        alignment:  Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Color(0xffFBFCF0),
          borderRadius: BorderRadius.circular(15),
        ),
        height: 50,
        child: TextField(
          obscureText: true,
          style: TextStyle(
              color: Colors.black87
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top:14),
              prefixIcon: Icon(
                  Icons.lock,
                  color: Color(0xff678D58)
              ),
              hintText: '***********',
              hintStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  color:  Color(0xffC1C1C1)
              )
          ),
        ),
      )
    ],
  );
}
Widget buildUpdateBtn(){
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10),
    width: 250,
    child: RaisedButton(
      elevation: 5,
      onPressed: () =>print("Login pressed"),
      padding: EdgeInsets.all(14),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      color: Color(0xff678D58),
      child: Text(
        'Update',
        style: TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

class _EditProfileState extends State<EditProfile>{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff678D58),
        elevation: 0,
        toolbarHeight: 70.0,
        title: Text(
          'Edit profile',
          style: TextStyle(
            color: Color(0xffFFFFFF),
            fontSize: 15,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios,
            size: 20,
            color: Color(0xffFFFFFF),
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Container(
                height: 120,
                color: Color(0xff678D58),
              ),
              Expanded(
                  child: Container(
                       child: Stack(
                         children: [
                           SingleChildScrollView(
                             child: Container(
                               margin: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                               child: Column(
                                 children: [
                                   SizedBox(height: 50,),
                                     Text(
                                       'Change picture',
                                       style: TextStyle(
                                         fontFamily: 'Montserrat',
                                         fontSize: 12,
                                         fontWeight: FontWeight.bold
                                       ),
                                       textAlign: TextAlign.center,
                                     ),
                                   SizedBox(height: 30,),
                                   Align(
                                     alignment: Alignment.centerLeft,
                                     child: Text(
                                       'Username',
                                       style: TextStyle(
                                         color: Colors.black,
                                         fontWeight: FontWeight.bold,
                                         fontSize: 14,
                                         fontFamily: 'Monteserrat',
                                       ),
                                       textAlign: TextAlign.start,
                                     ),
                                   ),
                                   buildUsername(),
                                   SizedBox(height: 10,),
                                   Align(
                                     alignment: Alignment.centerLeft,
                                     child: Text(
                                       'Email address',
                                       style: TextStyle(
                                         color: Colors.black,
                                         fontWeight: FontWeight.bold,
                                         fontSize: 14,
                                         fontFamily: 'Monteserrat',
                                       ),
                                       textAlign: TextAlign.start,
                                     ),
                                   ),
                                   buildEmail(),
                                   SizedBox(height: 10,),
                                   Align(
                                     alignment: Alignment.centerLeft,
                                     child: Text(
                                       'Phone number',
                                       style: TextStyle(
                                         color: Colors.black,
                                         fontWeight: FontWeight.bold,
                                         fontSize: 14,
                                         fontFamily: 'Monteserrat',
                                       ),
                                       textAlign: TextAlign.start,
                                     ),
                                   ),
                                   buildPhoneNumber(),
                                   SizedBox(height: 10,),
                                   Align(
                                     alignment: Alignment.centerLeft,
                                     child: Text(
                                       'Password',
                                       style: TextStyle(
                                         color: Colors.black,
                                         fontWeight: FontWeight.bold,
                                         fontSize: 14,
                                         fontFamily: 'Monteserrat',
                                       ),
                                       textAlign: TextAlign.start,
                                     ),
                                   ),
                                   buildPassword(),
                                   SizedBox(height: 20,),
                                   buildUpdateBtn(),
                                 ],

                               ),
                             ),
                           ),
                         ],
                       ),
                  ),
              )
            ],
          ),
          Positioned(
            top: 50.0,
              child: Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white),
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('img/Profile.png') ,
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}