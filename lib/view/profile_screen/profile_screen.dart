import 'package:flutter/material.dart';
import 'package:post_data_to_api_sample/controller/profile_screen_controller.dart';
import 'package:post_data_to_api_sample/view/login_screen/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Profile screen to display user details
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Logout method: clears local storage and navigates to login screen
  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  void initState() {
    // Fetch user data after widget build
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProfileScreenController>().getUserData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Profile"),
      
          // Back navigation
          leading: IconButton(
            icon: const Icon(Icons.arrow_circle_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      
        body: Consumer<ProfileScreenController>(
          builder: (context, prfscrnObj, child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
      
                  // Profile image
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        prfscrnObj.responseData?.customerData?.photo != null
                        ? NetworkImage(
                            prfscrnObj.responseData?.customerData?.photo ?? "",
                          )
                        : null,
                    child: prfscrnObj.responseData?.customerData?.photo == null
                        ? const Icon(Icons.person, size: 50)
                        : null,
                  ),
      
                  const SizedBox(height: 15),
      
                  // User full name
                  Text(
                    "${prfscrnObj.responseData?.data?.firstName ?? "No First Name"} ${prfscrnObj.responseData?.data?.lastName ?? "No Last Name"}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
      
                  // Username
                  Text(
                    prfscrnObj.responseData?.data?.username ?? "No Username",
                    style: const TextStyle(color: Colors.grey),
                  ),
      
                  const SizedBox(height: 20),
      
                  // User details card
                  Card(
                    margin: const EdgeInsets.all(12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          row(
                            "Email",
                            prfscrnObj.responseData?.data?.email ?? "No Email",
                          ),
                          row(
                            "Phone",
                            prfscrnObj.responseData?.customerData?.phone
                                    ?.toString() ??
                                "No Phone",
                          ),
                          row(
                            "Address",
                            prfscrnObj.responseData?.customerData?.address ??
                                "No Address",
                          ),
                          row(
                            "Country",
                            prfscrnObj.responseData?.customerData?.countryName ??
                                "No Country",
                          ),
                          row(
                            "State",
                            prfscrnObj.responseData?.customerData?.stateName ??
                                "No State",
                          ),
                          row(
                            "DOB",
                            prfscrnObj.responseData?.customerData?.dateOfBirth !=
                                    null
                                ? "${prfscrnObj.responseData!.customerData!.dateOfBirth!.day}-${prfscrnObj.responseData!.customerData!.dateOfBirth!.month}-${prfscrnObj.responseData!.customerData!.dateOfBirth!.year}"
                                : "",
                          ),
                        ],
                      ),
                    ),
                  ),
      
                  const SizedBox(height: 20),
      
                  // Logout button
                  ElevatedButton.icon(
                    onPressed: signOut, // using reusable method
                    icon: const Icon(Icons.logout),
                    label: const Text("Logout"),
                  ),
      
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// Reusable row widget for displaying label and value
Widget row(String title, String? value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(flex: 3, child: Text(value ?? "-")),
      ],
    ),
  );
}
