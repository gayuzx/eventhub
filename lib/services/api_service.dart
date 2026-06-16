import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event_model.dart';

class ApiService {
  final String baseUrl = "https://jsonplaceholder.typicode.com/posts";

  Future<List<Event>> fetchEvents() async {
  try {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data.map((json) {
  return Event(
    title: json['title'] ?? 'No Title',
    description: json['body'] ?? 'No Description',
    date: '2025-06-15',
    location: 'Chennai',
   imageUrl:
'https://picsum.photos/400/200?random=${json['id']}',
     rating: 4.0,
    category: json['category']??'No category',
    registrationId: "",
  );
}).toList();
    } else {
      throw Exception("Failed to load events");
    }
  } catch (e) {
    throw Exception("Error: $e");
  }
}
}
