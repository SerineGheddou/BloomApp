import 'package:bloom/Models/user.dart';
import 'package:bloom/components/appBar.dart';
import 'package:bloom/screen/calendar.dart';
import 'package:bloom/screen/plants.dart';
import 'package:bloom/screen/watering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  _MainScreen createState() => _MainScreen();
}
class _MainScreen extends State<MainScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel connectedUser = UserModel();

  Future<void> getUserData() async{
    FirebaseFirestore.instance.collection("users").doc(user?.uid).get().then((_)=> print('Success'));
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection("users").doc(user?.uid).get();
    connectedUser = UserModel.fromMap(documentSnapshot);
  }
  @override
  void initState(){
    super.initState();
    setState(() {
      getUserData();
    });
  }
  GlobalKey _NavKey = GlobalKey();
  List PagesAll=[] ;
  var TitlePages = ['My Plants','Watering','Calender'];
  var myindex =0;

  @override
  Widget build(BuildContext context) {
    PagesAll.add(Plants(userModel:this.connectedUser!));
    PagesAll.add(Watering());
    PagesAll.add(Calendar(this.connectedUser!));
    return Scaffold(
      extendBody: true,
      backgroundColor: Color(0XffF9FEFF),
      bottomNavigationBar: CurvedNavigationBar(
        height: 55,
        backgroundColor: Colors.transparent,
        key: _NavKey,
        items:[
          ImageIcon(AssetImage('icons/my_plants.png'),size:33,color: Colors.white),
          ImageIcon(AssetImage('icons/Vector.png'),size:33,color: Colors.white),
          ImageIcon(AssetImage('icons/agenda.png'),size:33,color: Colors.white),


        ],
        buttonBackgroundColor: Color(0Xe6678D58),
        onTap: (index){
          setState(() {
            myindex = index;
          });
        },
        animationCurve: Curves.fastLinearToSlowEaseIn, color: Color(0xe6678d58),
        animationDuration: const Duration(seconds: 2 ),
      ),
      body: PagesAll[myindex],
      appBar:MyAppBar(Heading:TitlePages[myindex]),
    );
  }
}

