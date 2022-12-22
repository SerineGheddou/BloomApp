import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../Models/PlantsModel.dart';
import '../../../notifiers/plantNotifier.dart';
import '../../../services/plant_firebase_service.dart';
import 'box_fruit_vegetables.dart';

class PartFruitVegatbles extends StatefulWidget {
  const PartFruitVegatbles({Key? key}) : super(key: key);
  _PartFruitVegatblesState createState() => _PartFruitVegatblesState();
}

class _PartFruitVegatblesState extends State<PartFruitVegatbles>{
  User? user = FirebaseAuth.instance.currentUser;
  PlantService plantService = PlantService();
  @override
  void initState() {
    super.initState();
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context, listen: false);
    plantService.getPlants(plantNotifier, user!);
  }
  @override
  Widget build(BuildContext context) {
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child:Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: <Widget>[
            for(int i=0; i<plantNotifier.plantList.length;i++)...[
              ((){
              if(plantNotifier.plantList[i].Plant_Cat == "Fruits and veggies" && plantNotifier.plantList[i].Plant_Name != null ){
                return BoxFruitVegatble(plant: plantNotifier.plantList[i],);
              } else {
                return Container();
            }
              }())
            ],
          ],
        ),
      ),
    );
  }
}


