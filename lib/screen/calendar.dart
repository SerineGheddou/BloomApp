
import 'package:bloom/Models/user.dart';
import 'package:bloom/components/addplan/add_plan.dart';
import 'package:bloom/notifiers/eventNotifier.dart';
import 'package:bloom/services/event_firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import 'package:bloom/components/mybutton.dart';
import 'package:bloom/Models/event.dart';

import '../components/ListTiles/Listevent.dart';
class Calendar extends StatefulWidget {
  UserModel userModel;
  Calendar(this.userModel);
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  EventService eventService = EventService();
  EventModel eventModel = EventModel();
  late EventModel events;
  User? user = FirebaseAuth.instance.currentUser;

  var data;
  @override
  void initState() {
    super.initState();
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
    eventService.getEvents(eventNotifier, user!);
  }


  @override
   Widget build(BuildContext context)  {
    Size size = MediaQuery.of(context).size;
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
              children:<Widget> [
                Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                  child: Text(
                                    ' Plan your plant’s watering                                      '
                                        ' and see your history',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: GoogleFonts.montserrat(
                                      color: Color(0xff585757),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                              )
                            ],
                          ),
                        ),
                const SizedBox(height: 5),
                Container(
                          margin: EdgeInsets.only(left: 10,right: 180,top: 5),
                          child:MyButton(label: '+ Add a plan',height:40,width: 150,size:15,hasBeenPressed: false, onTap: ()=> Get.to(AddPlanPage(userModel: widget.userModel,))),
                        ),
                Center (
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          height: size.height * 0.48,
                          width: size.width * 0.80,
                          padding: EdgeInsets.only(left:17.0,right:17.0 ,top:0.0,bottom:0.0 ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: const Color(0xe6f2f5cc),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x12000000),
                                offset: Offset(0, 7),
                                blurRadius: 24,
                              ),
                            ],
                          ),
                          child: TableCalendar(
                            focusedDay: selectedDay,
                            firstDay: DateTime(1990),
                            lastDay: DateTime(2050),
                            calendarFormat: format,
                            onFormatChanged: (CalendarFormat _format) {
                              setState(() {
                                format = _format;
                              });
                            },
                            startingDayOfWeek: StartingDayOfWeek.sunday,
                            daysOfWeekVisible: true,

                            //Day Changed
                            onDaySelected: (DateTime selectDay, DateTime focusDay) {
                              setState(() {
                                selectedDay = selectDay;
                                focusedDay = focusDay;
                              });
                              print(focusedDay);
                            },
                            selectedDayPredicate: (DateTime date) {
                              return isSameDay(selectedDay, date);
                            },
                            //To style the Calendar
                            calendarStyle: CalendarStyle(
                              isTodayHighlighted: true,
                              selectedDecoration: BoxDecoration(
                                color: Color(0xff678D58),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              selectedTextStyle: TextStyle(color: Colors.white),
                              todayDecoration: BoxDecoration(
                                color: Color(0xB3678D58),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              defaultDecoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              weekendDecoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            headerStyle: HeaderStyle(
                              formatButtonVisible:false,
                              titleTextStyle: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff121212),
                              ),
                              titleCentered: true,
                              formatButtonShowsNext: false,
                              formatButtonDecoration: BoxDecoration(
                                color: Color(0Xff678D58),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              formatButtonTextStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                Text(
                        'You activity for today',
                        textAlign: TextAlign.left ,
                        style: GoogleFonts.montserrat(
                            color: Color(0xff000000),
                            fontWeight: FontWeight.bold ,
                            fontSize: 22
                        ),
                      ),
                SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: eventNotifier.eventList.length,
                      itemBuilder: (BuildContext context, int index) {
                      if(eventNotifier.eventList[index].Date == selectedDay.day.toString()+'/'+selectedDay.month.toString()+'/'+selectedDay.year.toString()) {
                         return ListEvent(Title: eventNotifier.eventList[index].Title!, Place: '',
                            startTime: eventNotifier.eventList[index].startTime!
                            ,  dateTime: eventNotifier.eventList[index].Date!
                        );
                      } else {
                        return Container();
                      }
                      }
                  ),
                ),
              ],
            ),
      ),
    );
  }
    getUserModel() async{
      User? user = FirebaseAuth.instance.currentUser;
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection("users").doc(user?.uid).get();
      //Saving the data of the current user in the user model
      UserModel  usermodel = UserModel.fromMap(documentSnapshot);
      return usermodel;
  }
}