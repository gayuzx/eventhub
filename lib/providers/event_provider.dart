import 'package:flutter/material.dart';
import '../models/event_model.dart';

class EventProvider extends ChangeNotifier {
  List<Event> events = [];

  void setEvents(List<Event> list) {
    events = list;
    notifyListeners();
  }
}