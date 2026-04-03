import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:post_data_to_api_sample/model/home_screen_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Controller for handling login API and user session
class HomeScreenController with ChangeNotifier {
  PostData? dataResponse;

  // Method to call login API
  Future<bool> postData(String username, String password) async {
    final url = Uri.parse(
      "https://api.accounts.vikncodes.com/api/v1/users/login",
    );

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "password": password,
        "is_mobile": true,
      }),
    );

    // Debug logs (can be removed in production)
    // print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 200) {
      // Parse response to model
      dataResponse = postDataFromJson(response.body);

      // Extract token and user ID
      var jsondata = jsonDecode(response.body);
      String token = jsondata["data"]["access"];
      int userId = jsondata["data"]["user_id"];

      // Save user data locally
      await saveuserData(token, userId);

      // print("TOKEN: $token");
      // print("USER ID: $userId");

      // Check API success status
      if (dataResponse!.success == 6000) {
        return true;
      } else {
        return false;
      }
    }

    return false;
  }
}

// Method to store token and user ID in local storage
Future<void> saveuserData(String token, int userId) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setString("token", token);
  await prefs.setInt("userId", userId);
}
