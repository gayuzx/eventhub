import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../services/favorite_service.dart';
import '../services/registration_service.dart';
import 'registration_success_screen.dart';
import '../services/notification_service.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
class EventDetailsScreen extends StatefulWidget {
  final Event event;

  const EventDetailsScreen({
    super.key,
    required this.event,
  });

  @override
  State<EventDetailsScreen> createState() =>
      _EventDetailsScreenState();
}

class _EventDetailsScreenState
    extends State<EventDetailsScreen> {
      final TextEditingController reviewController =
    TextEditingController();

List<String> reviews = [];
      double userRating = 0;
      String getCountdown(String dateString) {
  try {
    DateTime eventDate = DateTime.parse(dateString);
    Duration diff = eventDate.difference(DateTime.now());

    if (diff.isNegative) {
      return "Event Started";
    }

    return "${diff.inDays} Days ${diff.inHours % 24} Hours ${diff.inMinutes % 60} Minutes";
  } catch (e) {
    return "20-08-2026";
  }
}
Future<void> openMap(String location) async {
  final Uri url = Uri.parse(
    "https://www.google.com/maps/search/?api=1&query=$location",
  );

  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  }
}

  @override
  Widget build(BuildContext context) {
    final isFavorite =
    FavoriteService.isFavorite(
      widget.event,
    );

    final isRegistered =
    RegistrationService.isRegistered(
      widget.event,
    );
    return Scaffold(
      appBar: AppBar(
        actions: [
  IconButton(
    icon: Icon(
      isFavorite
          ? Icons.favorite
          : Icons.favorite_border,
    ),
    onPressed: () async {
      if (isFavorite) {
        await FavoriteService.removeFavorite(
          widget.event,
        );
      } else {
        await FavoriteService.addFavorite(
          widget.event,
        );
      }

      setState(() {});
    },
  ),
],
        backgroundColor: Colors.blue,
        title: Text(widget.event.title),
        
        
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔵 Event Icon
            // 🖼 Event Image
ClipRRect(
  borderRadius: BorderRadius.circular(12),
  child: Image.network(
    widget.event.imageUrl,
    height: 220,
    width: double.infinity,
    fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) {
      return Container(
        height: 220,
        color: Colors.grey.shade300,
        child: const Center(
          child: Icon(Icons.event, size: 80, color: Colors.blue),
        ),
      );
    },
  ),
  
),
const SizedBox(height: 15),

SizedBox(
height: 80,
child: ListView(
scrollDirection:
Axis.horizontal,
children: [

Image.network(
widget.event.imageUrl,
width: 100,
),

const SizedBox(width: 10),

Image.network(
widget.event.imageUrl,
width: 100,
),

const SizedBox(width: 10),

Image.network(
widget.event.imageUrl,
width: 100,
),
],
),
), 
const SizedBox(height: 20),

            // 📝 Title
            Text(widget.event.title,
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold)),
                    Container(
  padding: const EdgeInsets.symmetric(
    horizontal: 10,
    vertical: 5,
  ),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(20),
  ),
  child: Text(
    widget.event.category,
    style: const TextStyle(
      color: Colors.white,
    ),
  ),
),
                    if (isRegistered)
  Container(
    margin: const EdgeInsets.only(top: 8),
    padding: const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 6,
    ),
    decoration: BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.circular(20),
    ),
    child: const Text(
      "✓ Registered",
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),

                    const SizedBox(height: 8),
                    Container(
  padding: const EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 6,
  ),
 
  child: Text(
    widget.event.getStatus(),
    style: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  ),
),

const SizedBox(height: 10),

Row(
 children: [
   const Icon(
     Icons.star,
     color: Colors.amber,
   ),

   const SizedBox(width: 5),

   Text(
     widget.event.rating.toString(),
     style: const TextStyle(
       fontWeight: FontWeight.bold,
       fontSize: 16,
     ),
   ),
 ],
),

            const SizedBox(height: 10),

            // 📅 Date & Time
            Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.blue),
                const SizedBox(width: 8),
                Text("Date: ${widget.event.date}"),
              ],
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 10),

Row(
  children: [
    const Icon(
      Icons.star,
      color: Colors.amber,
    ),
    const SizedBox(width: 8),
    Text(
      "Rating: ${widget.event.rating}",
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
  ],
),
            

Row(
  children: [
    const Icon(Icons.timer, color: Colors.blue),
    const SizedBox(width: 8),
    Text(
      "Starts in: ${getCountdown(widget.event.date)}",
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
  ],
),
            Row(
              children: [
                const Icon(Icons.access_time, color: Colors.blue),
                const SizedBox(width: 8),
                const Text("Time: 10:00 AM - 5:00 PM"), // Example timing
              ],
            ),

            const SizedBox(height: 10),

            // 📍 Location
            Row(
  children: [
    const Icon(
      Icons.location_on,
      color: Colors.red,
    ),

    const SizedBox(width: 8),

    Expanded(
      child: Text(
        "Location: ${widget.event.location}",
      ),
    ),

    TextButton.icon(
      onPressed: () {
        openMap(
          widget.event.location,
        );
      },
      icon: const Icon(Icons.map),
      label: const Text("Map"),
    ),
  ],
),
            const SizedBox(height: 12),

Row(
  children: [
    const Icon(
      Icons.star,
      color: Colors.amber,
    ),

    const SizedBox(width: 5),

    Text(
      "${widget.event.rating}",
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
  ],
),

            const SizedBox(height: 20),

            // 📖 Description
            // 📖 Description
Text(
  widget.event.description,
  style: const TextStyle(fontSize: 16),
),

const SizedBox(height: 20),
const SizedBox(height: 20),

Text(
"Reviews (${reviews.length})",
style: const TextStyle(
fontSize: 18,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 10),

TextField(
  controller: reviewController,
  decoration: InputDecoration(
    hintText: "Write a review...",
    border: OutlineInputBorder(),
    suffixIcon: IconButton(
      icon: const Icon(Icons.send),
      onPressed: () {
  if (reviewController.text.isNotEmpty) {
    setState(() {
      reviews.add(
        reviewController.text,
      );
    });

    reviewController.clear();
  }
},
    ),
  ),
),
const SizedBox(height: 10),
ListView.builder(
  shrinkWrap: true,
  physics:
      const NeverScrollableScrollPhysics(),
  itemCount: reviews.length,
  itemBuilder: (context, index) {
    return Card(
      child: ListTile(
        leading: const Icon(
          Icons.person,
        ),
        title: Text(
          reviews[index],
        ),
      ),
    );
  },
),

// 👨‍💼 Organizer Details
const SizedBox(height: 20),

const Text(
 "Rate This Event",
 style: TextStyle(
   fontSize: 18,
   fontWeight: FontWeight.bold,
 ),
),

const SizedBox(height: 10),

Row(
 mainAxisAlignment:
     MainAxisAlignment.center,
 children: List.generate(
   5,
   (index) {
     return IconButton(
       icon: Icon(
         userRating > index
             ? Icons.star
             : Icons.star_border,
         color: Colors.amber,
       ),
       onPressed: () {
         setState(() {
           userRating =
               index + 1.0;
         });

         ScaffoldMessenger.of(
                 context)
             .showSnackBar(
           SnackBar(
             content: Text(
               "You rated ${index + 1} ⭐",
             ),
           ),
         );
       },
     );
   },
 ),
),
Card(
elevation: 3,
child: ListTile(
leading: const CircleAvatar(
child: Icon(Icons.person),
),

title: const Text(
"EventHub Team",
),

subtitle: const Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [

Text(
"Official Organizer",
),

Text(
"support@eventhub.com",
),

Text(
"+91 9876543210",
),
],
),

trailing: const Icon(
Icons.verified,
color: Colors.green,
),
),
),

const SizedBox(height: 30),

// Register Button
SizedBox(
        
  ),


const SizedBox(height: 30),

            // 🔘 Register Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.check_circle),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white),
               onPressed: isRegistered
? null
: () async {

bool? confirm =
await showDialog(
context: context,
builder: (_) => AlertDialog(
title: const Text(
"Confirm Registration",
),
content: const Text(
"Do you want to register for this event?",
),
actions: [
TextButton(
onPressed: (){
Navigator.pop(context,false);
},
child: const Text("No"),
),
ElevatedButton(
onPressed: (){
Navigator.pop(context,true);
},
child: const Text("Yes"),
),
],
),
);

if(confirm != true) return; 
                 
                   await RegistrationService.registerEvent(widget.event); 
                   setState(() {}); 
                   await NotificationService.showReminder(
                     widget.event.title,
                      widget.event.date,
                       ); 
                       Navigator.push(
                         context, MaterialPageRoute(
                           builder: (_) => RegistrationSuccessScreen
                           (event: widget.event), 
                           ), 
                           ); 
                           },
                label: Text(
  isRegistered
      ? "Already Registered"
      : "Register for Event",
),
              ),
            ),

            const SizedBox(height: 10),

            // ⭐ Add to Favorites
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.favorite),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    foregroundColor: Colors.white),
                onPressed: () {
                  FavoriteService.addFavorite(widget.event);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Added to Favorites ❤️")),
                  );
                },
                label: const Text("Add to Favorites"),
              ),
            ),

            const SizedBox(height: 10),

            // 📤 Share Event
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.share),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white),
                onPressed: () {
  Share.share(
    '''
🎉 Event: ${widget.event.title}

📅 Date: ${widget.event.date}

📍 Location: ${widget.event.location}

📝 Description:
${widget.event.description}

Shared via EventHub App 🚀
''',
  );
},
                label: const Text("Share Event"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
