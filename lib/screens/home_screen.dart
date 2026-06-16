import 'package:flutter/material.dart';
import 'event_listing_screen.dart';
import 'category_screen.dart'; // Category wise screen create pannuvom
import '../models/event_model.dart';
import 'event_details_screen.dart';
import '../widgets/event_card.dart';
import '../services/favorite_service.dart';
import '../services/registration_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String query = "";

  // Sample events list
  final List<Event> events = [
  Event(
    title: "Music Fest",
    description: "Live music",
    date: "2026-06-12",
    location: "Salem",
    imageUrl:
        "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f",
        rating: 4.5,
        category: "Music",
        registrationId: "EVT1101",
  ),
  Event(
    title: "Tech Conference",
    description: "Latest tech",
    date: "2026-05-12",
    location: "Chennai",
    imageUrl:
        "https://images.unsplash.com/photo-1516321318423-f06f85e504b3",
        rating: 4.8,
        category: "Tech",
        registrationId: "EVT1201",
  ),
  Event(
    title: "Art Expo",
    description: "Paintings & Sculptures",
    date: "2026-06-20",
    location: "Coimbatore",
    imageUrl:
        "https://images.unsplash.com/photo-1460661419201-fd4cecdf8a8b",
        rating: 5.0,
        category: "Art",
        registrationId: "EVT1301",

  ),
  Event(
    title: "Startup Meetup",
    description: "Networking",
    date: "2026-07-21",
    location: "Bangalore",
    imageUrl:
        "https://images.unsplash.com/photo-1521737604893-d14cc237f11d",
        rating: 4.8,
        category: "StartUp",
        registrationId: "EVT1204",
  ),
  Event(
    title: "Sports Carnival",
    description: "Games & Fun",
    date: "2026-08-12",
    location: "Madurai",
    imageUrl:
        "https://images.unsplash.com/photo-1517649763962-0c623066013b",
        rating: 4.7,
        category: "Sports",
        registrationId: "EVT1505",
  ),
];


  @override
  Widget build(BuildContext context) {
    // Filtered events based on search query
    final filteredEvents = events.where((e) =>
    e.title.toLowerCase().contains(query.toLowerCase()) ||
    e.location.toLowerCase().contains(query.toLowerCase())).toList();

final topRatedEvents =
    filteredEvents.where((e) => e.rating >= 4.5).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("EventHub"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Discover & Register Events",
                style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Container(
  width: double.infinity,
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.orange.shade100,
    borderRadius: BorderRadius.circular(12),
  ),
  child: Row(
    children: [
      const Icon(Icons.event_available,
          color: Colors.orange, size: 35),
      const SizedBox(width: 12),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Total Events",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("${events.length} Events Available"),
        ],
      )
    ],
  ),
),

            // 🔍 Search Bar
            TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Search events...",
                prefixIcon: const Icon(Icons.search, color: Colors.blue),
                filled: true,
                fillColor: Colors.blue.withOpacity(0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            Row(
  children: [

    Expanded(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Icon(Icons.event,color: Colors.blue),
              Text("${events.length}"),
              Text("Events"),
            ],
          ),
        ),
      ),
    ),

    Expanded(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Icon(Icons.favorite,color: Colors.red),
              Text(
                "${FavoriteService.getFavorites().length}",
              ),
              Text("Favorites"),
            ],
          ),
        ),
      ),
    ),

    Expanded(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Icon(Icons.check_circle,color: Colors.green),
              Text(
                "${RegistrationService.getRegisteredEvents().length}",
              ),
              Text("Registered"),
            ],
          ),
        ),
      ),
    ),

  ],
),
            const SizedBox(height: 20),


            // 🎭 Categories Section
            const Text("Categories",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: [
                _categoryChip(context, "Music"),
                _categoryChip(context, "Sports"),
                _categoryChip(context, "Tech"),
                _categoryChip(context, "Art"),
              ],
            ),
           if (query.isNotEmpty)
  Text(
    "${filteredEvents.length} Events Found",
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.blue,
    ),
  ),


            const Text(
  "🔥 Trending Events",
  style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 10),

SizedBox(
  height: 250,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: filteredEvents.length,
    itemBuilder: (context, index) {
     final event = filteredEvents[index];
     
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  EventDetailsScreen(event: event),
            ),
          );
        },
        child: Container(
          width: 180,
          margin: const EdgeInsets.only(right: 12),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.network(
                    event.imageUrl,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    event.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(
                          horizontal: 8),
                  child: Text(event.location),
                ),
                Padding(
  padding:
      const EdgeInsets.symmetric(
          horizontal: 8),
  child: Row(
    children: [
      const Icon(
        Icons.star,
        size: 14,
        color: Colors.amber,
      ),

      Text(
        " ${event.rating}",
      ),
    ],
  ),
),
                
                Padding(
                  padding:
                      const EdgeInsets.symmetric(
                          horizontal: 8),
                  child: Text(
                    event.date,
                    style: const TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  ),
),
            const SizedBox(height: 20),
            const Text(
  "Featured Events",
  style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
),
const SizedBox(height: 10),

 if (filteredEvents.isNotEmpty)
  ...filteredEvents.take(2).map(
    (event) => EventCard(event: event),
  ),
const SizedBox(height: 20),

const Text(
  "Upcoming Events",
  style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
),
const SizedBox(height: 10),

...filteredEvents.skip(2).take(2).map(
  (event) => EventCard(event: event),
),

const SizedBox(height: 20),

const Text(
  "Popular Events",
  style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
),
const SizedBox(height: 10),
...filteredEvents.reversed.take(2).map(
  (event) => EventCard(event: event),
),
const SizedBox(height: 20),

const Text(
  "🏆 Top Rated Events",
  style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 10),
        


...topRatedEvents.map(
  (event) => EventCard(event: event),
),




            // 📌 Search Results / Featured Events
            if (query.isNotEmpty &&
    filteredEvents.isEmpty)
  const Padding(
    padding: EdgeInsets.all(20),
    child: Center(
      child: Column(
  children: [
    Icon(
      Icons.search_off,
      size: 80,
      color: Colors.grey,
    ),
    SizedBox(height: 10),
    Text(
      "No Events Found",
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  ],
)
    ),
  ),
            

            const SizedBox(height: 20),

            // View All Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, foregroundColor: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EventListingScreen()),
                  );
                },
                child: const Text("View All Events"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔖 Reusable Event Card
 

  // 🎭 Category Chip Navigation
  Widget _categoryChip(BuildContext context, String category) {
    return ActionChip(
      label: Text(category),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CategoryScreen(category: category)),
        );
      },
    );
  }
}
