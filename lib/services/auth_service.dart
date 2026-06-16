import 'package:shared_preferences/shared_preferences.dart';
class AuthService {
  static String? user;

  static Future<bool> login(
    String email,
    String password,
  ) async {
    user = email;

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      "logged_user",
      email,
    );

    return true;
  }

  static Future<void> logout() async {
    user = null;

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.remove(
      "logged_user",
    );
  }

  static bool isLoggedIn() =>
      user != null;

  static Future<void> loadUser() async {
    final prefs =
        await SharedPreferences.getInstance();

    user = prefs.getString(
      "logged_user",
    );
  }
}