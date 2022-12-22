import 'package:flutter/cupertino.dart';

class TempHumNotifier with ChangeNotifier {
  late double _currenttemp=0.0 ;
  late double _currentHum=0.0;

  double get currenttempget => _currenttemp;
  double get currentHumget => _currentHum;

  set currenttempset (double currenttempget) {
    _currenttemp = currenttempget;
    notifyListeners();
  }

  set currenthumset (double currentHumpget) {
    _currentHum = currentHumget;
    notifyListeners();
  }

}