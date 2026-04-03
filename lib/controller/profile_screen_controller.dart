import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:post_data_to_api_sample/model/profile_screen_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Controller for fetching user profile data
class ProfileScreenController with ChangeNotifier {
  // Stores API response data
  UserData? responseData;

  // Method to fetch user data from API
  Future<void> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int? userId = prefs.getInt("userId");
    String? token = prefs.getString("token");

    // Check if userId or token is missing
    if (userId == null || token == null) {
      print("User ID or token is null");
      return;
    }

    final url = Uri.parse(
      "https://www.api.viknbooks.com/api/v10/users/user-view/$userId/",
    );

    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );

    // Debug logs (can be removed in production)
    // print(response.statusCode);
    // print("Response received: ${response.body}");
    // print("UserID: $userId");
    // print("Token: $token");

    if (response.statusCode == 200) {
      // Parse API response into model
      responseData = userDataFromJson(response.body);

      // Notify UI to rebuild with new data
      notifyListeners();
    } else {
      print("API failed");
    }
  }
}
