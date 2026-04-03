import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Controller for handling sales list API
class SalesScreenContoller with ChangeNotifier {
  int page = 1;

  // List to store sales data from API
  List salesList = [];

  // Loading state for UI
  bool isLoading = false;

  // Method to fetch sales data with search support
  Future<void> getsalesData(String search) async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse(
      "https://www.api.viknbooks.com/api/v10/sales/sale-list-page/",
    );

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    int? userId = prefs.getInt("userId");

    // API request
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "BranchID": 1,
        "CompanyID": "1901b825-fe6f-418d-b5f0-7223d0040d08",
        "CreatedUserID": userId,
        "PriceRounding": 2,
        "page_no": page,
        "items_per_page": 10,
        "type": "Sales",
        "WarehouseID": 1,
        "search": search,
      }),
    );

    // Debug logs (can be removed in production)
    // print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 200) {
      // Decode response and update list
      var data = jsonDecode(response.body);
      salesList = data["data"];
    }

    // Stop loading and update UI
    isLoading = false;
    notifyListeners();
  }
}
