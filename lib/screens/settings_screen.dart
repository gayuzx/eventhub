import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
 
  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // ❌ Cancel
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context); // Close dialog
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Logged out successfully 🚪")),
              );
              Navigator.pop(context); // Navigate back or to login screen
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Provider.of<ThemeProvider>(context).isDark? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // 🌙 Dark Mode Toggle
          SwitchListTile(
            title: const Text("Dark Mode"),
           value:
    Provider.of<ThemeProvider>(
      context,
    ).isDark,
            onChanged: (value) {
  Provider.of<ThemeProvider>(
    context,
    listen: false,
  ).toggleTheme(value);
},
          ),

          const Divider(),

          // ℹ️ About Application
          ListTile(
            leading: const Icon(Icons.info, color: Colors.blue),
            title: const Text("About Application"),
            subtitle: const Text("EventHub v1.0 - Discover & Register Events"),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("About EventHub"),
                  content: const Text(
                      "EventHub is a portfolio-ready Flutter application "
                      "for event discovery, registration, and favorites."),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Close"),
                    ),
                  ],
                ),
              );
            },
          ),

          const Divider(),

          // 🚪 Logout Option with Confirmation
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout"),
            onTap: () => _confirmLogout(context), // ✅ Confirmation dialog
          ),
        ],
      ),
    );
  }
}
