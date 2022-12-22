import 'package:bloom/notifiers/TempHumNotifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Models/PlantsModel.dart';
import '../notifiers/plantNotifier.dart';
import '../notifiers/userNotifier.dart';
import '../services/authentification_firebase_service.dart';
import '../services/plant_firebase_service.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'Barchart.dart';
import 'Line_chart_hum.dart';
import 'Line_chart_temp.dart';


class  PlantDetailFruit extends StatefulWidget {
  Plant plant;
  PlantDetailFruit({Key? key,required this.plant}) : super(key: key);

  @override
  State< PlantDetailFruit> createState() => _PlantDetailFruitState();
}
Widget _BuildOtherBoxes(String imgPath,String Plantname,context){
  Size size = MediaQuery.of(context).size;
  return InkWell(
    child: Stack(
      children: [
        Container(
          height: size.height*0.4,
          width: 250.0,
        ),
        Positioned(
          top: 28.0,
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: 50,horizontal: 40),
            height: 240.0,
            width: 172.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Color(0xffF2F5CC),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0,bottom: 15.0),
                  child: Text(Plantname,
                      style: GoogleFonts.montserrat(
                          fontSize: 19.0,
                          color: Color(0xff515151),
                          fontWeight: FontWeight.bold)
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 42.0,
          top: 80,
          child: Container(
            alignment: Alignment.center,
            height: 180.0,
            width: 160.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("img/FruitsVegeBasket.png"),
                    fit:BoxFit.cover
                )
            ),
          ),
        ),
      ],
    ),
  );
}
Widget _BuildhumBoxes(String name,double _dowloadPercentage,context){
  Size size = MediaQuery.of(context).size;
  return InkWell(
    child: Stack(
      children: [
        Container(
          height: size.height*0.4,
          width: 200.0,
        ),
        Positioned(
          top: 28.0,
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              height: 240.0,
              width: 175.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Color(0xffF2F5CC),
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top:15.0),
                    child: Text(name,
                        style: GoogleFonts.montserrat(
                            fontSize: 18.0,
                            color: Color(0xff515151),
                            fontWeight: FontWeight.bold)
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    width: 135,
                    child: SfRadialGauge(axes: <RadialAxis>[
                      // Create primary radial axis
                      RadialAxis(
                          minimum: 0,
                          maximum: 100,
                          showLabels: false,
                          showTicks: false,
                          axisLineStyle: const AxisLineStyle(
                            thickness: 0.2,
                            cornerStyle: CornerStyle.bothCurve,
                            color: Color.fromARGB(30, 0, 169, 181),
                            thicknessUnit: GaugeSizeUnit.factor,
                          ),
                          pointers: <GaugePointer>[
                            RangePointer(
                                value: _dowloadPercentage,
                                width: 0.2,
                                sizeUnit: GaugeSizeUnit.factor,
                                cornerStyle: CornerStyle.startCurve,
                                enableAnimation: true,
                                animationDuration: 400,
                                animationType: AnimationType.linear,
                                gradient: const SweepGradient(colors: <Color>[
                                  Color(0xFF00a9b5),
                                  Color(0xFFa4edeb)
                                ], stops: <double>[
                                  0.25,
                                  0.75
                                ])),
                            MarkerPointer(
                              value: _dowloadPercentage,
                              markerType: MarkerType.circle,
                              color: const Color(0xFF87e8e8),
                            )
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                                positionFactor: 0.1,
                                angle: 90,
                                widget: Text(_dowloadPercentage.toStringAsFixed(0) + ' / 100',
                                  style:GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.bold),
                                )
                            ),
                          ]
                      ),
                    ]
                    ),
                  )


                ],
              )
          ),
        ),
      ],
    ),
  );
}
Widget _BuildtempBoxes(String name,double _dowloadPercentage,context){
  Size size = MediaQuery.of(context).size;
  return InkWell(
    child: Stack(
      children: [
        Container(
          height: size.height*0.4,
          width: 200.0,
        ),
        Positioned(
          top: 28.0,
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 240.0,
              width: 175.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Color(0xffF2F5CC),
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top:15.0),
                    child: Text(name,
                        style: GoogleFonts.montserrat(
                            fontSize: 18.0,
                            color: Color(0xff515151),
                            fontWeight: FontWeight.bold)
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    width: 135,
                    child: SfRadialGauge(axes: <RadialAxis>[
                      // Create primary radial axis
                      RadialAxis(
                          minimum: 0,
                          maximum: 100,
                          showLabels: false,
                          showTicks: false,

                          axisLineStyle: const AxisLineStyle(
                            thickness: 0.2,
                            cornerStyle: CornerStyle.bothCurve,
                            color: Color(0x5ccad4e3),
                            thicknessUnit: GaugeSizeUnit.factor,
                          ),
                          pointers: <GaugePointer>[
                            RangePointer(
                                value: _dowloadPercentage,
                                width: 0.2,
                                sizeUnit: GaugeSizeUnit.factor,
                                cornerStyle: CornerStyle.startCurve,
                                enableAnimation: true,
                                animationDuration: 400,
                                animationType: AnimationType.linear,
                                gradient: const SweepGradient(colors: <Color>[
                                  Color(0xffffbc47),
                                  Color(0x6dffbc47)
                                ], stops: <double>[
                                  0.25,
                                  0.75
                                ])),
                            MarkerPointer(
                              value: _dowloadPercentage,
                              markerType: MarkerType.circle,
                              color: const  Color(0xffffbc47),
                            )
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                                positionFactor: 0.1,
                                angle: 90,
                                widget: Text(_dowloadPercentage.toStringAsFixed(0) + ' / 100',
                                  style: GoogleFonts.montserrat(fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                            ),
                          ]
                      ),
                    ]
                    ),
                  )

                ],
              )
          ),
        ),
      ],
    ),
  );
}


class _PlantDetailFruitState extends State< PlantDetailFruit> {
  User? user = FirebaseAuth.instance.currentUser;
  authenticationService auth = authenticationService();
  PlantService plantService = PlantService();
  @override
  void initState() {
    super.initState();
    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
    auth.getUser(userNotifier, user!);
    TempHumNotifier TemphNotifier = Provider.of<TempHumNotifier>(context, listen: false);
    plantService.gettTemp(TemphNotifier, widget.plant);
    plantService.gettHum(TemphNotifier, widget.plant);
  }
  @override
  Widget build(BuildContext context) {
    TempHumNotifier TempcNotifier = Provider.of<TempHumNotifier>(context);
    Size size = MediaQuery.of(context).size;
    print('plant detail');
    print(TempcNotifier.currenttempget);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My plant',
          style: GoogleFonts.montserrat(
            color: Color(0xffF2F5CC),
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation:0,
        backgroundColor: Color(0xff678D58),
        leading:GestureDetector(
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 25,
            ),
            onPressed:(){
              Get.back();
            } ,
            color: Color(0xffF2F5CC),
          ),
        ),
      ),
      body:SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Column(
                  children:[
                    _BuildOtherBoxes("",widget.plant.Plant_Name!,context),
                    SizedBox(height:  size.height *0.001),
                    Row(
                      children:[
                        _BuildhumBoxes("Humidity",TempcNotifier.currentHumget,context), //A revoir
                        SizedBox(width: size.width*0.01,),
                        _BuildtempBoxes("Temperature",TempcNotifier.currenttempget,context),// A revoir
                      ],
                    ),
                    Text(
                      'Number of watering',
                      style:GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, bottom: 20),
                      child: BarChartSample(),
                    ),
                    Text(
                      'Humidity chart',
                      style:GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, bottom: 20),
                      child: LineChartSample(),
                    ),
                    Text(
                      'Temperature chart',
                      style:GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, bottom: 20),
                      child: LineChartSampleHum(),
                    ),


                  ]
              ),
            ]
        ),

      ),

    );
  }

}
