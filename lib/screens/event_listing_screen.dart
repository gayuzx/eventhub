import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/event_model.dart';
import 'event_details_screen.dart';

class EventListingScreen extends StatefulWidget {
  const EventListingScreen({super.key});

  @override
  State<EventListingScreen> createState() => _EventListingScreenState();
}

class _EventListingScreenState extends State<EventListingScreen> {
  Future<void> refreshEvents() async {
  setState(() {
    futureEvents = ApiService().fetchEvents();
  });

  await futureEvents;
}
  late Future<List<Event>> futureEvents;
  String searchText = "";
  String selectedCategory = "All";

  @override
  void initState() {
    super.initState();
    futureEvents = ApiService().fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("All Events"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Event>>(
        future: futureEvents,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.blue));
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No Events Found"));
          } else {
            final events = snapshot.data!;
            final filteredEvents = events.where((event) {
              final matchSearch = event.title.toLowerCase().contains(searchText.toLowerCase());
              final matchCategory = selectedCategory == "All" ||
                  event.title.toLowerCase().contains(selectedCategory.toLowerCase());
              return matchSearch && matchCategory;
            }).toList();

            return Column(
              children: [
                // 🔍 Search Bar
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search events...",
                      prefixIcon: const Icon(Icons.search, color: Colors.blue),
                       contentPadding: const EdgeInsets.symmetric(
    vertical: 18,
  ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                    },
                  ),
                ),

                // 🏷 Category Filter
                

                const SizedBox(height: 10),

                // 📌 Filtered Event List
                Expanded(
  child: RefreshIndicator(
    onRefresh: refreshEvents,
    child: ListView.builder(
                    itemCount: filteredEvents.length,
                    itemBuilder: (context, index) {
                      final event = filteredEvents[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: ClipRRect(
  borderRadius: BorderRadius.circular(8),
  child: Image.network(
  event.imageUrl,
  width: 90,
  height: 90,
  fit: BoxFit.cover,

  errorBuilder:
      (context, error, stackTrace) {
    return Container(
      width: 90,
      height: 90,
      color: Colors.grey.shade300,
      child: const Icon(
        Icons.image,
        size: 40,
      ),
    );
  },
),
),
                          title: Row(
  children: [
    Expanded(
      child: Text(
        event.title,
        maxLines: 2,
  overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    ),

   
  ],
),
                         subtitle: Column(
  crossAxisAlignment:
      CrossAxisAlignment.start,
  children: [
    Text(
      "${event.date} • ${event.location}",
      style: const TextStyle(
    fontSize: 15,
  ),
    ),
    Text(
  event.category,
  style: const TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.bold,
    fontSize: 15,
  ),
),

    Row(
      children: [
        const Icon(
          Icons.star,
          color: Colors.amber,
          size: 16,
        ),

        Text(
          "${event.rating}",
          style: const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
  ),
        ),
      ],
    ),
  ],
),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EventDetailsScreen(event: event),
    ),
  
  );
}

                        ),
                      );
                    },
                  ),
                ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget categoryButton(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedCategory == title ? Colors.blue : Colors.grey.shade300,
          foregroundColor: selectedCategory == title ? Colors.white : Colors.black,
        ),
        onPressed: () {
          setState(() {
            selectedCategory = title;
          });
        },
        child: Text(title),
      ),
    );
  }
}
