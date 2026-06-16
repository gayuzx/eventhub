import '../models/event_model.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationService {
  static final List<Event> _registeredEvents = [];

  static List<Event> getRegisteredEvents() => _registeredEvents;

  static Future<void> registerEvent(Event event) async {
  if (!_registeredEvents.any((e) => e.title == event.title)) {
    _registeredEvents.add(event);
    await saveRegistrations();
  }
}
  static Future<void> saveRegistrations() async {
  final prefs = await SharedPreferences.getInstance();

  final data = _registeredEvents
      .map((e) => jsonEncode(e.toJson()))
      .toList();

  await prefs.setStringList(
    'registered_events',
    data,
  );
}

static Future<void> loadRegistrations() async {
  final prefs = await SharedPreferences.getInstance();

  final savedData =
      prefs.getStringList('registered_events') ?? [];

  _registeredEvents.clear();

  _registeredEvents.addAll(
    savedData.map(
      (e) => Event.fromJson(
        jsonDecode(e),
      ),
    ),
  );
}

  static Future<void> cancelRegistration(Event event) async {
  _registeredEvents.removeWhere(
    (e) => e.title == event.title,
  );

  await saveRegistrations();
}
  static bool isRegistered(Event event) {
    return _registeredEvents.any((e) => e.title == event.title);
  }
}