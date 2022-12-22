import 'dart:collection';
import 'package:flutter/cupertino.dart';

class StringPompNotifier with ChangeNotifier {
  List<String> _List = [];
  late String _currentList;

  UnmodifiableListView<String> get stringList => UnmodifiableListView(_List);

  String get currentList => _currentList;

  set stringPompList (List<String> stringpompList) {
    _List = stringpompList;
    notifyListeners();
  }

  set currentList (String stringpompelist) {
    _currentList = stringpompelist;
    notifyListeners();
  }

}