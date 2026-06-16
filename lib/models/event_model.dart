class Event {
  final String title;
  final String description;
  final String date;
  final String location;
  final String imageUrl;
  final double rating;
  final String category;
  final String registrationId;
  
   // 🔥 New field

  Event({
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.imageUrl,
    required this.rating,
    required this.category,
    required this.registrationId,
   
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'date': date,
        'location': location,
        'imageUrl': imageUrl,
        'rating': rating,
        'category': category,
        'registrationId': registrationId,
      };

  factory Event.fromJson(Map<String, dynamic> json) {
  return Event(
    title: json['title']?.toString() ?? 'No Title',
    description: json['description']?.toString() ?? 'No Description',
    date: json['date']?.toString() ?? 'Date Not Available',
    location: json['location']?.toString() ?? 'Location Not Available',
    imageUrl: json['imageUrl']?.toString() ?? '',
   rating: double.tryParse(
      json['rating'].toString(),
    ) ??
    0.0,
    category: json['category']?.toString() ?? 'General',
    registrationId:
json['registrationId'] ??
"",
  );
}

@override
bool operator ==(Object other) =>
    identical(this, other) ||
    other is Event &&
        runtimeType == other.runtimeType &&
        title == other.title;

@override
int get hashCode => title.hashCode;
String getStatus() {
  try {
    DateTime eventDate = DateTime.parse(date);

    if (eventDate.isBefore(DateTime.now())) {
      return "Ended";
    }

    Duration diff =
        eventDate.difference(DateTime.now());

    if (diff.inDays <= 2) {
      return "Live";
    }

    return "Upcoming";
  } catch (e) {
    return "Upcoming";
  }
}
  }
