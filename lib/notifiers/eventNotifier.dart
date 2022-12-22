
import 'dart:collection';

import 'package:bloom/Models/event.dart';
import 'package:flutter/cupertino.dart';

class EventNotifier with ChangeNotifier {
  List<EventModel> _eventList = [];
  late EventModel _currentEvent;

  UnmodifiableListView<EventModel> get eventList => UnmodifiableListView(_eventList);

  EventModel get currentEvent => _currentEvent;

  set eventList (List<EventModel> eventList) {
    _eventList = eventList;
    notifyListeners();
  }

  set currentEvent (EventModel eventModel) {
    _currentEvent = eventModel;
    notifyListeners();
  }

}