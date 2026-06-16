import 'package:flutter/material.dart';
import 'event_details_screen.dart';
import '../models/event_model.dart';
import '../services/registration_service.dart';

class MyRegistrationsScreen extends StatefulWidget {
  const MyRegistrationsScreen({super.key});

  @override
  State<MyRegistrationsScreen> createState() => _MyRegistrationsScreenState();
}

class _MyRegistrationsScreenState extends State<MyRegistrationsScreen> {
  // Sample registered events (later RegistrationService connect pannuvom)
 List<Event> registeredEvents = [];

@override
void initState() {
  super.initState();
  loadData();
}

void loadData() {
  setState(() {
    registeredEvents = RegistrationService.getRegisteredEvents();
  });
}

  void cancelRegistration(int index) {
    final event = registeredEvents[index];
    setState(() async {
 await RegistrationService.cancelRegistration(event);

loadData();

setState(() {});
});
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${event.title} registration cancelled ❌")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("My Registrations"),
        centerTitle: true,
      ),
      body: registeredEvents.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.event_busy, size: 80, color: Colors.grey),
                  SizedBox(height: 10),
                  Text(
                    "No Registrations Found",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: registeredEvents.length,
              itemBuilder: (context, index) {
                final event = registeredEvents[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.event,
                        color: Colors.blue, size: 30),
                    title: Text(
                      event.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [

Text(
"${event.date} • ${event.location}",
),

const SizedBox(height: 5),

Chip(
label: const Text(
"Confirmed",
),
backgroundColor:
Colors.green,
),
],
),
                        
                        onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EventDetailsScreen(event: event),
    ),
  );
},

                    trailing: IconButton(
                      icon: const Icon(Icons.cancel, color: Colors.red),
                      onPressed: () => cancelRegistration(index),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
