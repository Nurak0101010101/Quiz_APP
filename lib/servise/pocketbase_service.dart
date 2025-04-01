import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PocketBaseService {
  static final PocketBaseService _instance = PocketBaseService._internal();
  final PocketBase pb = PocketBase('https://book-shop.fly.dev/');

  factory PocketBaseService() {
    return _instance;
  }

  PocketBaseService._internal();

  Future<void> initAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token != null) {
      pb.authStore.save(token, null);
    }
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token); //save to cache
  }

  Future<void> clearAuth() async {
    pb.authStore.clear(); //clear data from AuthStore
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token'); //clear cache
  }

  bool isAuthenticated() {
    return pb.authStore.isValid;
  }

  Future<Map<String, dynamic>?> getUserData() async {
    try {
      if (pb.authStore.isValid) {
        var userRecord = pb.authStore.record; // Get user from authStore

        if (userRecord == null) {
          // If user data is not available in authStore, fetch manually
          final userId =
              pb.authStore.token; // Extract user ID from token (if applicable)
          final record = await pb
              .collection('quizapp_users')
              .authRefresh(); // Refresh auth data

          userRecord =
              pb.authStore.record; // Now it should contain the user data
        }

        if (userRecord != null) {
          return userRecord.toJson(); // Return user data as Map
        } else {
          throw Exception('User data not found after refresh.');
        }
      } else {
        throw Exception('No authenticated user found');
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }
}

final pocketBaseService = PocketBaseService();