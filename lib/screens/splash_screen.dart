import 'package:flutter/material.dart';
import 'dart:async';
import 'main_screen.dart';
import '../services/auth_service.dart';
import 'login_screen.dart'; // Next step la create pannuvom

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Auto navigate after 3 seconds
    Timer(const Duration(seconds: 3), () {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => AuthService.isLoggedIn()
          ? const MainScreen()
          : const LoginScreen(),
    ),
  );
});
    }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Blue background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo
            Icon(
              Icons.event, // Temporary logo icon
              size: 100,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            // Welcome Text
            Text(
              "Welcome to EventHub",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Discover & Register Events",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
