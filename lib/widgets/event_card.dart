import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../screens/event_details_screen.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(
  event.imageUrl,
  width: 60,
  errorBuilder: (context, error, stackTrace) {
    return const Icon(
      Icons.event,
      size: 50,
    );
  },
),
        title: Text(event.title),
        subtitle: Text(event.date),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => EventDetailsScreen(event: event),
            ),
          );
        },
      ),
    );
  }
}