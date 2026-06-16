
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth_service.dart';
import '../services/favorite_service.dart';
import '../services/registration_service.dart';
import 'login_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "Gayathri";
  String email = "gayathri@example.com";
  String phone = "9876543210";
  String profileImageUrl = "assets/avatars/avatar1.png";

  File? profileImage;

  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();

    String? imagePath = prefs.getString("profileImage");

    setState(() {
      name = prefs.getString("name") ?? "Gayathri";
      email = prefs.getString("email") ?? "gayathri@example.com";
      phone = prefs.getString("phone") ?? "9876543210";
      profileImageUrl =
          prefs.getString("avatar") ?? "assets/avatars/avatar1.png";

      if (imagePath != null && imagePath.isNotEmpty) {
        profileImage = File(imagePath);
      }
    });
  }

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString("profileImage", image.path);

      setState(() {
        profileImage = File(image.path);
      });
    }
  }

  void selectAvatar() {
    final avatars = [
      "assets/avatars/avatar1.png",
      "assets/avatars/avatar2.png",
      "assets/avatars/avatar3.png",
      "assets/avatars/avatar4.png",
    ];

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Choose Avatar"),
          content: SizedBox(
            width: 300,
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: avatars.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    final prefs =
                        await SharedPreferences.getInstance();

                    await prefs.setString(
                      "avatar",
                      avatars[index],
                    );

                    setState(() {
                      profileImage = null;
                      profileImageUrl = avatars[index];
                    });

                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: CircleAvatar(
                      backgroundImage:
                          AssetImage(avatars[index]),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _analyticsCard(
    String title,
    String value,
    IconData icon,
  ) {
    return Card(
      elevation: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(title),
        ],
      ),
    );
  }

  Widget _buildTile(
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }

  void _editProfile() {
    TextEditingController nameCtrl =
        TextEditingController(text: name);

    TextEditingController emailCtrl =
        TextEditingController(text: email);

    TextEditingController phoneCtrl =
        TextEditingController(text: phone);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Profile"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(
                  labelText: "Name",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: emailCtrl,
                decoration: const InputDecoration(
                  labelText: "Email",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: phoneCtrl,
                decoration: const InputDecoration(
                  labelText: "Phone",
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              final prefs =
                  await SharedPreferences.getInstance();

              await prefs.setString(
                "name",
                nameCtrl.text,
              );

              await prefs.setString(
                "email",
                emailCtrl.text,
              );

              await prefs.setString(
                "phone",
                phoneCtrl.text,
              );

              setState(() {
                name = nameCtrl.text;
                email = emailCtrl.text;
                phone = phoneCtrl.text;
              });

              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Profile Updated Successfully ✅",
                  ),
                ),
              );
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int registeredCount =
        RegistrationService.getRegisteredEvents().length;

    int favoriteCount =
        FavoriteService.getFavorites().length;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("My Profile"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading:
                                  const Icon(Icons.photo),
                              title:
                                  const Text("Gallery"),
                              onTap: () {
                                Navigator.pop(context);
                                pickImage();
                              },
                            ),
                            ListTile(
                              leading:
                                  const Icon(Icons.person),
                              title:
                                  const Text("Choose Avatar"),
                              onTap: () {
                                Navigator.pop(context);
                                selectAvatar();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: profileImage != null
                          ? FileImage(profileImage!)
                          : AssetImage(profileImageUrl)
                              as ImageProvider,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    email,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  Text(
                    phone,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 15),

const Align(
alignment: Alignment.centerLeft,
child: Text(
"Profile Completion",
),
),

const SizedBox(height: 5),

LinearProgressIndicator(
value: 0.8,
),

const SizedBox(height: 5),

Text("80% Completed"),

                  const SizedBox(height: 15),

                  GridView.count(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 1.8,
                    children: [
                      _analyticsCard(
                        "Registered",
                        "$registeredCount",
                        Icons.event,
                      ),
                      _analyticsCard(
                        "Favorites",
                        "$favoriteCount",
                        Icons.favorite,
                      ),
                      _analyticsCard(
                        "Rating",
                        "4.8",
                        Icons.star,
                      ),
                      _analyticsCard(
                        "Category",
                        "Music",
                        Icons.category,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            _buildTile(
              Icons.edit,
              "Edit Profile",
              _editProfile,
            ),

            _buildTile(
              Icons.settings,
              "Settings",
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const SettingsScreen(),
                  ),
                );
              },
            ),

            _buildTile(
              Icons.info,
              "About App",
              () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("EventHub"),
                    content: const Text(
                      "Event booking & discovery app",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () =>
                            Navigator.pop(context),
                        child: const Text("Close"),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 10),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding:
                        const EdgeInsets.all(14),
                  ),
                  icon: const Icon(Icons.logout),
                  label: const Text("Logout"),
                  onPressed: () async {
                    await AuthService.logout();

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

