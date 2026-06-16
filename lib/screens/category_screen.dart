import 'package:flutter/material.dart';
import '../models/event_model.dart';
import 'event_details_screen.dart'; // Import details screen

class CategoryScreen extends StatelessWidget {
  final String category;
  CategoryScreen({super.key, required this.category});

  // Sample events list (future la API/DB connect panna mudiyum)
  final Map<String, List<Event>> categoryEvents = {
  "Music": List.generate(
    15,
    (index) => Event(
      title: "Music Fest ${index + 1}",
      description: "Live Music Concert",
      date: "${12 + index} June",
      location: "Chennai",
      imageUrl:
          "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f",
          rating: 4.5,
          category: "Music",
          registrationId:
      "EVT${1000 + index}",
    ),
  ),

  "Tech": List.generate(
    15,
    (index) => Event(
      title: "Tech Conference ${index + 1}",
      description: "Latest Technology Trends",
      date: "${10 + index} July",
      location: "Bangalore",
      imageUrl:
          "https://images.unsplash.com/photo-1516321318423-f06f85e504b3",
          rating: 4.8,
          category: "Tech",
          registrationId:
      "EVT${1000 + index}",
          
    ),
  ),

  "Sports": List.generate(
    15,
    (index) => Event(
      title: "Sports Carnival ${index + 1}",
      description: "Games & Fun Activities",
      date: "${5 + index} August",
      location: "Madurai",
      imageUrl:
          "https://images.unsplash.com/photo-1517649763962-0c623066013b",
          rating: 5.0,
          category: "Sports",
          registrationId:
      "EVT${1000 + index}",
          
    ),
  ),

  "Art": List.generate(
    15,
    (index) => Event(
      title: "Art Expo ${index + 1}",
      description: "Paintings & Sculptures",
      date: "${1 + index} September",
      location: "Coimbatore",
      imageUrl:
          "https://images.unsplash.com/photo-1460661419201-fd4cecdf8a8b",
           rating: 4.5,
          category: "Art",
          registrationId:
      "EVT${1000 + index}",
          
    ),
  ),
};


  @override
  Widget build(BuildContext context) {
    // Filter events based on category
    final filteredEvents = categoryEvents[category] ?? [];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("$category Events"),
        centerTitle: true,
      ),
      body: filteredEvents.isEmpty
          ? const Center(
              child: Text("No events found in this category ❌"),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredEvents.length,
              itemBuilder: (context, index) {
                final event = filteredEvents[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: ClipRRect(
  borderRadius: BorderRadius.circular(8),
  child: Image.network(
    event.imageUrl,
    width: 60,
    height: 60,
    fit: BoxFit.cover,
  ),
),
                    title: Text(event.title,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("${event.date} • ${event.location}"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventDetailsScreen(event: event),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
