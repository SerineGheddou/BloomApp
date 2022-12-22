
import 'package:bloom/Models/PlantsModel.dart';
import 'package:bloom/plant_details/Plant_detail_fruit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import '../../../notifiers/plantNotifier.dart';
import '../../../services/plant_firebase_service.dart';
import 'button_fruits_vegetables.dart';

class BoxFruitVegatble extends StatefulWidget {
  final Plant plant;
  const BoxFruitVegatble({
    Key? key,
     required this.plant,
  }) : super(key: key);

  @override
  _BoxFruitVegatbleState createState() => _BoxFruitVegatbleState();
}

class _BoxFruitVegatbleState extends State<BoxFruitVegatble>{
  User? user = FirebaseAuth.instance.currentUser;
  PlantService plantService = PlantService();
  @override
  void initState() {
    super.initState();
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context, listen: false);

  }
  @override
  Widget build(BuildContext context) {
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context);
    plantService.getPlants(plantNotifier, user!);
    return  InkWell(
        onTap: ()=> Get.to(PlantDetailFruit(plant: widget.plant)),
        child:Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            //padding: EdgeInsets.all(1),
            width: 160,
            height: 180,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xffF2F5CC),
                image:DecorationImage(
                    image: AssetImage(/*getFruitsAndVeggiesList(plantNotifier)[widget.index].Plant_Image!*/"img/FruitsVegeBasket.png")
                )
            ),
            child: ButtonFruitsVrgetable( plant:widget.plant),
          ),
        )
    );
  }
}

