
import 'dart:collection';
import 'package:flutter/cupertino.dart';
import '../Models/PlantsModel.dart';

class PlantNotifier with ChangeNotifier {
  List<Plant> _plantList = [];
  late Plant _currentPlant;

  UnmodifiableListView<Plant> get plantList => UnmodifiableListView(_plantList);

  Plant get currentPlant => _currentPlant;

  set plantList (List<Plant> plantList) {
    _plantList = plantList;
    notifyListeners();
  }

  set currentList (Plant plant) {
    _currentPlant = plant;
    notifyListeners();
  }

}