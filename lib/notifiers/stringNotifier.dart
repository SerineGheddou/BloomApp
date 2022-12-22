import 'dart:collection';
import 'package:flutter/cupertino.dart';

class StringNotifier with ChangeNotifier {
  List<String> _List = [];
  late String _currentList;

  UnmodifiableListView<String> get stringList => UnmodifiableListView(_List);

  String get currentList => _currentList;

  set stringList (List<String> stringList) {
    _List = stringList;
    notifyListeners();
  }

  set currentList (String stringlist) {
    _currentList = stringlist;
    notifyListeners();
  }

}