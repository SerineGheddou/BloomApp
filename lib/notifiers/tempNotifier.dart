import 'package:bloom/Models/user.dart';
import 'package:flutter/cupertino.dart';

class TempNotifier with ChangeNotifier {
  late List<String> _currenttempList = [];


  List<String> get currenttempList => _currenttempList;

  set currenttemp (List<String> currenttempList) {
    _currenttempList = currenttempList;
    notifyListeners();
  }

}